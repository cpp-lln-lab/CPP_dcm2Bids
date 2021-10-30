#!/usr/bin/env bash

# to run the script, open the terminal and run:
# bash dicom2nii_BIDS_Step1.sh

dicoms_root_folder=/Volumes/SanDisk/Workshop/visMotion_V3/sourcedata/
bids_output_folder=/Volumes/SanDisk/Workshop/visMotion_V3

# Create directory bids_output_folder if does not exist
if [ ! -d ${bids_output_folder} ]; then
  mkdir -p ${bids_output_folder}
fi

# Go to the BIDS output directory
cd ${bids_output_folder}

# dcm2bids_scaffold creates the neccessary folders and files for the BIDS structure
dcm2bids_scaffold

## DICOM to NIfTI conversion

# Run the `dcm2bids_helper -d $dicoms_root_folder`
# to get the information regarding the name of the conditions and files.
# The information is available in output json files in the `tmp_dcm2bids`.
# This information will used in the `config.json` file
dcm2bids_helper -d ${dicoms_root_folder}

echo "#############################################################"
echo "   Create the config.json in the BIDS output directory"
echo "  and add the required information before running step 2."
echo "  The information is available in tmp_dcm2bids json files."
echo "#############################################################"

# MAKE SURE THAT YOU HAVE THE config.json file ready at this step
# and filled correctly for the different experiment names.
