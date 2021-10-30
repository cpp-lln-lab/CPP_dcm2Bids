#!/usr/bin/env bash

# to run the script, open the terminal and run:
# sh./ dicom2nii_BIDS_Step2.sh

# BIDS outout folder
bids_output_folder=/Volumes/SanDisk/Workshop/visMotion_V3

# if bids_output_folder does not exist
if [ ! -d $bids_output_folder ]; then
  mkdir -p $bids_output_folder;    # Create directory
fi

numDummies=4        # Number of dummies to remove
deleteOriginal=1    # Delete original after removing dummies

########################################
##############   GROUP 1   #############
########################################
# Subject Names (folder names)
subjects=("AlSo"	"BrCh")
subjects_numbers=("2" "3")
group=''
dicoms_root_folder=/Volumes/SanDisk/Workshop/visMotion_V3/sourcedata/

WD=$(pwd)
########################################
##############   GROUP 2   #############
########################################
#subjects=("AlBo"	"CaBa")
#group='cat'
#dicoms_root_folder=/Data/Neurocat_BIDS/DICOMS/Cataract/

########################################

# Go to the BIDS output directory
cd $bids_output_folder

# Get the number of the subjects in the group
nb_subjects=${#subjects[@]}
echo 'Number of Subjects: '$nb_subjects

# for loop that iterates over each element in arr
for iSub in "${!subjects[@]}" #{1..$nb_subjects}
do

  sub_name="${subjects[$iSub]}"
  sub_nb="${subjects_numbers[$iSub]}"
  sub_nb="$(printf "%02d" $sub_nb)"
  echo 'Subject Name:' $sub_name " - ID:"$sub_nb

  # For every condition you have, add the following block of code to get the DICOM location

  ################################################################################
  # dcm2bids inputs:
  # dcm2bids -d $sub_dicom_folder -p $group$sub_nb -s 01 -c config.json -o $bids_output_folder
  # -d : DICOM PATH
  # -p Partipiant name/number and the (group)
  # -s Session number
  # -o output directory for the nifti files
  # -c Configuration json file that should be present in the output directory
  ################################################################################

  ## 1. ANATOMICAL
  # the directory to the dicom files (needs to be changed according to your dicom location and name)
  sub_dicom_folder=$dicoms_root_folder'Anatomical/'$sub_name           ## <---------- CHANGE THE LOCATION

  echo "DICOMS folder is: "$sub_dicom_folder
  echo "Output folder is: "$bids_output_folder
  dcm2bids -d $sub_dicom_folder -p $group$sub_nb -s 01 -c config.json -o $bids_output_folder

  ## 2. Functional data - Name of the experiment: DECODING
  sub_dicom_folder=$dicoms_root_folder'Control/'$sub_name                 ## <---------- CHANGE THE LOCATION
  taskName='visMotion'                                                ## <---------- CHANGE THE TASK NAME
  echo "DICOMS folder is: "$sub_dicom_folder
  echo "Output folder is: "$bids_output_folder
  dcm2bids -d $sub_dicom_folder -p $group$sub_nb -s 01 -c config.json -o $bids_output_folder

  # remove Dummies
  file=$bids_output_folder'/sub-'$group$sub_nb'/ses-01''/func/''sub-'$group$sub_nb'_ses-01_task-'$taskName'_bold.nii.gz'
  echo $file
  cd $WD
  python remove_dummies.py $file $numDummies $deleteOriginal
  cd $bids_output_folder

  ## 3. ADD OTHER EXPERIMENTS IF NEEDED BY COPYING ONE OF THE ABOVE


done
