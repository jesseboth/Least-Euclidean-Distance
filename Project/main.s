.data
    filename: .asciiz "sample.bin"
.globl main
.text
    main:
        la $a0 filename
        jal load_points
        move $a0, $v0
        move $a1, $v1
        jal print           #<---------Delete
        move $a0, $v0         #<---------Delete
        move $a1, $v1         #<---------Delete
        # jal sort_points_by_x
        jal find_closest
        move $a0, $v0
        move $a1, $v1
        jal output_cloest_pair
        li $v0 10
        syscall
######################################################        
#----------------------------------------------------#
    print:
        move $s1, $a0
        move $t0, $a1
        li $t2, 0

        #print num_points
        li $v0, 1                     
        syscall
        li $a0, 0xA        #new line
        li $v0, 11
        syscall

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

        li $a0, 0xA        #new line
        li $v0, 11
        syscall
        
        move $v0, $s1
        move $v1, $a1
        jr $ra
#----------------------------------------------------#
######################################################        
        