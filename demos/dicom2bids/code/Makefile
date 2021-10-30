.PHONY: clean
clean:
	rm -rf ../sourcedata
	rm -rf ../derivatives
	rm -rf ../tmp_dcm2bids
	rm  ../CHANGES ../README ../participants.* ../dataset_description.json

.PHONY: data
data:
	bash get_data.sh

helper: data
	bash dicom2nii_BIDS_Step1.sh
