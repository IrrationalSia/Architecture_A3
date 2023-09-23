# Architecture_A3
Hi! This is my repository for an assignment comprising of 2 parts that are not really related.
We are working with MIPS assembly language

 MIPS Image Processing Programs

This repository contains MIPS assembly programs designed to perform image processing tasks, specifically:
1. Converting a color PPM P3 image to a greyscale PPM P2 image (`greyscale.asm`).
2. Calculating and adjusting the average pixel value of a given image (`increase_brightness.asm`).

## Table of Contents
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
  - [Greyscale Conversion](#greyscale-conversion)
  - [Pixel Average Adjustment](#increase-brightness)
- [Constraints] (#constraints)
- [Acknowledgements] (#acknowledgements)

## Getting Started

1. Clone the repository:
sh git clone (https://github.com/IrrationalSia/Architecture_A3)
Navigate to the project directory:
sh cd Architecture_A3

2. Prerequisites
Install a MIPS Simulator like SPIM to run the assembly programs.
Install an image editor such as GIMP to view the PPM files or use a text editor to view the characters in PPM files.
Ensure the input file paths in the programs are correctly set with absolute paths and that appropriate permissions are configured.
3. Usage
Filenames and headers are hardcoded.
You can hardcode the image headers and filenames in the provided MIPS assembly files. Absolute paths should be used for the filenames. Replace the line in the code that specifies the filename with the desired absolute path. Make sure to properly comment your code.
 Greyscale Conversion
 greyscale.asm reads a color PPM P3 image and converts it to a greyscale PPM P2 image by calculating the average of its RGB values.

 Load greyscale.asm in the MIPS simulator.
 Run the program.
 Increase Brightness
 pixel_average.asm reads an image and adjusts its pixel values by a fixed amount, then prints the average pixel value of the original and the new image.

 Load increase_brightness.asm in the MIPS simulator.
 Run the program.

Specifications and constraints
The provided input image will always be 64x64 pixels in size.
The specified form will always be used for the input image header.
Services 13 and 14 of MIPS must be used separately.
After performing the read/write operations, all files must be closed using service 16.
RGB values will be between [0, 255].
The end-of-line character may differ depending on the operating system ([LF] for Linux and QtSpim, [CR] for Mac, and [CR][LF] for Windows).
Contributions are always welcome! Please refer to the above-mentioned contributing guidelines.

Acknowledgments
QtSPIM Simulator allows MIPS Assembly programs to be executed.
GIMP for making a free and open-source raster graphics editor available.
