.data
filename: .asciiz "/home/m/mphsiy010/Documents/sample_images/house_64_in_ascii_cr.ppm"
outputfilename: .asciiz "/home/m/mphsiy010/Documents/file.ppm"
buffer: .space 1024
newline: .asciiz "\n"
textMessage: .asciiz "Average pixel value of the original image:\n"
textMessage2: .asciiz "\nAverage pixel value of new image:\n"
numPixels: .word 4096
sumOriginal: .word 0
sumNew: .word 0

.text
.globl main

main:
    # Open the input file for reading.
    li $v0, 13
    la $a0, filename
    li $a1, 0
    li $a2, 0
    syscall
    move $s0, $v0  # Store file descriptor.

    # Open the output file for writing.
    li $v0, 13
    la $a0, outputfilename
    li $a1, 1
    li $a2, 0
    syscall
    move $s1, $v0  # Store file descriptor.

    # For simplicity, not handling header here.
    # Move the read cursor to the appropriate place if needed.

readPixels:
    li $v0, 14
    move $a0, $s0  # Input file
    la $a1, buffer
    li $a2, 3  # 3 bytes (R, G, B)
    syscall

    # Exit loop when EOF is reached.
    beqz $v0, calculateAverage
    
    # Process pixel data.
    lb $t0, buffer     # R
    lb $t1, buffer+1   # G
    lb $t2, buffer+2   # B

    # Sum original pixel values.
    add $t3, $t0, $t1
    add $t3, $t3, $t2
    lw $t4, sumOriginal
    add $t4, $t4, $t3
    sw $t4, sumOriginal

    # Increase pixel values by 10 and handle overflow.
    addi $t0, $t0, 10  # Increment R
    addi $t1, $t1, 10  # Increment G
    addi $t2, $t2, 10  # Increment B

    # Clamp R, G, B to 255 if they exceed 255.
    li $t5, 255
    bgt $t0, $t5, setRTo255
    bgt $t1, $t5, setGTo255
    bgt $t2, $t5, setBTo255
    
setRTo255:
    move $t0, $t5
setGTo255:
    move $t1, $t5
setBTo255:
    move $t2, $t5

    # Sum new pixel values.
    add $t3, $t0, $t1
    add $t3, $t3, $t2
    lw $t4, sumNew
    add $t4, $t4, $t3
    sw $t4, sumNew

    # Write the modified pixel values to the output file.
    sb $t0, buffer     # R
    sb $t1, buffer+1   # G
    sb $t2, buffer+2   # B
    li $v0, 15
    move $a0, $s1      # Output file
    la $a1, buffer
    li $a2, 3
    syscall
    
    j readPixels  # Jump back to read the next pixel.

calculateAverage:
    # Here, we calculate and print the averages.
    lw $t0, sumOriginal
    lw $t1, numPixels
    div $t0, $t1  # original average = sumOriginal / numPixels
    mflo $t0

    li $v0, 4
    la $a0, textMessage
    syscall
    li $v0, 1
    move $a0, $t0
    syscall

    lw $t0, sumNew
    lw $t1, numPixels
    div $t0, $t1  # new average = sumNew / numPixels
    mflo $t0

    li $v0, 4
    la $a0, textMessage2
    syscall
    li $v0, 1
    move $a0, $t0
    syscall

    # Close files and exit.
    li $v0, 16
    move $a0, $s0  # Close input file
    syscall
    
    li $v0, 16
    move $a0, $s1  # Close output file
    syscall
    
    li $v0, 10
    syscall  # End the program.

