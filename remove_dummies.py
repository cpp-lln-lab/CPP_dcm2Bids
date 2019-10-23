#!/usr/bin/python
# The following script will take a 4D nifti images and will remove the requested number of volumes
# in the 4th dimension

# import system and OS
import sys
import os

# Get the input from  the shell/bash script and assign them as variables
print('Running the script: ' + sys.argv[0]) # prints python_script.py
NIFTI_FILE = sys.argv[1]               # display the filename
NUM_DUMMIES = int(sys.argv[2])         # display the number of dummies to remove
DELETE_ORIGINAL = int(sys.argv[3])     # Delete original nii.gz (with dummies) :1/0

def remove_dummies(nifti_file, num_dummies, show_header=0, delete_original=0):

    import nibabel as nib               # import nibabel
    img = nib.load(nifti_file)           # load the nifti image
    num_dummies = num_dummies             # Get number of dummies

    path, file = os.path.split(nifti_file) # split the full path of the file
    print(path)                           # print path name
    print(file)                           # print file name

    # read the header information from the nifti image
    header = img.header
    if show_header:         # if header should be displayed
        print('Header before removing dummies')
        print(header)

    # Get the affine matrix
    affine = img.affine
    image_data = img.get_fdata()    # Get the 4D matrix with the voxel values
    dim_original = image_data.shape  # Get the shape of the matrix (Original 4D dimensions)

    # Remove the requested dummies in the 4th dimensions
    image_data = (image_data[:, :, :, num_dummies:])
    image_data = image_data.astype(int)      # Change the type of numbers to int

    # Create a new nifti image with the new 4D matrix without the dummies
    new_image = nib.Nifti1Image(image_data, affine, header, affine)
    dim_final = image_data.shape    # Get the dimensions of the new 4D

    # Save the nifti image as .nii without compression(.nii.gz)
    nib.save(new_image, os.path.join(path, file[:-3]))

    if show_header:                       # if header should be displayed
        header = new_image.header         # read the header and display it
        print('Header after removing dummies')
        print(header)
        print('\n\n')

    print('image dimensions before removing dummies:', dim_original)
    print('image dimensions after removing dummies:', dim_final)

    # if requested to delete the original nii.gz 4D file with the dummies
    if delete_original:
        os.remove(nifti_file)  # Delete original image
        print('Original nifti with dummies deleted: ' + nifti_file)


print('nifti file = ' + NIFTI_FILE)
print('number of Dummies = ' + str(NUM_DUMMIES))

remove_dummies(NIFTI_FILE, NUM_DUMMIES)
