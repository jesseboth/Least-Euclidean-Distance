.data
    start: .asciiz "Little Endian: "
	answer: .asciiz "Big Endian: "

.text
j go

go:

    #0xF8A912B6
    addi $s0, $zero, 0
    li $s0, -123137354

    li $v0, 1
    move $a0, $s0
    syscall

    # lw $t0, 0($s0)
    # lw $t1, 1($s0)
    # lw $t2, 2($s0)
    # lw $t3, 3($s0)

    # sw $t3, 0($s0)
    # sw $t2, 1($s0)
    # sw $t1, 2($s0)
    # sw $t0, 3($s0)

    # li $v0, 1
    # move $a0, $s0
    # syscall

    li $v0, 10
	syscall

    
