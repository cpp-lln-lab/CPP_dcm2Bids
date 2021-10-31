.PHONY: clean
clean:
	rm -rf ../sourcedata
	rm -rf ../derivatives
	rm -rf ../tmp_dcm2bids
	rm -rf ../sub*
	rm  ../CHANGES ../README ../participants.* ../dataset_description.json

clean_dicoms:
	rm -rf ../sourcedata/mri/sub-*/dicoms

all: bids

sourcedata:
	bash get_data.sh

tmp_dcm2bids:
	bash dicom2nii_BIDS_Step1.sh

bids:
	bash dicom2nii_BIDS_Step2.sh
