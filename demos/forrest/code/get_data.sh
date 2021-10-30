#!/usr/bin/env bash

source config.sh

mkdir -p ${dicoms_folder}

# get DICOM data
datalad install -s ${source_repo} ${dicoms_folder}
