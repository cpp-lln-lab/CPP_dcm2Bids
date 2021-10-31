#!/usr/bin/env bash

# to run the script, open the terminal and run:
# bash dicom2nii_BIDS_Step2.sh

source config.sh

dcm2bids --dicom_dir ${dicoms_folder} -p ${subject_label} -c ${config_file} -o ${bids_output_folder}

rm -rf ${bids_output_folder}/tmp_dcm2bids

bids-validator ${bids_output_folder}
