#!/usr/bin/env python3
"""Corner characterization of the bias reference and ring oscillator.

Netlists every tb_*.sch in Schematic/References with Qucs-S, runs it in ngspice at
each process corner, and writes

  Images/Bias_*.png, Images/Osc_*.png     plots used by Characterization.md
  characterization_results.json           every number quoted in the tables
  tb_*.dat.ngspice                        typical-corner datasets, so the
                                          diagrams in the benches are populated

Usage (inside the IIC-OSIC-TOOLS container, from anywhere):

  python3 scripts/characterize.py
  python3 scripts/characterize.py --only tb_vref_temp

Corners: SS and FF skew the FETs, resistors and MIM caps together; SF and FS
skew the FETs only.  Die-to-die FET spread is also sampled by the Monte Carlo
bench using the `statistical` model section.
"""
import argparse
import json
import os
import pathlib
import re
import shutil
import struct
import subprocess
import sys

import numpy as np
import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt

ROOT = pathlib.Path(__file__).resolve().parent.parent
HERE = ROOT / "Schematic" / "References"   # the benches live here
IMAGES = ROOT / "Images"

# name -> (FET section, resistor section, MIM section)
CORNERS = {
    "TT": ("typical", "res_typical", "mimcap_typical"),
    "SS": ("ss", "res_ss", "mimcap_ss"),
    "FF": ("ff", "res_ff", "mimcap_ff"),
    "SF": ("sf", "res_typical", "mimcap_typical"),
    "FS": ("fs", "res_typical", "mimcap_typical"),
}
PLOT_CORNERS = list(CORNERS)
TAPS = [("o07", "0.7 V tap"), ("o20", "2.0 V tap"), ("o30", "3.0 V tap")]

# plot style
SERIES = ["#2a78d6", "#eb6834", "#1baf7a", "#eda100", "#e87ba4"]
SURFACE, INK, INK2, MUTED, GRID = "#fcfcfb", "#0b0b0b", "#52514e", "#898781", "#e6e5e1"
plt.rcParams.update({
    "figure.facecolor": SURFACE, "axes.facecolor": SURFACE, "savefig.facecolor": SURFACE,
    "axes.edgecolor": GRID, "axes.labelcolor": INK2, "axes.titlecolor": INK,
    "xtick.color": MUTED, "ytick.color": MUTED, "xtick.labelcolor": INK2, "ytick.labelcolor": INK2,
    "axes.grid": True, "grid.color": GRID, "grid.linewidth": 0.8, "grid.linestyle": "-",
    "axes.spines.top": False, "axes.spines.right": False,
    "lines.linewidth": 2, "lines.solid_capstyle": "round", "lines.solid_joinstyle": "round",
    "font.size": 10, "axes.titlesize": 11, "axes.titleweight": "bold", "axes.titlelocation": "left",
    "legend.frameon": False, "legend.fontsize": 9, "figure.dpi": 130,
})


# ----------------------------------------------------------------------------
# running
# ----------------------------------------------------------------------------
def sh(cmd, cwd=None, timeout=3600):
    return subprocess.run(cmd, cwd=cwd, timeout=timeout, stdout=subprocess.PIPE,
                          stderr=subprocess.STDOUT, text=True, errors="replace")


def netlist(bench, build):
    """Qucs-S schematic -> ngspice netlist."""
    out = build / f"{bench}.cir"
    env = dict(os.environ)
    env.setdefault("DISPLAY", ":1")
    env.setdefault("QT_QPA_PLATFORM", "offscreen")
    subprocess.run(["qucs-s", "-n", "--ngspice", "-i", str(HERE / f"{bench}.sch"), "-o", str(out)],
                   cwd=HERE, env=env, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=120)
    if not out.exists() or ".control" not in out.read_text():
        sys.exit(f"qucs-s failed to netlist {bench}.sch")
    return out.read_text()


def models(pdk, corner, statistical=False):
    fet, res, mim = CORNERS[corner]
    if statistical:
        fet = "statistical"
    lib = f"{pdk}/sm141064.ngspice"
    return "\n".join([f".include {pdk}/design.ngspice", f".lib {lib} {fet}", f".lib {lib} {res}",
                      f".lib {lib} {mim}", f".lib {lib} cap_mim", ""])


def run(bench, cir, pdk, build, corner="TT", temp=None, subs=(), tag="", statistical=False):
    """Run one netlist variant.  Returns (vectors, log text)."""
    d = build / f"{bench}_{corner}{tag}"
    shutil.rmtree(d, ignore_errors=True)
    d.mkdir(parents=True)
    (d / "models.spice").write_text(models(pdk, corner, statistical))
    cir = re.sub(r'\.INCLUDE "[^"]*gf180mcu_models\.spice"', '.INCLUDE "models.spice"', cir)
    if temp is not None:
        cir = cir.replace(".control", f".temp {temp}\n.control", 1)
    for pat, rep in subs:
        cir, n = re.subn(pat, rep, cir)
        if not n:
            sys.exit(f"{bench}: substitution {pat!r} did not match")
    (d / f"{bench}.cir").write_text(cir)
    r = sh(["ngspice", "-b", f"{bench}.cir"], cwd=d)
    (d / "ngspice.log").write_text(r.stdout)
    raw = d / f"{bench}.raw"
    if not raw.exists():
        sys.exit(f"{bench} [{corner}{tag}] produced no data, see {d}/ngspice.log")
    return read_raw(raw), r.stdout


def read_raw(path):
    """ngspice binary rawfile -> {name: array}; '_order' keeps the column order."""
    blob = path.read_bytes()
    head, _, data = blob.partition(b"Binary:\n")
    names, nvar, npts, cplx, invars = [], 0, 0, False, False
    for line in head.decode(errors="replace").splitlines():
        if line.startswith("No. Variables:"):
            nvar = int(line.split(":")[1])
        elif line.startswith("No. Points:"):
            npts = int(line.split(":")[1])
        elif line.startswith("Flags:"):
            cplx = "complex" in line
        elif line.startswith("Variables:"):
            invars = True
        elif invars and line.strip():
            names.append(line.split()[1].lower())
    width = 2 if cplx else 1
    arr = np.frombuffer(data[: 8 * nvar * npts * width], dtype="<f8").reshape(npts, nvar * width)
    out = {"_order": names}
    for i, n in enumerate(names):
        out[n] = arr[:, 2 * i].copy() if cplx else arr[:, i].copy()   # every vector we write is real
    for n in names:                      # v(x) is also reachable as plain x
        if n.startswith("v(") and n[2:-1] not in out:
            out[n[2:-1]] = out[n]
    return out


def write_qucs_dataset(bench, v):
    """Typical-corner data in the dataset format Qucs-S writes after a run."""
    order = v["_order"]
    x = order[0]
    pre = {"time": "tran.", "frequency": "ac."}.get(x, "")
    xname = x
    lines = ["<Qucs Dataset 26.1.1>", f"<indep {xname} {len(v[x])}>"]
    lines += [f"{a:.12e}" for a in v[x]] + ["</indep>"]
    for n in order[1:]:
        lines.append(f"<dep {pre}{n} {xname}>")
        lines += [f"{a:.12e}" for a in v[n]]
        lines.append("</dep>")
    (HERE / f"{bench}.dat.ngspice").write_text("\n".join(lines) + "\n")


def meas(log, name):
    m = re.findall(rf"^{name}\s*=\s*([-+0-9.eE]+)", log, flags=re.M)
    return float(m[-1]) if m else None


# ----------------------------------------------------------------------------
# small helpers
# ----------------------------------------------------------------------------
def at(x, y, x0):
    return float(np.interp(x0, x, y))


def panels(n, title, w=4.1, h=3.3):
    fig, axes = plt.subplots(1, n, figsize=(w * n, h), squeeze=False)
    fig.suptitle(title, x=0.01, ha="left", fontsize=12, fontweight="bold", color=INK)
    return fig, list(axes[0])


def finish(fig, name, legend_ax=None):
    if legend_ax is not None:
        legend_ax.legend(loc="best")
    fig.tight_layout(rect=(0, 0, 1, 0.95))
    IMAGES.mkdir(exist_ok=True)
    fig.savefig(IMAGES / name)
    plt.close(fig)
    print("  wrote Images/" + name)


def corner_lines(ax, data, xkey, ykey, scale=1.0, corners=PLOT_CORNERS):
    for c, col in zip(corners, SERIES):
        ax.plot(data[c][xkey], data[c][ykey] * scale, color=col, label=c)


def r3(x):
    return None if x is None else float(f"{x:.4g}")


# ----------------------------------------------------------------------------
# benches
# ----------------------------------------------------------------------------
def b_vref_supply(ctx):
    d = ctx.corners("tb_vref_supply")
    fig, axs = panels(3, "Bias reference: tap voltage against supply (27 °C)")
    res = {}
    for ax, (t, lab) in zip(axs, TAPS):
        corner_lines(ax, d, "v-sweep", f"v({t})")
        ax.set_title(lab); ax.set_xlabel("VDD (V)"); ax.set_ylabel("tap voltage (V)")
    finish(fig, "Bias_Supply.png", axs[0])
    for c, v in d.items():
        x = v["v-sweep"]
        res[c] = {"idd_uA_5V": r3(at(x, v["idd"], 5.0)), "iref_uA_5V": r3(at(x, v["iref"], 5.0))}
        for t, _ in TAPS:
            y = v[f"v({t})"]
            v5 = at(x, y, 5.0)
            res[c][t] = {"v_5V": r3(v5), "v_3V3": r3(at(x, y, 3.3)), "v_4V5": r3(at(x, y, 4.5)),
                         "v_5V5": r3(at(x, y, 5.5)),
                         "line_reg_mV_per_V": r3((at(x, y, 5.5) - at(x, y, 4.5)) * 1e3),
                         "line_reg_pct_per_V": r3((at(x, y, 5.5) - at(x, y, 4.5)) / v5 * 100)}
    fig, axs = panels(2, "Bias reference: current against supply (27 °C)")
    corner_lines(axs[0], d, "v-sweep", "iref"); axs[0].set_title("beta-multiplier Iref")
    corner_lines(axs[1], d, "v-sweep", "idd"); axs[1].set_title("total supply current")
    for ax in axs:
        ax.set_xlabel("VDD (V)"); ax.set_ylabel("current (µA)")
    finish(fig, "Bias_Supply_Current.png", axs[0])
    return res


def b_vref_temp(ctx):
    d = ctx.corners("tb_vref_temp")
    fig, axs = panels(3, "Bias reference: tap drift against temperature (VDD = 5 V)")
    res = {}
    for ax, (t, lab) in zip(axs, TAPS):
        corner_lines(ax, d, "temp-sweep", "d" + t[1:])
        ax.set_title(lab); ax.set_xlabel("temperature (°C)"); ax.set_ylabel("change from 27 °C (%)")
    finish(fig, "Bias_Temp.png", axs[0])
    for c, v in d.items():
        x = v["temp-sweep"]
        res[c] = {"idd_uA_min": r3(v["idd"].min()), "idd_uA_max": r3(v["idd"].max())}
        for t, _ in TAPS:
            y = v[f"v({t})"]
            res[c][t] = {"v_m25": r3(at(x, y, -25)), "v_27": r3(at(x, y, 27)), "v_125": r3(at(x, y, 125)),
                         "v_min": r3(y.min()), "v_max": r3(y.max()),
                         "spread_mV": r3((y.max() - y.min()) * 1e3),
                         "tc_ppm_per_C": r3((y.max() - y.min()) / at(x, y, 27) / 150 * 1e6)}
    return res


def b_vref_powerup(ctx):
    d = ctx.corners("tb_vref_powerup")
    fig, axs = panels(3, "Bias reference: power-up, VDD ramps 0 to 5 V in 1 µs (27 °C)")
    res = {}
    for ax, (t, lab) in zip(axs, TAPS):
        ax.plot(d["TT"]["time"] * 1e6, d["TT"]["v(vdd)"], color=GRID, label="VDD")
        for c, col in zip(PLOT_CORNERS, SERIES):
            ax.plot(d[c]["time"] * 1e6, d[c][f"v({t})"], color=col, label=c)
        ax.set_xlim(0, 4); ax.set_title(lab); ax.set_xlabel("time (µs)"); ax.set_ylabel("voltage (V)")
    finish(fig, "Bias_Powerup.png", axs[0])
    for c, v in d.items():
        res[c] = {}
        for t, _ in TAPS:
            x, y = v["time"], v[f"v({t})"]
            fin = y[-1]
            out = np.where(np.abs(y / fin - 1) > 0.01)[0]
            res[c][t] = {"final_V": r3(fin), "settle_1pct_us": r3(x[out[-1] + 1] * 1e6 if len(out) else 0),
                         "overshoot_pct": r3(max(0.0, (y.max() / fin - 1) * 100))}
    return res


def b_vref_load(ctx):
    d = ctx.corners("tb_vref_load")
    fig, axs = panels(3, "Bias reference: droop against DC load on every tap (VDD = 5 V, 27 °C)")
    res = {}
    for ax, (t, lab) in zip(axs, TAPS):
        corner_lines(ax, d, "v-sweep", "d" + t[1:])
        ax.set_title(lab); ax.set_xlabel("load current per tap (µA)"); ax.set_ylabel("change in tap voltage (mV)")
    finish(fig, "Bias_Load.png", axs[0])
    for c, v in d.items():
        x = v["v-sweep"]
        res[c] = {}
        for t, _ in TAPS:
            y = v["d" + t[1:]]
            res[c][t] = {"droop_mV_1uA": r3(at(x, y, 1)), "droop_mV_5uA": r3(at(x, y, 5)),
                         "droop_mV_10uA": r3(at(x, y, 10)), "droop_mV_20uA": r3(at(x, y, 20)),
                         "rout_ohm_0to1uA": r3(-at(x, y, 1) * 1e-3 / 1e-6)}
    return res


def b_vref_psrr(ctx):
    d = ctx.corners("tb_vref_psrr")
    fig, axs = panels(3, "Bias reference: supply rejection (VDD = 5 V, 27 °C)")
    res = {}
    for ax, (t, lab) in zip(axs, TAPS):
        corner_lines(ax, d, "frequency", "psrr" + t[1:])
        ax.set_xscale("log"); ax.set_title(lab); ax.set_xlabel("frequency (Hz)"); ax.set_ylabel("PSRR (dB)")
    finish(fig, "Bias_PSRR.png", axs[0])
    for c, v in d.items():
        x = v["frequency"]
        res[c] = {}
        for t, _ in TAPS:
            y = v["psrr" + t[1:]]
            lx = np.log10(x)
            res[c][t] = {"dB_10Hz": r3(at(lx, y, 1)), "dB_1kHz": r3(at(lx, y, 3)), "dB_100kHz": r3(at(lx, y, 5)),
                         "dB_1MHz": r3(at(lx, y, 6)), "dB_100MHz": r3(at(lx, y, 8)), "dB_1GHz": r3(at(lx, y, 9)),
                         "worst_dB": r3(y.min()), "worst_at_Hz": r3(x[int(np.argmin(y))])}
    return res


def b_vref_noise(ctx):
    d = ctx.corners("tb_vref_noise")
    fig, axs = panels(3, "Bias reference: output noise density (VDD = 5 V, 27 °C)")
    res = {}
    for ax, (t, lab) in zip(axs, TAPS):
        corner_lines(ax, d, "frequency", "n" + t[1:])
        ax.set_xscale("log"); ax.set_yscale("log")
        ax.set_title(lab); ax.set_xlabel("frequency (Hz)"); ax.set_ylabel("noise density (nV/√Hz)")
    finish(fig, "Bias_Noise.png", axs[0])
    for c, v in d.items():
        x = v["frequency"]
        res[c] = {}
        for t, _ in TAPS:
            y = v["n" + t[1:]]
            lx = np.log10(x)
            p = (y * 1e-9) ** 2

            def band(f1, f2):
                m = (x >= f1) & (x <= f2)
                return float(np.sqrt(np.sum(0.5 * (p[m][1:] + p[m][:-1]) * np.diff(x[m]))) * 1e6)
            res[c][t] = {"nV_10Hz": r3(at(lx, y, 1)), "nV_1kHz": r3(at(lx, y, 3)), "nV_100kHz": r3(at(lx, y, 5)),
                         "nV_10MHz": r3(at(lx, y, 7)),
                         "uVrms_1Hz_100MHz": r3(ctx.logs["tb_vref_noise"][c] and meas(ctx.logs["tb_vref_noise"][c], "tot" + t[1:])),
                         "uVrms_10Hz_100kHz": r3(band(10, 1e5))}
    return res


def b_vref_loadstep(ctx):
    d = ctx.corners("tb_vref_loadstep")
    caps = [("a", "no added C"), ("b", "1 pF"), ("c", "10 pF"), ("d", "100 pF")]
    fig, axs = panels(3, "Bias reference: 10 µA load step against load capacitance (TT, 5 V, 27 °C)")
    for ax, (t, lab) in zip(axs, TAPS):
        v = d["TT"]
        for (k, cl), col in zip(caps, SERIES):
            ax.plot(v["time"] * 1e6, (v[k + t[1:]] - v[k + t[1:]][0]) * 1e3, color=col, label=cl)
        ax.set_title(lab); ax.set_xlabel("time (µs)"); ax.set_ylabel("change in tap voltage (mV)")
    finish(fig, "Bias_Load_Step.png", axs[0])
    res = {}
    for c, v in d.items():
        x = v["time"]
        res[c] = {}
        for t, _ in TAPS:
            res[c][t] = {}
            for k, cl in caps:
                y = (v[k + t[1:]] - v[k + t[1:]][0]) * 1e3
                on = (x > 2e-6) & (x < 6e-6)
                settled = float(np.mean(y[(x > 5.5e-6) & (x < 6e-6)]))
                res[c][t][cl] = {"peak_dip_mV": r3(y[on].min()), "settled_mV": r3(settled),
                                 "release_overshoot_mV": r3(y[x > 6e-6].max())}
    return res


def _mc_stats(v):
    out = {}
    for k in ("o07", "o20", "o30", "idd"):
        y = v[k]
        out[k] = {"mean": r3(y.mean()), "sigma": r3(y.std(ddof=1)), "min": r3(y.min()), "max": r3(y.max()),
                  "sigma_pct": r3(100 * y.std(ddof=1) / y.mean()), "n": int(len(y))}
    return out


def b_vref_mc(ctx):
    cir = ctx.cir("tb_vref_mc")
    mm, _ = run("tb_vref_mc", cir, ctx.pdk, ctx.build, tag="_mismatch")
    gl, _ = run("tb_vref_mc", cir, ctx.pdk, ctx.build, tag="_global", statistical=True,
                subs=[(r"(?im)^\.PARAM\s+sw_stat_global\s*=\s*0", ".PARAM sw_stat_global=1")])
    for name, v, title in (("Bias_MC_Mismatch.png", mm, "mismatch only"),
                           ("Bias_MC_Global.png", gl, "die-to-die process + mismatch")):
        fig, axs = panels(3, f"Bias reference Monte Carlo, {len(v['o07'])} runs: {title} (TT resistors, 5 V, 27 °C)")
        for ax, (t, lab) in zip(axs, TAPS):
            y = v[t]
            ax.hist(y, bins=30, color=SERIES[0], edgecolor=SURFACE, linewidth=1)
            ax.set_title(f"{lab}: mean {y.mean():.3f} V, σ {y.std(ddof=1) * 1e3:.1f} mV")
            ax.set_xlabel("tap voltage (V)"); ax.set_ylabel("runs")
        finish(fig, name)
    return {"mismatch": _mc_stats(mm), "global_and_mismatch": _mc_stats(gl)}


def b_beta_supply(ctx):
    d = ctx.corners("tb_beta_mult_supply")
    t = ctx.corners("tb_beta_mult_temp")
    s = ctx.corners("tb_beta_mult_startup")
    fig, axs = panels(3, "Beta-multiplier current reference")
    corner_lines(axs[0], d, "v-sweep", "iref"); axs[0].set_title("Iref against supply (27 °C)"); axs[0].set_xlabel("VDD (V)")
    corner_lines(axs[1], t, "temp-sweep", "iref"); axs[1].set_title("Iref against temperature (5 V)"); axs[1].set_xlabel("temperature (°C)")
    v = s["TT"]
    axs[2].plot(v["time"] * 1e6, v["iref_on"], color=SERIES[0], label="start-up connected")
    axs[2].plot(v["time"] * 1e6, v["iref_off"], color=SERIES[1], label="start-up disabled")
    axs[2].set_title("start-up from the zero-current state (TT)"); axs[2].set_xlabel("time (µs)")
    for ax in axs:
        ax.set_ylabel("Iref (µA)")
    axs[0].legend(loc="best"); axs[2].legend(loc="best")
    finish(fig, "Bias_Beta_Multiplier.png")
    res = {}
    for c in d:
        x, y = d[c]["v-sweep"], d[c]["iref"]
        tx, ty = t[c]["temp-sweep"], t[c]["iref"]
        sv = s[c]
        fin = sv["iref_on"][-1]
        out = np.where(np.abs(sv["iref_on"] / fin - 1) > 0.02)[0]
        res[c] = {"iref_uA_5V": r3(at(x, y, 5)), "iref_uA_4V5": r3(at(x, y, 4.5)), "iref_uA_5V5": r3(at(x, y, 5.5)),
                  "iref_uA_3V3": r3(at(x, y, 3.3)),
                  "supply_sens_pct_per_V": r3(100 * (at(x, y, 5.5) - at(x, y, 4.5)) / at(x, y, 5)),
                  "iref_uA_m25": r3(at(tx, ty, -25)), "iref_uA_27": r3(at(tx, ty, 27)), "iref_uA_125": r3(at(tx, ty, 125)),
                  "idd_uA_27": r3(at(tx, t[c]["idd"], 27)),
                  "startup_settle_2pct_us": r3(sv["time"][out[-1] + 1] * 1e6 if len(out) else 0),
                  "iref_uA_without_startup": r3(sv["iref_off"][-1])}
    return res


def b_inv(ctx):
    d = ctx.corners("tb_inv_vtc")
    res = {}
    for c, v in d.items():
        x, y, g = v["v-sweep"], v["v(out)"], v["gain"]
        res[c] = {"vm_V": r3(x[int(np.argmin(np.abs(y - x)))]), "peak_gain": r3(g.max())}
    return res


def b_ringosci(ctx):
    cir = ctx.cir("tb_ringosci_tune")
    res = {"tune": {}, "temp": {}, "supply": {}}
    fig, axs = panels(3, "Ring oscillator: LO frequency against control current")

    def tune(**kw):
        v, _ = run("tb_ringosci_tune", cir, ctx.pdk, ctx.build, **kw)
        return v["ictl"], v["fosc"], v["idd"]

    for (c, col) in zip(PLOT_CORNERS, SERIES):
        x, f, i = tune(corner=c)
        axs[0].plot(x, f, color=col, marker="o", ms=4, label=c)
        res["tune"][c] = {"ictl_uA": [r3(a) for a in x], "fosc_GHz": [r3(a) for a in f], "idd_mA": [r3(a) for a in i]}
        if c == "TT":
            ctx.dataset("tb_ringosci_tune", {"_order": ["ictl", "fosc", "idd"], "ictl": x, "fosc": f, "idd": i})
    axs[0].set_title("process corner (5 V, 27 °C)")
    for (T, col) in zip((-25, 27, 125), SERIES):
        x, f, i = tune(temp=T, tag=f"_T{T}")
        axs[1].plot(x, f, color=col, marker="o", ms=4, label=f"{T} °C")
        res["temp"][str(T)] = {"ictl_uA": [r3(a) for a in x], "fosc_GHz": [r3(a) for a in f]}
    axs[1].set_title("temperature (TT, 5 V)")
    for (V, col) in zip((4.5, 5.0, 5.5), SERIES):
        x, f, i = tune(tag=f"_V{V}", subs=[(r"(?im)^\.PARAM\s+vsup\s*=\s*5", f".PARAM vsup={V}")])
        axs[2].plot(x, f, color=col, marker="o", ms=4, label=f"{V} V")
        res["supply"][str(V)] = {"ictl_uA": [r3(a) for a in x], "fosc_GHz": [r3(a) for a in f]}
    axs[2].set_title("supply (TT, 27 °C)")
    for ax in axs:
        ax.set_xlabel("control current (µA)"); ax.set_ylabel("LO frequency (GHz)"); ax.legend(loc="best")
        ax.set_ylim(bottom=0)
    finish(fig, "Osc_Tuning.png")

    d = ctx.corners("tb_ringosci")
    v = d["TT"]
    fig, axs = panels(2, "Ring oscillator: start-up and enable / disable through the control current (TT, 5 V, 27 °C)", w=6)
    axs[0].plot(v["time"] * 1e9, v["v(lo)"], color=SERIES[0])
    axs[0].set_xlim(0, 12); axs[0].set_title("LO output from power-up, Ictl = 80 µA, 50 fF load")
    e = ctx.corners("tb_ringosci_disable")
    v = e["TT"]
    axs[1].plot(v["time"] * 1e9, v["v(lo)"], color=SERIES[0])
    axs[1].set_title("Ictl on 0–20 ns, off 20–40 ns, on again at 40 ns")
    for ax in axs:
        ax.set_xlabel("time (ns)"); ax.set_ylabel("LO (V)")
    finish(fig, "Osc_Transient.png")
    res["nominal"] = {}
    for c in d:
        lg, le = ctx.logs["tb_ringosci"][c], ctx.logs["tb_ringosci_disable"][c]
        lo = d[c]["v(lo)"][d[c]["time"] > 10e-9]
        off = e[c]["v(lo)"][(e[c]["time"] > 30e-9) & (e[c]["time"] < 40e-9)]
        res["nominal"][c] = {"fosc_GHz_80uA": r3(meas(lg, "fosc_ghz")), "lo_high_V": r3(lo.max()), "lo_low_V": r3(lo.min()),
                             "idd_mA_running": r3(meas(le, "idd_on")), "idd_mA_disabled": r3(meas(le, "idd_off")),
                             "lo_V_while_disabled_min": r3(off.min()), "lo_V_while_disabled_max": r3(off.max()),
                             "restart_ns": r3((meas(le, "t_restart") - 40e-9) * 1e9 if meas(le, "t_restart") else None)}
    return res


BENCHES = [("vref_supply", b_vref_supply), ("vref_temp", b_vref_temp), ("vref_powerup", b_vref_powerup),
           ("vref_load", b_vref_load), ("vref_loadstep", b_vref_loadstep), ("vref_psrr", b_vref_psrr),
           ("vref_noise", b_vref_noise), ("vref_mc", b_vref_mc), ("beta_mult", b_beta_supply),
           ("inv", b_inv), ("ringosci", b_ringosci)]


class Ctx:
    def __init__(self, pdk, build):
        self.pdk, self.build, self._cir, self.logs = pdk, build, {}, {}

    def cir(self, bench):
        if bench not in self._cir:
            self._cir[bench] = netlist(bench, self.build)
        return self._cir[bench]

    def dataset(self, bench, v):
        write_qucs_dataset(bench, v)

    def corners(self, bench):
        out, self.logs[bench] = {}, {}
        for c in CORNERS:
            out[c], self.logs[bench][c] = run(bench, self.cir(bench), self.pdk, self.build, corner=c)
        self.dataset(bench, out["TT"])
        return out


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--pdk", default="/foss/pdks/gf180mcuD/libs.tech/ngspice")
    ap.add_argument("--build", default="/tmp/cmos_lnb_characterize")
    ap.add_argument("--only", action="append", help="bench group to run (repeatable): " + ", ".join(n for n, _ in BENCHES))
    a = ap.parse_args()
    build = pathlib.Path(a.build)
    build.mkdir(parents=True, exist_ok=True)
    ctx = Ctx(a.pdk, build)
    out = HERE / "characterization_results.json"
    results = json.loads(out.read_text()) if out.exists() else {}
    for name, fn in BENCHES:
        if a.only and name not in a.only:
            continue
        print(name)
        results[name] = fn(ctx)
    out.write_text(json.dumps(results, indent=1) + "\n")
    print("wrote", out.relative_to(ROOT))


if __name__ == "__main__":
    main()
