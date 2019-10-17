#!/usr/bin/python
# The following script will take a 4D nifti images and will remove the requested number of volumes
# in the 4th dimension

# import system and OS
import sys
import os

# Get the input from  the shell/bash script and assign them as variables
print ('Running the script: '+sys.argv[0]) # prints python_script.py
niftiFile = sys.argv[1]               # display the filename
numDummies = int(sys.argv[2])         # display the number of dummies to remove
deleteOriginal = int(sys.argv[3])     # Delete original nii.gz (with dummies) :1/0

def removeDummies(niftiFile,numDummies,showHeader=0):

    import nibabel as nib               # import nibabel
    img = nib.load(niftiFile)           # load the nifti image
    numDummies = numDummies             # Get number of dummies

    path, file = os.path.split(niftiFile) # split the full path of the file
    print(path)                           # print path name
    print(file)                           # print file name

    # read the header information from the nifti image
    header = img.header
    if showHeader:         # if header should be displayed
        print('Header before removing dummies')
        print(header)

    # Get the affine matrix
    affine = img.affine
    image_data = img.get_fdata()    # Get the 4D matrix with the voxel values
    dimOriginal = image_data.shape  # Get the shape of the matrix (Original 4D dimensions)

    # Remove the requested dummies in the 4th dimensions
    image_data = (image_data[:,:,:,numDummies:])
    image_data = image_data.astype(int)      # Change the type of numbers to int

    # Create a new nifti image with the new 4D matrix without the dummies
    newImage = nib.Nifti1Image(image_data,affine,header,affine)
    dimFinal = image_data.shape    # Get the dimensions of the new 4D
    nib.save(newImage, os.path.join(path, file[:-3]))   # Save the nifti image as .nii without compression(.nii.gz)

    if showHeader:                       # if header should be displayed
        header = newImage.header         # read the header and display it
        print('Header after removing dummies')
        print(header)
        print('\n\n')

    print('image dimensions before removing dummies:', dimOriginal)
    print('image dimensions after removing dummies:' , dimFinal)

    # if requested to delete the original nii.gz 4D file with the dummies
    if deleteOriginal:
        os.remove(niftiFile)  # Delete original image
        print('Original nifti with dummies deleted: '+ niftiFile)


print ('nifti file= '+niftiFile)
print ('number of Dummies= '+ str(numDummies))
removeDummies(niftiFile,numDummies)
