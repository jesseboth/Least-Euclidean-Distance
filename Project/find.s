.data
    hello: .asciiz "It is running\n"
.text
find_closest:
    # $a0 is num_points, $a1 is array base address
    # $v0, $v1 is the address of the two points of the closest pair
    # i.e., $v0 is the address of x0 in the array, $v1 is the address of x1 in the array

    #####  put your codes below this line #####

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

    beq $s2, $zero max #if(s2 == 0)
    
    #check if done
    addi $t2, $zero, 1
    beq $a0, 1, exit

    #find distance
    j find_euclidean

    find_euclidean:
        sw $a0, 0($t1)  #x0
        sw $a1, 4($t1)  #y0
        sw $a2, 8($t1)  #x1
        sw $a3, 12($t1) #y1
        jal eulcidean_distance

        #check if d < least
        blt $v0, $s2, new_least

        #again
        j recurse

    new_least:
        move $s0, $a0 #store x0
        move $s1, $a2 #store x1
        move $s2, $v0 #store least

        beq $s2, $zero, exit #exit if distance = 0

        #again
        j recurse
        

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
