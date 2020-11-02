.data
    str_prefix_output: .asciiz "The closest pair of points is "
    num_points: .word 0
    buffer: .space 1024
.text
load_points:
    # $a0 is the based address of the file name string
    # $v0 is the number of points
    # $v1 is the based address of points array
    # i.e., $v1 is x0, 4($v1) is y0, 8($v1) is x1, etc.

    #####  put your codes below this line #####
    # li $v0 13 #open
    # syscall

    # move $a0,  $v0 #save file descriptor
    # jal load_points_helper
    

    # li $v0 16 #close
    # syscall


    li $v0, 13          # system call for open file
    li $a1, 0           #flag
    li $a2, 0           #mode
    syscall             # open a file 

    move $a0, $v0       # save the file descriptor  
    move $s0, $v0

    jal load_points_helper

    li $v0, 16      #close
    move $a0, $s0   #set file descriptor
    syscall
    
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

    # reading from file just opened
    li   $v0, 14        #read
    la   $a1, buffer    # address
    li   $a2,  4        # length
    syscall            

    #allocate space
    # li $v0 9          #sbrk
    # syscall

    # Printing File Content
    li  $v0, 1          #print int
    la  $a0, buffer     #location
    syscall             
    
    #####  put your codes above this line #####
    jr $ra
