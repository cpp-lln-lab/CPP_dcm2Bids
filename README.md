## Converting DICOM data to BIDS

This repo contains 2 scripts to convert NIFTI files (output of dcm2niix) into
BIDS compatible folder scaffold.

It's using mainly couple of functions from two repos (see
[Dependencies](#dependencies)) and can create the scaffold of folders for
multiple participants/datasets at once.

For more in depth info on BIDS, please do visit the
[website](https://github.com/bids-standard)

## Dependencies

Make sure that the following softwares are installed. For instructions see the
following links:

- [dcm2Bids](https://github.com/cbedetti/Dcm2Bids)
- [dcm2niix](https://github.com/rordenlab/dcm2niix)

### Set up environment

```
conda env create -f environment.yml
source activate dcm2bids
```

### Step 1

- Open the shell script `dicom2nii_BIDS_Step1.sh` in your preferred text editor.
- Change your desired BIDS output directory.
- Add the different groups of subjects and their names, and DICOM locations
- Run the `dicom2nii_BIDS_Step1.sh` in the terminal:
  `./sh dicom2nii_BIDS_Step1.sh`
- Go to your BIDS output directory and then to the `tmp_dcm2bids` folder
- Open the `json` files of the different conditions and get the
  `_SERIES DISCRIPTION_` , eg: `SeriesDescription: "Motion"` --> here the Series description is Motion.
- Create a new `json` file called `config.json` in the BIDS output directory.
  Add the conditions indicating the series description. Check the `config.json`
  for examples and the `config_json_template_different_modalities.json` for all
  possible modalities

### Step 2

- Open the shell script `dicom2nii_BIDS_Step2.sh` in your preferred text editor.
- Change your desired BIDS output directory, add the different groups of
  subjects and their names, and DICOM locations. **MAKE SURE IT MATCHS Step 1**
- repeat the blocks of code for each condition in your experiment (eg.
  anatomical, functional exp1, functional exp2, etc.)
- Make sure that the dicom location in each experimental condition is correct.
- Run the `dicom2nii_BIDS_Step2.sh` in the terminal:
  `./sh dicom2nii_BIDS_Step2.sh`
- move the produced subject folders in a folder called `raw` to kept as the
  untouched raw data.
- copy the contents of the raw folder in the `derivatives` folder

- Check the dataset whether its compatible with the
  [BIDS validator](https://github.com/bids-standard/bids-validator)

- fix the errors until it's compatible. :-)
