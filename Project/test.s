.data
    filename: .asciiz "C:\Users\jesse\Documents\Homework\CSE-341\code\Project\sample.bin"
    str: .asciiz "N = "
    buffer: .word 0

.text
main:
    # open file.
    li $v0, 13
    la $a0, filename
    li $a1, 0
    li $a2, 0
    syscall
    # s0 = file descripter 
    move $s0, $v0

    # read
    li $v0, 14
    move $a0, $s0
    la $a1, buffer
    li $a2, 4
    syscall

    # print 'N = '
    li $v0, 4
    la $a0, str
    syscall

    # print number of points/
    li $v0, 1
    lw $a0, buffer
    syscall

    # close file
    li $v0, 16
    move $a0, $s0
    syscall