.text
sort_points_by_x:
    # sort points in-place by x . Non-decrease order is applied
    # $a0 is num_points, $a1 is array base address
    # note that array has the order as x0, y0, x1, y1, x2, y3, ..., xn , yn
 
    #####  put your codes below this line #####
    # move $s6, $a0

    li $t8, 0               #sorted length
    sll $s7, $a0, 3         #length
    addi $t9, $s7, -8       #length -1 (stop)

    #i
    li $t0, 0               #i 
    move $s0, $a1           #array[i]

    #current pos
    li $t1, 8               #current pos
    addi $s1, $a1, 8        #array[current]

    li $s2, 0               #check pos

        ################
        li $a0, 0x3B        #new line
        li $v0, 11
        syscall  
        ################

    while:
        beq $t8, $t9, end  #while(sort_length < length-2)

        add $s0, $a1, $s2       #array[i]
        move $t0, $s2       #i = check_pos

        # li $v0, 1
        # move $a0, $t0
        # syscall
        #################
        # li $v0, 1
        # lw $a0, 0($s0)
        # syscall
        # li $a0, 0xA        #new line
        # li $v0, 11
        # syscall  
        # li $v0, 1
        # lw $a0, 8($s0)
        # syscall
        # li $a0, 0xA        #new line
        # li $v0, 11
        # syscall 
        # li $v0, 1
        # lw $a0, 16($s0)
        # syscall
        # li $a0, 0xA        #new line
        # li $v0, 11
        # syscall 
        # li $v0, 1
        # lw $a0, 24($s0)
        # syscall
        # li $a0, 0xA        #new line
        # li $v0, 11
        # syscall
        # li $a0, 0x3B        #new line
        # li $v0, 11
        # syscall
        # li $a0, 0xA        #new line
        # li $v0, 11
        # syscall   
        #################
        j while2
    while2:
    ###################
        # li $v0, 1
        # move $a0, $t0
        # syscall
    ###################

        bgt $t0, $t1, while #while(i <= current_pos):
        
        lw $t2, 0($s0)      #value of array[i]
        lw $t3, 0($s1)      #value of array[current]

        blt $t3, $t2, swap #if(array[current_pos] < array[i])
        beq $t0, $t1, if_helper #if(i == current_pos and i != length)

        addi $t0, $t0, 8    #i+=2
        addi $s1, $s1, 8

        j while2

    swap:

        #point in i
        lw $t2, 0($s0)
        lw $t3, 4($s0)

        #point in current
        lw $t4, 0($s1)
        lw $t5, 4($s1)

        #array[i] = array[current_pos]
        sw $t2, 0($s1)
        sw $t3, 4($s1)

        #array[current_pos] = array[i]
        sw $t4, 0($s0)
        sw $t5, 4($s0)

        move $s2, $t0   #check_pos = i

        ###################
        li $v0, 1
        move $a0, $t0
        syscall
        ###################

        j while

    if_helper:
        bne $t0, $s7, inc

        #increment i
        addi $t0, $t0, 8
        addi $s0, $s0, 8

        j while2    #continue inner loop


    inc:
        #################
        # li $v0, 1
        # lw $a0 0($s0)
        # syscall
        # li $a0, 0xA        #new line
        # li $v0, 11
        # syscall  
        #################

        addi $t8, $t8, 8    #sorted length
        addi $t1, $t1, 8    #current pos
        addi $s1, $s1, 8
        li $s2, 0

        j while

    end:
        # move $v0, $a0
        li $v0, 20          #TODO change
        move $v1, $a1
    #####  put your codes above this line #####
    jr $ra

sort_points_by_y:
    # sort points in-place by y . Non-decrease order is applied
    # $a0 is num_points, $a1 is array base address
    # note that array has the order as x0, y0, x1, y1, x2, y3, ..., xn , yn
 
    #####  put your codes below this line #####



    
    #####  put your codes above this line #####
    jr $ra