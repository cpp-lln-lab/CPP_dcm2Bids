#!/usr/bin/env bash

# to run the script, open the terminal and run:
# sh./ dicom2nii_BIDS_Step2.sh

bids_output_folder=/Volumes/SanDisk/Workshop/visMotion_V3

number_dummies=4        # Number of dummies to remove
delete_original=1    # Delete original after removing dummies

subjects=("AlSo"	"BrCh")
subjects_numbers=("2" "3")
dicoms_root_folder=/Volumes/SanDisk/Workshop/visMotion_V3/sourcedata/

WD=`pwd`

# Go to the BIDS output directory
cd ${bids_output_folder}

# Get the number of the subjects
nb_subjects=${#subjects[@]}
echo 'Number of Subjects: '${nb_subjects}

# for loop that iterates over each element in arr
for iSub in "${!subjects[@]}" #{1..${nb_subjects}}
do

  sub_name="${subjects[${iSub}]}"
  sub_nb="${subjects_numbers[${iSub}]}"
  sub_nb="$(printf "%02d" ${sub_nb})"
  echo 'Subject Name:' ${sub_name} " - ID:"${sub_nb}

  # For every condition you have, add the following block of code to get the DICOM location

  ##############################################################################
  # dcm2bids inputs:
  #
  # dcm2bids -d ${sub_dicom_folder} \
  #          -p ${sub_label} \
  #          -s ${ses_label} \
  #          -c config.json \
  #          -o ${bids_output_folder}
  #
  # -d Dicom path
  # -p Partipiant label
  # -s Session label
  # -o Output directory for the nifti files
  # -c Configuration json file that should be present in the output directory
  ##############################################################################

  ## 1. ANAT
  # the directory to the dicom files (needs to be changed according to your dicom location and name)
  sub_dicom_folder=${dicoms_root_folder}'Anatomical/'${sub_name}           ## <---------- CHANGE THE LOCATION

  echo "DICOMS folder is: "${sub_dicom_folder}
  echo "Output folder is: "${bids_output_folder}

  dcm2bids -d ${sub_dicom_folder} \
           -p ${sub_nb} \
           -s 01 \
           -c config.json \
           -o ${bids_output_folder}

  ## 2. FUNC
  taskName='visMotion'                                                     ## <---------- CHANGE THE TASK NAME

  sub_dicom_folder=${dicoms_root_folder}'Control/'${sub_name}              ## <---------- CHANGE THE LOCATION

  echo "DICOMS folder is: "${sub_dicom_folder}
  echo "Output folder is: "${bids_output_folder}

  dcm2bids -d ${sub_dicom_folder} \
           -p ${sub_nb} \
           -s 01 \
           -c config.json \
           -o ${bids_output_folder}

  ### remove dummies
  file=${bids_output_folder}'/sub-'${sub_nb}'/ses-01/func/sub-'${sub_nb}'_ses-01_task-'${taskName}'_bold.nii.gz'
  echo ${file}
  cd $WD
  python remove_dummies.py ${file} ${number_dummies} ${delete_original}
  cd ${bids_output_folder}

  ## 3. ADD OTHER EXPERIMENTS IF NEEDED BY COPYING ONE OF THE ABOVE


done
