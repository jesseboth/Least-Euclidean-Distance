.data
    str_prefix_output: .asciiz "The closest pair of points is "
    num_points: .word 0
.text
load_points_helper:
    move $t8, $a0       #store file descriptor

    #get space for num_points
    li $v0, 9           #sbrk
    li $a0, 4           #sizeof int
    syscall
    move $t9, $v0       #save location

    #read from file
    li $v0,  14         #read
    move $a0, $t8       #file desc
    move $a1, $t9       #location
    li $a2, 4           #length
    syscall

    #store num_points
    lw $s0, 0($t9)      #save length to reg
    sw $s0, num_points  #save length to num_points

    sll $s0, $s0, 3     #num_points * 2 points * 4 bits
    addi $s0, $s0, 4    #add space for num_points

    ###############################
    #print num_points
    lw $a0, num_points
    li  $v0, 1          #print int
    syscall 
    li $v0, 11          #print char
    li $a0, 0xA         #new line
    syscall  
    ###############################

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

    ################################
    lw $s1, num_points
    move $t0, $t9
    li $t2, 0
    loop:
        beq $t2, $s1, exit
        # print points
        lw $a0, 0($t0)
        li  $v0, 1
        syscall
        li $a0, 0x3B        #;
        li $v0, 11
        syscall
        lw $a0, 4($t0)
        li  $v0, 1
        syscall   
        li $a0, 0xA        #new line
        li $v0, 11
        syscall   

        #to next address
        addi $t0, $t0, 8

        addi $t2, $t2, 1
        j loop 

    exit:
        lw $v0, num_points
        move $v1, $t8

    li $a0, 0x23        #new line
    li $v0, 11
    syscall 


    ################################
####################
#old working
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

####################