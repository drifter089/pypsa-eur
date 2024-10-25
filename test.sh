#!/bin/bash

ls

pip install git+https://github.com/open-energy-transition/linopy.git@only-generate-problem-files --no-deps

conda install -c conda-forge time

cp bench.py pypsa-eur/scripts/solve_network.py

cat pypsa-eur/scripts/solve_network.py 

cd pypsa-eur

BENCHMARK_DIR="../solver-benchmark/benchmarks/pypsa"

time python "$BENCHMARK_DIR/pypsa-gas+wind+sol+ely-1-1h.py"

time python "$BENCHMARK_DIR/pypsa-gas+wind+sol+ely-ucgas-1-1h.py"

time snakemake -call all --cores all --printshellcmds --configfile "$BENCHMARK_DIR/pypsa-eur-elec-trex-10-3h.yaml" ; echo -e '\a'    

time snakemake -call all --cores all --printshellcmds --configfile "$BENCHMARK_DIR/pypsa-eur-sec-2-3h.yaml" ; echo -e '\a'

time snakemake -call all --cores all --printshellcmds --configfile "$BENCHMARK_DIR/pypsa-eur-elec-op-20-3h.yaml" ; echo -e '\a'

time snakemake -call all --cores all --printshellcmds --configfile "$BENCHMARK_DIR/pypsa-eur-elec-op-ucconv-20-3h.yaml" ; echo -e '\a'

cd ..

ls -R /tmp




