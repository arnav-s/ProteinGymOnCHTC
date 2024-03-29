#!/bin/bash

# Setup ProteinGym Repo
git submodule update --init --recursive

# Download ProteinGym DMS data

datasets=("DMS_ProteinGym_substitutions" "DMS_msa_files")

for zipfile in "${datasets[@]}"
do
    if [ -e zipfile ]
    then
        echo "Found zip file! Skipping Download."
    else
        curl -o "$zipfile".zip https://marks.hms.harvard.edu/proteingym/"$zipfile".zip
    fi
    unzip -o "$zipfile".zip -d "$zipfile" && rm -f "$zipfile".zip
done