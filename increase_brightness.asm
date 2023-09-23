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
count: .word 0

.text
main:
    # Open the input file for reading.
    li $v0, 13
    la $a0, filename
    li $a1, 0
    li $a2, 0
    syscall
    move $s0, $v0  # Input file descriptor.

    # Open the output file for writing.
    li $v0, 13
    la $a0, outputfilename
    li $a1, 1
    li $a2, 0
    syscall
    move $s1, $v0  # Output file descriptor.
    
    # Read the header
    # For the purpose of this example, let's assume it's a simple read and write, adjust based on the actual ppm header format
    li $v0, 14
    move $a0, $s0
    la $a1, buffer
    li $a2, 1024
    syscall
    
    # Write the header to the output file.
    li $v0, 15
    move $a0, $s1
    la $a1, buffer
    li $a2, 1024
    syscall
    
    # Read and process pixel data.
readPixels:
    li $v0, 14
    move $a0, $s0
    la $a1, buffer
    li $a2, 3
    syscall
    
    # Check if the end of the file has been reached.
    beqz $v0, endRead
    
    # Load RGB values.
    lb $t0, buffer     # R
    lb $t1, buffer+1   # G
    lb $t2, buffer+2   # B
    
    # Update sumOriginal
    add $t3, $t0, $t1
    add $t3, $t3, $t2
    lw $t4, sumOriginal
    add $t4, $t4, $t3
    sw $t4, sumOriginal
    
    # Increment and clamp RGB values.
    li $t5, 255
    addi $t0, $t0, 10
    addi $t1, $t1, 10
    addi $t2, $t2, 10
    bgt $t0, $t5, setRTo255
    j continueR
setRTo255:
    move $t0, $t5
continueR:
    bgt $t1, $t5, setGTo255
    j continueG
setGTo255:
    move $t1, $t5
continueG:
    bgt $t2, $t5, setBTo255
    j continueB
setBTo255:
    move $t2, $t5
continueB:
    
    # Update sumNew
    add $t3, $t0, $t1
    add $t3, $t3, $t2
    lw $t4, sumNew
    add $t4, $t4, $t3
    sw $t4, sumNew
    
    # Write the modified pixel values to the output file.
    sb $t0, buffer
    sb $t1, buffer+1
    sb $t2, buffer+2
    li $v0, 15
    move $a0, $s1
    la $a1, buffer
    li $a2, 3
    syscall
    
    # Increment pixel count.
    lw $t3, count
    addi $t3, $t3, 1
    sw $t3, count
    
    # Read the next pixel.
    j readPixels
    
endRead:
    # Close the input file.
    li $v0, 16
    move $a0, $s0
    syscall
    
    # Close the output file.
    li $v0, 16
    move $a0, $s1
    syscall
    
    # Calculate and display averages.
    lw $t0, sumOriginal
    lw $t1, count
    divu $t0, $t1
    mflo $t0  # Original Average
    li $v0, 4
    la $a0, textMessage
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    
    lw $t0, sumNew
    lw $t1, count
    divu $t0, $t1
    mflo $t0  # New Average
    li $v0, 4
    la $a0, textMessage2
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    
    # End the program.
    li $v0, 10
    syscall
