#!/usr/bin/env bash

# downloads the sample data set from the Forrest study
# one run, one task, one subject

# Load parameters
source config.sh


# get DICOM data
mkdir -p ${dicoms_folder}
datalad install -s ${source_repo} ${dicoms_folder}
