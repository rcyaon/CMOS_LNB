#!/usr/bin/env bash
# Netlist schematics with Qucs-S and place their devices into Layout/<cell>.gds
# with scripts/place_instances.py (unrouted, see that file).
#
#   scripts/place_layout.sh                 # error amplifier, then LDO
#   scripts/place_layout.sh "Schematic/LDO/ReferenceMkI.sch"
#
# Give children before parents: a parent reads its children's .gds from
# Layout/. The cell name is the schematic's file name without .sch.
#
# Runs directly inside the IIC-OSIC-TOOLS container. On the host it copies
# the repo into the container ($OSIC_CONTAINER, default
# iic-osic-tools_xvnc_uid_501), runs there and copies Layout/*.gds back.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [ $# -eq 0 ]; then
    set -- "Schematic/Error Amplifier/ErrorAmplifierNMOSMkI.sch" \
           "Schematic/LDO/LDOMkI.sch"
fi

PDK_ROOT="${PDK_ROOT:-/foss/pdks}"
if [ ! -d "$PDK_ROOT/gf180mcuD/libs.tech/klayout" ]; then
    C="${OSIC_CONTAINER:-iic-osic-tools_xvnc_uid_501}"
    docker start "$C" >/dev/null
    W="/tmp/cmos_lnb_layout.$$"
    docker exec "$C" mkdir -p "$W"
    (cd "$ROOT" && COPYFILE_DISABLE=1 tar cf - --no-xattrs Schematic scripts \
        $( [ -d Layout ] && echo Layout )) | docker exec -i "$C" tar xf - -C "$W"
    docker exec "$C" bash -lc "cd $W && bash scripts/place_layout.sh $(printf '%q ' "$@")"
    mkdir -p "$ROOT/Layout"
    docker exec "$C" bash -c "cd $W/Layout && tar cf - *.gds" | tar xf - -C "$ROOT/Layout"
    docker exec "$C" rm -rf "$W"
    exit 0
fi

export PATH="/foss/tools/klayout:/foss/tools/bin:$PATH"
export DISPLAY="${DISPLAY:-:1}"
export USER="${USER:-designer}"   # gdsfactory PCells need a user name
export KLAYOUT_PATH="$PDK_ROOT/gf180mcuD/libs.tech/klayout"
BUILD="$(mktemp -d)"
trap 'rm -rf "$BUILD"' EXIT
mkdir -p "$ROOT/Layout"

for sch in "$@"; do
    cell="$(basename "$sch" .sch)"
    cir="$BUILD/$cell.cir"
    # Qucs-S resolves subcircuit paths from the repo root.
    (cd "$ROOT" && qucs-s -n --ngspice -i "$sch" -o "$cir") >/dev/null 2>&1 \
        || { echo "place_layout: qucs-s could not netlist $sch" >&2; exit 1; }
    rm -f "$ROOT/Layout/$cell.gds"
    klayout -zz -r "$ROOT/scripts/place_instances.py" \
        -rd netlist="$cir" -rd cell="$cell" -rd libdir="$ROOT/Layout" 2>&1 \
        | grep -v '^##\|^registered KLayout library\|^(' || true
    [ -s "$ROOT/Layout/$cell.gds" ] || { echo "place_layout: $cell failed" >&2; exit 1; }
done
