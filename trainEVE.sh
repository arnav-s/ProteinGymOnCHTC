#!/bin/bash

set -e

echo "Job $1 running on `whoami`@`hostname`"

tar -xzvf ProteinGym.tar.gz

cp /staging/sharma55/ProteinGymData.tar.gz .
tar -xzvf ProteinGymData.tar.gz

rm -f ProteinGymData.tar.gz

mkdir TrainedModel

cd ProteinGym/scripts/scoring_DMS_zero_shot

#Overwrite File locations for each job

export DMS_MSA_data_folder="$../../../ProteinGymData/DMS_ProteinGym_substitutions"
export DMS_reference_file_path_subs=../../reference_files/CHTC_ref_files/DMS_substitutions_queue"${1}".csv
export DMS_MSA_weights_folder="../../../ProteinGymData/DMS_msa_weights"
export DMS_MSA_data_folder="../../../ProteinGymData/DMS_msa_files"
export DMS_EVE_model_folder="../../../TrainedModel"

export DMS_index="0"
export seed="1271"

export model_parameters_location='../../proteingym/baselines/EVE/EVE/deepseq_model_params.json'
export training_logs_location='../../proteingym/baselines/EVE/logs'
export DMS_reference_file_path=$DMS_reference_file_path_subs
# export DMS_reference_file_path=$DMS_reference_file_path_indels
ls ../../proteingym/baselines/EVE
python ../../proteingym/baselines/EVE/train_VAE.py \
    --MSA_data_folder ${DMS_MSA_data_folder} \
    --DMS_reference_file_path ${DMS_reference_file_path} \
    --protein_index "${DMS_index}" \
    --MSA_weights_location ${DMS_MSA_weights_folder} \
    --VAE_checkpoint_location ${DMS_EVE_model_folder} \
    --model_parameters_location ${model_parameters_location} \
    --training_logs_location ${training_logs_location} \
    --threshold_focus_cols_frac_gaps 1 \
    --seed ${seed} \
    --skip_existing \
    --experimental_stream_data \
    --force_load_weights

#run train EVE script

cd ../../..
tar -czvf TrainedModel_job$1.tar.gz TrainedModel
mv TrainedModel_job$1.tar.gz /staging/sharma55/
rm -rf TrainedModel TrainedModel_job1.tar.gz
