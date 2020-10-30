.data
    hello: .asciiz "It is running\n"
.text
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
        #$s2 = least
        #$t0 = num_points
        #$t1 = baseaddress

    #---------------------------------------------------------------#

    move $t0, $a0 #num_points
    move $t1, $a1 #base_address

    li $t3, 8 #index
    sw $t4, $t3($t1) #2nd point
    li $t5, 1 #count (numpoints -1)

    beq $s2, $zero max #if(s2 == 0)
    
    #check if done
    addi $t2, $zero, 1
    beq $a0, $t2, exit

    #while loop
    j loop

    loop:
        beq $t5, $t0, recurse #if t5 == t0 -> if count == num_points

        sw $t4, $t3($t1) #next point

        #store for next iteration
        addi $t3, $t3, 8 #next pair index
        addi $t5, $t5, 1 #count +1
        
        find_euclidean #check base_address and next point


    find_euclidean:
        sw $a0, 0($t1)  #x0
        sw $a1, 4($t1)  #y0
        sw $a2, 0($t4)  #x1
        sw $a3, 4($t4) #y1
        jal euclidean_distance

        #check if d < least
        blt $v0, $s2, new_least

        j loop

    new_least:
        move $s0, $a0 #store x0
        move $s1, $a2 #store x1
        move $s2, $v0 #store least

        beq $s2, $zero, exit #exit if distance = 0

        j loop
        

    recurse:
        #set arguments
        addi $a0, $t0, -1
        sw $a1, 8($t1) #to next x,y
        j find_closest
        
    max:
        #stores the greatest value least can be
        li $s2, 0xEF4200
        j find_euclidean

    exit:
        #store the return values
        move $v0, $s0
        move $v1, $s1

    #------------------------------------------------------------#
    # j test
    # test:
    #     li $v0, 4
	#     la $a0, hello
	#     syscall

	#     li $v0,10
	#     syscall
    #------------------------------------------------------------#
    
    #####  put your codes above this line #####
    # jr $ra
