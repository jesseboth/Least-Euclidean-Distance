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

find_closest:

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
    #---------------------------------------------------------------#

    move $s7, $read         #store return

    move $t0, $a0           #num_points
    move $t1, $a1           #base_address
    move $t2, $t1           #point 2
    move $t3, $a0           #count
    addi $t3, $t3, -1       #decrementer

    beq $s2, $zero, max      #if(s2 == 0)   

    loop:
        beq $t2, $zero, recurse
        addi $t2, $t2, 8    #to next point
        addi $t2, $t2, -1   #decrement for next iter
        j find_euclidean

    find_euclidean:
        sw $a0, 0($t1)      #x0
        sw $a1, 4($t1)      #y0
        sw $a2, 0($t2)      #x1
        sw $a3, 4($t2)      #y1
        jal euclidean_distance

        #check if d < least
        blt $v0, $s2, new_least
        j loop

    new_least:
        move $s0, $a0       #store x0
        move $s1, $a2       #store x1
        move $s2, $v0       #store least

        #exit if distance = 0
        beq $s2, $zero, exit 
        j loop

    recurse:
        addi $a0, $t0, -1   #num_points -1
        sw $a1, 8($t1)      #next point
        move $ra, $s7       #save return
        j find_closest

    max:
        li $s2, 0xEF4201    #2800^2 + 2800^2 +1
        j loop

    exit:
        move $ra, $s7
        move $v0, $s0
        move $v1, $s1

########################
old_find_closest:
    move $t0, $a0 #num_points
    move $t1, $a1 #base_address

    li $t3, 8 #index
    sw $t4, 0($t1) #store for second point
    li $t5, 1 #count (numpoints -1)

    beq $s2, $zero max #if(s2 == 0)
    
    #check if done
    addi $t2, $zero, 1
    beq $a0, $t2, exit

    #while loop
    j loop

    loop:
        beq $t5, $t0, recurse #if t5 == t0 -> if count == num_points

        sw $t4, 8($t4) #next point

        #store for next iteration
        addi $t3, $t3, 8 #next pair index
        addi $t5, $t5, 1 #count +1
        
        j find_euclidean #check base_address and next point


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
        li $s2, 0xEF4201
        j find_euclidean

    exit:
        #store the return values
        move $v0, $s0
        move $v1, $s1