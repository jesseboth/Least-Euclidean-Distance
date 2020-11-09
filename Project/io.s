.data
    str_prefix_output: .asciiz "The closest pair of points is "
    num_points: .word 0
    buffer: .space 4
.text
load_points:
    # $a0 is the based address of the file name string
    # $v0 is the number of points
    # $v1 is the based address of points array
    # i.e., $v1 is x0, 4($v1) is y0, 8($v1) is x1, etc.

    #####  put your codes below this line #####

    li $v0, 13          # system call for open file
    li $a1, 0           #flag
    li $a2, 0           #mode
    syscall             # open a file 

    move $a0, $v0       # save the file descriptor  
    move $s2, $v0

    jal load_points_helper


    # li $a0, 0x3D        #new line
    # li $v0, 11
    # syscall 

    #store for return
    move $t0, $v0
    move $t1, $v1

    li $v0, 16      #close
    move $a0, $s2   #set file descriptor
    syscall

    move $v0, $t0
    move $v1, $t1
    #####  put your codes above this line #####
    jr $ra



output_cloest_pair:
    # $a0, $a1 is the address of the two points of the closest pair
    # i.e., $a0 is the address of x0, 4($a0) is the address of y0, $a1 is the address of x1, etc.

    #####  put your codes below this line #####



    
    #####  put your codes above this line #####
    jr $ra


load_points_helper:
    # file descriptor is in $a0
    # $v0 is the number of points
    # $v1 is the based address of points array
    # i.e., $v1 is x0, 4($v1) is y0, 8($v1) is x1, etc.
    
    #####  put your codes below this line #####

    move $t8, $a0
    # reading from file just opened
    li   $v0, 14        #read
    la   $a1, buffer    # address
    li   $a2,  4        # length to get num_points
    syscall            

    # saving num_points
    la  $t0, buffer     #location
    lw $t1, 0($t0)      #save numpoints
    sw $t1, num_points  #store value

    add $s0, $zero, $t1 #save numpoints
    sll $s0, $s0, 3     #numpoints * 2 points * 4 bits
    addi $s0, $s0, 4
    sw $s0, buffer      #change buffer for the required space
    addi $s0, $s0, -4
    
    #print numpoints
    lw $a0, 0($t0)
    li  $v0, 1          #print int
    syscall

    li $a0, 0xA        #new line
    li $v0, 11
    syscall  

    # read from file with given length
    li   $v0, 14        # read
    move $a0, $t8
    la   $a1, buffer    # address
    move   $a2,  $s0    # length = numpoints * 2 points * 4 bits
    syscall

    #allocate space
    li $v0 9          #sbrk
    move $a0, $s0
    syscall

    # resave address
    la $t0, buffer     #location
    move $t1, $v0        #location of sbrk

    move $t8, $v0        #store for return

    lw $s1, num_points
    li $t2, 0
    loop:
        beq $t2, $s1, exit

        #x
        lw $t3, 0($t0)
        sw $t3, 0($t1)
        #y
        lw $t3, 4($t0)
        sw $t3, 4($t1)


        # print points
        lw $a0, 0($t1)
        li  $v0, 1
        syscall
        li $a0, 0x3B        #;
        li $v0, 11
        syscall
        lw $a0, 4($t1)
        li  $v0, 1
        syscall   
        li $a0, 0xA        #new line
        li $v0, 11
        syscall   

        #to next address
        addi $t0, $t0, 8
        addi $t1, $t1, 8

        addi $t2, $t2, 1
        j loop 
    
    exit:
        lw $v0, num_points
        move $v1, $t8

    li $a0, 0x23        #new line
    li $v0, 11
    syscall 
    #####  put your codes above this line #####
    jr $ra