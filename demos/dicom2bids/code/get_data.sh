#!/usr/bin/env bash

# Get data from the dcm2bids tuto

# Load parameters
source config.sh

# get DICOM data
mkdir -p ${dicoms_folder}
datalad install -s https://github.com/neurolabusc/dcm_qa_nih.git ${dicoms_folder}
