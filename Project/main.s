.data
    filename: .asciiz "sample.bin"
.globl main
.text
    main:
        la $a0 filename
        jal load_points
        move $a0, $v0
        move $a1, $v1
        jal sort_points_by_x
        jal find_closest
        move $a0, $v0
        move $a1, $v1
        jal output_cloest_pair
        li $v0 10
        syscall
