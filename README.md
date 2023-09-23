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

## Getting Started

1. Clone the repository:
sh git clone (https://github.com/IrrationalSia/Architecture_A3)
Navigate to the project directory:
sh cd Architecture_A3

2. Prerequisites
A MIPS Simulator like SPIM, Mars or QtSpim is required to run the assembly programs.
Ensure that input file paths in the programs are correctly set and that appropriate permissions are configured.
3. Usage
Greyscale Conversion
greyscale.asm reads a color PPM P3 image and converts it to a greyscale PPM P2 image by calculating the average of its RGB values.

Load greyscale.asm in the MIPS simulator.
Run the program.
Increase Brightness
pixel_average.asm reads an image and adjusts its pixel values by a fixed amount, then prints the average pixel value of the original and the new image.

Load pixel_average.asm in the MIPS simulator.
Run the program.
