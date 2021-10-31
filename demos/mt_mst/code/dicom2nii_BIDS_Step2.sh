#!/usr/bin/env bash

# to run the script, open the terminal and run:
# bash dicom2nii_BIDS_Step2.sh

source config.sh

for sub in ${subjects}
do

    sub_folder=${dicoms_folder}/mri/sub-${sub}

    dcm2bids --dicom_dir ${sub_folder}/dicoms \
    --participant ${sub} \
    --session mri \
    --config ${sub_folder}/config.json \
    --output_dir ${bids_output_folder} \
    --forceDcm2niix

done
