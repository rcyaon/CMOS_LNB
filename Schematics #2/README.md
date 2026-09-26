stuff here isn't converted to qucs so putting it in a separate folder 

| cell | what it is |
| --- | --- |
| `beta_mult` | constant-gm current reference |
| `vref`      | tapped poly string, three buffered outputs |
| `ota5`      | 5T OTA, unity-gain buffer for `vref`       |
| `dstage`    | differential ring-oscillator stage         |
| `inv`       | CMOS inverter                               |
| `ringosci`  | three-inverter ring                         |