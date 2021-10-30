#!/usr/bin/env bash

source config.sh

mkdir -p ${dicoms_folder}

# get DICOM data
datalad install -s https://github.com/neurolabusc/dcm_qa_nih.git ${dicoms_folder}
