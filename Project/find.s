#algo: recursive n^2/2
find_closest:
    # $a0 is num_points, $a1 is array base address
    # $v0, $v1 is the address of the two points of the closest pair
    # i.e., $v0 is the address of x0 in the array, $v1 is the address of x1 in the array

    #####  put your codes below this line #####
    #---------------------------------------------------------------#
    #Euclidean:
        # $a0 is x0 $a1 is y0; a2 is x1 a3 is y1
        # $v0 is the calculated distance
        #Meaning that these values need to be overwritten
    
    #Find:
        #Need to store the argument values so they are not lost
        #$s0 = x0 (return value) *(x0 + 4 = y0)
        #$s1 = x1 (return value)
        #$s4 = least
    #---------------------------------------------------------------#
    beq $s3, $0, max

    find_it:
        move $t0, $a0       #num_points
        move $t1, $a1       #base_address
        move $t2, $a1       #point 2
        addi $t3, $a0, -1   #decrementer

        li $t5, 1
        beq $t0, $t5, exit   

    loop:

        beq $t3, $zero, recurse
        addi $t2, $t2, 8    #to next point
        addi $t3, $t3, -1   #decrement for next iter
        j find_euclidean

    find_euclidean:
        lw $a0, 0($t1)      #x0
        lw $a1, 4($t1)      #y0
        lw $a2, 0($t2)      #x1
        lw $a3, 4($t2)      #y1
        jal euclidean_distance

        #check if d < least
        blt $v0, $s4, new_least
        j loop

    new_least:
        move $s0, $t1       #store x0
        move $s1, $t2       #store x1
        move $s4, $v0       #store least

        #exit if distance = 0
        beq $s4, $zero, exit 
        j loop

    recurse:
        addi $a0, $t0, -1   #num_points -1
        addi $a1, $t1, 8    #next point
        j find_closest
        
    max:
        addi $s3, $s3, 1
        addi $sp, $sp, -12
        sw $ra, 0($sp)          #store return
        sw $a0, 4($sp)          #store num_points
        sw $a1, 8($sp)          #store base_address
        li $s4, 33554433        #4096^2 + 4096^2 +1
        j find_it

    exit:
        addi $s3, $s3, -1
        lw $ra, 0($sp)      #restore return
        lw $a0, 4($sp)      #restore num_points
        lw $a1, 8($sp)      #restore base_address
        move $v0, $s0
        move $v1, $s1
    
    #####  put your codes above this line #####
    jr $ra