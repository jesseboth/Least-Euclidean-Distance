.data
	prompt1: .asciiz "Please provide an integer input: "
	newln:	.asciiz "\n"
	
	bad_in: .asciiz "Input invalid, program terminated.\n"
	
	answer: .asciiz "Yeet: "

.text
j main

main_loop:
		blt $t0, $zero, exit
		
		#printing out $t0 to terminal
		li $v0, 1
		move $a0, $t0
		syscall
		
		#print out our new line string
		li $v0, 4
		la $a0, newln
		syscall
		
		addi $t0, $t0, -1
		j main_loop

main:
	#Ask for input
	li $v0, 4
	la $a0, prompt1
	syscall
	
	#Requesting for integer input
	li $v0, 5
	syscall

	move $t0, $v0   #input value moved into $t0
	blt $t0, $zero, bad_input #raise bad_input if value input was less than zero
	
	j main_loop

	
exit:
	li $v0, 10
	syscall
	
bad_input:
	#Letting user know the input was bad.
	li $v0, 4
	la $a0, bad_in
	syscall
	
	j exit