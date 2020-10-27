.data
    str_prefix_output: .asciiz "The closest pair of points is "
    num_points: .word 0

.text
load_points:
    # $a0 is the based address of the file name string
    # $v0 is the number of points
    # $v1 is the based address of points array
    # i.e., $v1 is x0, 4($v1) is y0, 8($v1) is x1, etc.

    #####  put your codes below this line #####



    
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



    
    #####  put your codes above this line #####
    jr $ra
