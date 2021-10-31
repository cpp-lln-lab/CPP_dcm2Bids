#!/usr/bin/env bash

source config.sh

mkdir -p ${dicoms_folder}

# get DICOM data, unzips them and move them
datalad install -s ${source_repo} ${dicoms_folder}

for sub in ${subjects}
do

    sub_folder=${dicoms_folder}/mri/sub-${sub}

    cd ${sub_folder} && unzip *.zip
    mv -f ${sub_folder}/export/home1/sdc_image_pool/images ${sub_folder}
    mv -f ${sub_folder}/images ${sub_folder}/dicoms

done
