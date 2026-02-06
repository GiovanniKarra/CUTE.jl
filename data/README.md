This directory contains all the CUTE problems in AMPL's NL format, which can be read using JuMP, aswell as scripts to automate the process of updating the database: 

- `scraper.jl` scraps [this web page](https://arnold-neumaier.at/glopt/coconut/Benchmark/Library2_new_v1.html) and saves the main table into `collection.csv` in CSV format

- `download.jl` uses the `Problem` column `collection.csv` to get the problem names, and then fetches the ampl files from `https://vanderbei.princeton.edu/ampl/nlmodels/cute/{name}.mod`

- `mod_to_nl.sh` is a shell script that converts all `.mod` files in `AMPL/` to `.nl` files in `NL/`. It requires the `ampl` binary to be installed at `/opt/ampl/ampl`

Some problems can't be loaded for the moment because JuMP's NL parser can't read problems where variables are defined using other variables ([see this issue](https://github.com/jump-dev/MathOptInterface.jl/issues/2937))
