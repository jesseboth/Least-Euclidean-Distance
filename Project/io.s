.data
    str_prefix_output: .asciiz "The closest pair of points is "
    num_points: .word 0
.text
load_points:
    # $a0 is the based address of the file name string
    # $v0 is the number of points
    # $v1 is the based address of points array
    # i.e., $v1 is x0, 4($v1) is y0, 8($v1) is x1, etc.

    #####  put your codes below this line #####
    move $s1, $ra       #store return

    #open the file
    li $v0, 13          # system call for open file
    li $a1, 0           #flag
    li $a2, 0           #mode
    syscall             # open a file 

    # save the file descriptor  
    move $a0, $v0       
    move $s2, $v0

    jal load_points_helper

    #store for return
    move $t0, $v0
    move $t1, $v1

    #close the file
    li $v0, 16          #close
    move $a0, $s2       #set file descriptor
    syscall

    #restore return values
    move $v0, $t0
    move $v1, $t1
    move $ra, $s1       #replace return address

    #####  put your codes above this line #####
    jr $ra



output_cloest_pair:
    # $a0, $a1 is the address of the two points of the closest pair
    # i.e., $a0 is the address of x0, 4($a0) is the address of y0, $a1 is the address of x1, etc.

    #####  put your codes below this line #####
    move $t0, $a0
    move $t1, $a1

    #print string
    li $v0, 4
	la $a0, str_prefix_output
	syscall

    #print x0
    li $v0, 1
	lw $a0, 0($t0)
	syscall

    #print comma
    li $a0, 0x2C
    li $v0, 11
    syscall  

    #print y0
    li $v0, 1
	lw $a0, 4($t0)
	syscall

    #print comma
    li $a0, 0x2C
    li $v0, 11
    syscall 

    #print x1
    li $v0, 1
	lw $a0, 0($t1)
	syscall

    #print comma
    li $a0, 0x2C
    li $v0, 11
    syscall 
    
    #print y1
    li $v0, 1
	lw $a0, 4($t1)
	syscall
    #####  put your codes above this line #####
    jr $ra


load_points_helper:
    # file descriptor is in $a0
    # $v0 is the number of points
    # $v1 is the based address of points array
    # i.e., $v1 is x0, 4($v1) is y0, 8($v1) is x1, etc.
    
    #####  put your codes below this line #####

    move $t8, $a0       #store file descriptor

    #get space for num_points
    li $v0, 9           #sbrk
    li $a0, 8           #sizeof int
    syscall
    move $t9, $v0       #save location

    #read from file
    li $v0,  14         #read
    move $a0, $t8       #file desc
    move $a1, $t9       #location
    li $a2, 8           #length
    syscall

    #store num_points
    lw $s0, 0($t9)      #save length to reg
    sw $s0, num_points  #save length to num_points
    sll $s0, $s0, 3     #num_points * 2 points * 4 bits       

    #get space for points
    li $v0, 9           #sbrk
    move $a0, $s0       #space required
    syscall
    move $t9, $v0       #save location

    #read from file to get points
    li $v0, 14          #read
    move $a0, $t8       #file desc
    move $a1, $t9       #location
    move $a2, $s0       #length
    syscall

    addi $t9, $t9, -4   #for some reason...    
    lw $v0, num_points  #return numpoints
    move $v1, $t9       #return location
    #####  put your codes above this line #####
    jr $ra