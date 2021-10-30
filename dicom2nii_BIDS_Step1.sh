#!/usr/bin/env bash

# to run the script, open the terminal and run:
# sh./ dicom2nii_BIDS_Step1.sh

bids_output_folder=/Volumes/SanDisk/Workshop/visMotion_V3

# if bids_output_folder does not exist
if [ ! -d $bids_output_folder ]; then
  mkdir -p $bids_output_folder    # Create directory
fi

########################################
##############   GROUP 1   #############
########################################
# Subject Names (folder names)
#subjects=("AlSo"	"BrCh")
#subjects_numbers=("2" "3")
#group=''     # Group
dicoms_root_folder=/Volumes/SanDisk/Workshop/visMotion_V3/sourcedata/

########################################
##############   GROUP 2   #############
########################################
#subjects=("AlBo"	"CaBa")
#group='cat'
#dicoms_root_folder=/Data/Neurocat_BIDS/DICOMS/Cataract/

########################################

# Go to the BIDS output directory
cd $bids_output_folder

# dcm2bids_scaffold creates the neccessary folders and files for the BIDS structure
dcm2bids_scaffold

# Run the `dcm2bids_helper -d $dicoms_root_folder` on a couple of subjects
# to get the information regarding the name of the conditions and files.
# The information is available in output json files in the `tmp_dcm2bids`.
# This information will used in the `config.json` file
dcm2bids_helper -d $dicoms_root_folder

echo "#############################################################"
echo "   Create the config.json in the BIDS output directory"
echo "  and add the required information before running step 2."
echo "  The information is available in tmp_dcm2bids json files."
echo "#############################################################"

# MAKE SURE THAT YOU HAVE THE config.json file ready at this step
# and filled correctly for the different experiment names.
