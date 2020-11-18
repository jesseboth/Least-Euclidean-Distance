.text
sort_points_by_x:
    # sort points in-place by x . Non-decrease order is applied
    # $a0 is num_points, $a1 is array base address
    # note that array has the order as x0, y0, x1, y1, x2, y3, ..., xn , yn
 
    #####  put your codes below this line #####

    move $s0, $a0       #num_points
    move $s1, $a1       #base_address
    li $s2, 1           #end
    
    j sort_x


    sort_x:
        beq $s0, $s2, exit_x #if(num_points == 1){exit}
        move $t0, $s0       #num_points
        move $t1, $s1       #base_address
        move $t2, $s1       #checking
        addi $t3, $s0, -1   #decrementer

        j loop_x

    loop_x:
        beq $t3, $zero, recurse_x
        addi $t2, $t2, 8        #to next point
        addi $t3, $t3, -1       #decrement

        j compare_x

    compare_x:
        lw $t4, 0($t1)      #x0
        lw $t5, 0($t2)      #x1

        #if(x1 < x0)
        blt $t5, $t4, swap_x
        j loop_x

    swap_x:
        lw $t6, 4($t1) #y0
        lw $t7, 4($t2) #y1

        #old least
        sw $t4, 0($t2)
        sw $t6, 4($t2)

        #new least
        sw $t5, 0($t1)
        sw $t7, 4($t1)
        j loop_x

    recurse_x:

        addi $s0, $t0, -1   #num_points -1
        addi $s1, $t1, 8    #next point
        j sort_x

        

    exit_x:

    #no return (v0)
    #####  put your codes above this line #####
    jr $ra

sort_points_by_y:
    # sort points in-place by y . Non-decrease order is applied
    # $a0 is num_points, $a1 is array base address
    # note that array has the order as x0, y0, x1, y1, x2, y3, ..., xn , yn
 
    #####  put your codes below this line #####

    move $s0, $a0       #num_points
    addi $s1, $a1, 4       #base_address
    li $s2, 1           #end
    
    j sort_y


    sort_y:
        beq $s0, $s2, exit_y #if(num_points == 1){exit}
        move $t0, $s0       #num_points
        move $t1, $s1       #base_address
        move $t2, $s1       #checking
        addi $t3, $s0, -1   #decrementer

        j loop_y

    loop_y:
        beq $t3, $zero, recurse_y
        addi $t2, $t2, 8        #to next point
        addi $t3, $t3, -1       #decrement

        j compare_y

    compare_y:
        lw $t4, 0($t1)      #y0
        lw $t5, 0($t2)      #y1

        #if(x1 < x0)
        blt $t5, $t4, swap_y
        j loop_y

    swap_y:
        lw $t6, -4($t1) #x0
        lw $t7, -4($t2) #x1

        #old least
        sw $t4, 0($t2)
        sw $t6, -4($t2)

        #new least
        sw $t5, 0($t1)
        sw $t7, -4($t1)
        j loop_y

    recurse_y:

        addi $s0, $t0, -1   #num_points -1
        addi $s1, $t1, 8    #next point
        j sort_y

        

    exit_y:


    
    #####  put your codes above this line #####
    jr $ra
