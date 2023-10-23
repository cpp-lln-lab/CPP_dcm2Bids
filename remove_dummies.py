#!/usr/bin/python

"""
The following script will take a 4D nifti images and
will remove the requested number of volumes in the 4th dimension
"""


import sys
import os

import nibabel as nib

# Get the input from the shell/bash script and assign them as variables

print(f"Running the script: {sys.argv[0]}")

nifti_file = sys.argv[1]  # display the filename
num_dummies = int(sys.argv[2])  # display the number of dummies to remove
delete_original = int(sys.argv[3])  # Delete original (with dummies) :1/0


def remove_dummies(nifti_file, num_dummies, show_header=0, delete_original=0):
    img = nib.load(nifti_file)

    path, file = os.path.split(nifti_file)

    print(path)
    print(file)

    header = img.header
    if show_header:  # if header should be displayed
        print("Header before removing dummies")
        print(header)

    # Get the affine matrix
    affine = img.affine
    image_data = img.get_fdata()  # Get the 4D matrix with the voxel values
    dim_original = (
        image_data.shape
    )  # Get the shape of the matrix (Original 4D dimensions)

    # Remove the requested dummies in the 4th dimensions
    image_data = image_data[:, :, :, num_dummies:]
    image_data = image_data.astype(int)  # Change the type of numbers to int

    # Create a new nifti image with the new 4D matrix without the dummies
    new_image = nib.Nifti1Image(image_data, affine, header, affine)
    dim_final = image_data.shape  # Get the dimensions of the new 4D

    nib.save(new_image, os.path.join(path, file))

    if show_header:
        header = new_image.header
        print("Header after removing dummies")
        print(header)
        print("\n\n")

    print("image dimensions before removing dummies:", dim_original)
    print("image dimensions after removing dummies:", dim_final)

    # if requested to delete the original nii.gz 4D file with the dummies
    if delete_original:
        os.remove(nifti_file)
        print(f"Original nifti with dummies deleted: {nifti_file}")


def main(nifti_file, num_dummies, delete_original):
    print(f"nifti file = {nifti_file}")
    print(f"number of Dummies = {str(num_dummies)}")

    remove_dummies(nifti_file, num_dummies, delete_original)


if __name__ == "__main__":
    main()
