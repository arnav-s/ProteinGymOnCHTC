# ProteinGymOnCHTC
This repository can be used to run Protein Gym benchmarks on UW-Madison's CHTC clusters

## Setting up Repository

Clone the repository and run ```git submodule update --init --recursive```

## Usage:

### Splitting Reference Files

Split reference files to pass to different jobs:


``` python scripts/split_proteingym_ref_files.py <path_to_original_ref_file> <output_dir>```

Note: This script requires a python environment with pandas installed

### Submitting a Job 

There is a sample submit file that trains the EVE model on all DMS MSAs in ProteinGym. It can be run using

``` condor_submit ProteinGymCHTC.sub```
