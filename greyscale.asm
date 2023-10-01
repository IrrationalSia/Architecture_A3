.data
input_filename: .asciiz "/home/m/mphsiy010/Documents/sample_images/house_64_in_ascii_cr.ppm"
output_filename: .asciiz "/home/m/mphsiy010/Documents/output_grey.ppm"
p2: .asciiz "P2\n"
newline: .asciiz "\n"
buffer: .space 128 # For reading lines

.text
.globl main
main:
    # Open input file
    li $v0, 13
    la $a0, input_filename
    li $a1, 0 # Read mode
    li $a2, 0
    syscall
    bltz $v0, exit # If error occurs, exit
    move $s0, $v0 # File descriptor for input file
    
    # Open output file
    li $v0, 13
    la $a0, output_filename
    li $a1, 1 # Write mode
    li $a2, 0
    syscall
    bltz $v0, close_input_exit # If error occurs, close input and exit
    move $s1, $v0 # File descriptor for output file
    
    # Write P2 to output file
    li $v0, 15
    move $a0, $s1
    la $a1, p2
    li $a2, 3
    syscall
    bltz $v0, close_files_exit # If error occurs, close files and exit
    
    # Handle Headers (Read and Write) 
    # Here, you would properly read width, height, and max color value from input and write to output
    
    # Write P2 and newline to output
    li $v0, 15
    move $a0, $s1
    la $a1, p2
    li $a2, 3 # "P2\n"
    syscall
    
    # Read & Write Max Color (Assume 255 and write it directly to the output)
    li $v0, 15
    move $a0, $s1
    li $t0, 255
    la $a1, newline # use newline as temporary space to store number
    sb $t0, 0($a1) # store 255 (in binary) to the space pointed by a1
    la $a1, newline
    li $a2, 1
    syscall
    
    # Write another newline after max color
    li $v0, 15
    move $a0, $s1
    la $a1, newline
    li $a2, 1
    syscall
    

   #Assume Height H and Width W
    li $t1, H # row counter
process_row:
    li $t2, W # column counter
process_col:
        # Read R, G, B
        li $t3, 0 # accumulator for grayscale value
        li $t4, 3 # RGB components counter
read_rgb:
            li $v0, 14
            move $a0, $s0
            la $a1, buffer
            li $a2, 1
            syscall
            lb $t0, 0($a1) # load byte read
            add $t3, $t3, $t0
            sub $t4, $t4, 1
            bnez $t4, read_rgb
        
        # Compute and write grayscale value
        div $t3, $t3, 3
        mflo $t3 # load quotient to t3 (rounding down)
        li $v0, 15
        move $a0, $s1
        sb $t3, 0($a1) # store grayscale value
        la $a1, buffer
        li $a2, 1
        syscall
        
        # Continue to the next pixel
        sub $t2, $t2, 1
        bnez $t2, process_col
    
    # Continue to the next row
    sub $t1, $t1, 1
    bnez $t1, process_row
    
    # Finish by closing all our files
close_files:
    # Close output file
    li $v0, 16
    move $a0, $s1
    syscall
    
close_input_exit:
    # Close input file
    li $v0, 16
    move $a0, $s0
    syscall
    
exit:
    li $v0, 10
    syscall
