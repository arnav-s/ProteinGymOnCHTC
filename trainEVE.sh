#!/bin/bash

tar -xzvf ProteinGymOnCHTC.tar.gz

export PROTEIN_GYM_HOME=/scratch/ProteinGym
cd ${PROTEIN_GYM_HOME}/scripts/scoring_DMS_zero_shot

#!/bin/bash


source ../zero_shot_config.sh
source activate proteingym_env

#Overwrite File locations for each job

export DMS_MSA_data_folder=
export DMS_reference_file_path=
export DMS_MSA_weights_folder=
export DMS_EVE_model_folder=

export DMS_index="0"
export seed="1271"

export model_parameters_location='${PROTEIN_GYM_HOME}/proteingym/baselines/EVE/EVE/deepseq_model_params.json'
export training_logs_location='${PROTEIN_GYM_HOME}/proteingym/baselines/EVE/logs/'
export DMS_reference_file_path=$DMS_reference_file_path_subs
# export DMS_reference_file_path=$DMS_reference_file_path_indels

python ${PROTEIN_GYM_HOME}/proteingym/baselines/EVE/train_VAE.py \
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