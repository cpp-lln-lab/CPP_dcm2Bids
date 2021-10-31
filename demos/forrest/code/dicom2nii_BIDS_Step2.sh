#!/usr/bin/env bash

# to run the script, open the terminal and run:
# bash dicom2nii_BIDS_Step2.sh

source config.sh

dcm2bids -d ${dicoms_folder} -p ${subject_label} -c ${config_file} -o ${bids_output_folder}
