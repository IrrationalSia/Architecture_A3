.data
filename: .asciiz "/home/m/mphsiy010/Documents/sample_images/house_64_in_ascii_cr.ppm"
outputfilename: .asciiz "/home/m/mphsiy010/Documents/output.ppm"
msgOriginal: .asciiz "Average pixel value of the original image:\n "
msgNew: .asciiz "\nAverage pixel value of the new image:\n"
errorMsg: .asciiz "Error occurred.\n"
readByte: .byte 0  # <---- This line declares space for one byte

.text
main:
    # Initialize Variables
    li $t0, 0  # Original Sum
    li $t1, 0  # New Sum
    li $t2, 0  # Pixel Counter
    li $t9, 30000  # Total Pixel Count (Assuming 100x100x3 image for example)
    
    # Open the input file
    li $v0, 13
    la $a0, filename
    li $a1, 0  # read-only
    li $a2, 0  # mode is ignored
    syscall
    bltz $v0, errorExit
    move $s6, $v0
    
    # Open the output file
    li $v0, 13
    la $a0, outputfilename
    li $a1, 1  # write-only
    li $a2, 0  # mode is ignored
    syscall
    bltz $v0, errorExit
    move $s7, $v0
    
    j process_pixels
    
process_pixels:
    beq $t2, $t9, compute_average
    
    # Read an RGB value from input file
    li $v0, 14
    move $a0, $s6
    la $a1, readByte  # <---- Load the address of readByte into $a1
    li $a2, 1
    syscall
    bltz $v0, readErrorExit
    
    lb $t4, readByte  # <---- Load the byte from the address of readByte
    add $t0, $t0, $t4
    addi $t4, $t4, 10  # Increase brightness
    
    # Write modified RGB value to output file
     # Write modified RGB value to output file
    li $v0, 15
    move $a0, $s7
    sb $t4, readByte  # <---- Store the byte to the address of readByte
    li $a2, 1
    syscall
    bltz $v0, writeErrorExit
    add $t1, $t1, $t4
    addi $t2, $t2, 1
    j process_pixels
    
compute_average:
    # Convert to float and calculate the average
    mtc1 $t0, $f0
    mtc1 $t1, $f1
    mtc1 $t9, $f2
    
    cvt.s.w $f0, $f0
    cvt.s.w $f1, $f1
    cvt.s.w $f2, $f2
    
    div.s $f0, $f0, $f2
    div.s $f1, $f1, $f2
    
    li $v0, 4
    la $a0, msgOriginal
    syscall
    li $v0, 2
    mov.s $f12, $f0
    syscall
    
    li $v0, 4
    la $a0, msgNew
    syscall
    li $v0, 2
    mov.s $f12, $f1
    syscall
    
exit:
    li $v0, 10
    syscall
    
errorExit:
    li $v0, 4
    la $a0, errorMsg
    syscall
    j exit
    
readErrorExit:
    #For Debugging purposes
    j exit
    
writeErrorExit:
    # Debug write
    j exit
