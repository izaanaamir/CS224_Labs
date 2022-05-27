CS224
Lab No. 3
Section No. 6
Izaan Aamir
22001488
13th March,2022


#PART 1: INSTRUCTION COUNT
.data
	newLine: .asciiz "\n"
	addOpMess1: .asciiz "The number of add operations in main are: "
	oriOpMess1: .asciiz "The number of ori operations in main are: "
	lwOpMess1: .asciiz "The number of load word operations in main are: "
	addOpMess2: .asciiz "The number of add operations in subprogram are: "
	oriOpMess2: .asciiz "The number of ori operations in subprogram are: "
	lwOpMess2: .asciiz "The number of load word operations in subprogram are: "

.text
	startMain:	
	
		lw $s5, startMain # to demonstrate lw operation counts
		lw $s6, endMain
		
		add $s7,$s5,$s6 # to demonstrate add operation counts
		add $s7,$s7,$s6
		
		la $a0, startMain # load startMain and endMain addresses
		la $a1, endMain
	
		jal instructionCount
		
		move $s1,$v0 
		move $s2,$v1
		
		li $v0, 4           
		la $a0, addOpMess1
		syscall
		
		li $v0, 1
		move $a0, $s1
		syscall	
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 4           
		la $a0, oriOpMess1
		syscall
		
		li $v0, 1
		move $a0, $s2
		syscall	
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 4           
		la $a0, lwOpMess1
		syscall
		
		li $v0, 1
		move $a0, $s7
		syscall	
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		la $a0, instructionCount # load instructionCount and endInstruction addresses
		la $a1, endInstruction
		
		jal instructionCount
		
		move $s1,$v0
		move $s2,$v1
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 4           
		la $a0, addOpMess2
		syscall
		
		li $v0, 1 # Output the results
		move $a0, $s1
		syscall	
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 4           
		la $a0, oriOpMess2
		syscall
		
		li $v0, 1
		move $a0, $s2
		syscall	
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 4           
		la $a0, lwOpMess2
		syscall
		
		li $v0, 1
		move $a0, $s7
		syscall
		
		li $v0,10
		syscall
	endMain:
	
	
	 instructionCount: 
	 	move $s0,$a0 
	 	move $s1,$a1
	 	add $s7,$0,$0
	 	add $s5,$0,$0
	 	add $s6,$0,$0
	 	
	loop: 	beq $s0,$s1,Exit 
	 	lw $s2,($s0)
	 	srl $s3,$s2,26 # to get the most significant 6 bits of the address
	 	beq $s3,$0,L1 # to check the type of instruction
	 	beq $s3,13, oriInstruc 
	 	beq $s3,35, lwInstruc
	 	addi $s0,$s0,4
	 	j loop
	 	
	 L1:
	 	sll $s4,$s2,26 # to get the least significant 6 bits of the address
	 	srl $s4,$s4,26
	 	beq $s4,32,addInstruc
	 	addi $s0,$s0,4
	 	j loop
	 	
	 addInstruc:	#checks the opcode and adds to that count
	 	addi $s5,$s5,1
	 	addi $s0,$s0,4
	 	j loop
	 oriInstruc:
	 	addi $s6,$s6,1
	 	addi $s0,$s0,4
	 	j loop
	 lwInstruc:	
	 	addi $s7,$s7,1
	 	addi $s0,$s0,4
	 	j loop
	 Exit:
	 	move $v0,$s5
	 	move $v1,$s6
	 	jr $ra	
	endInstruction:

#PART 2: RECURSIVE DIVISION
.data
	Message: .asciiz "Enter a first integer: "	
	newLine: .asciiz "\n"
	Message2: .asciiz "Enter a second integer:"
	Message3: .asciiz "The quotient is: "
	Message4: .asciiz "Do you wish to continue?\nEnter 1 to continue\nEnter 2 to exit"
	Message5: .asciiz "DIVISION BY 0 NOT ALLOWED"
	
.text
	main:		
		li $v0, 4
		la $a0, Message
		syscall
		
		li $v0, 5
		syscall
		move $s0,$v0
		
	loop2:	li $v0, 4
		la $a0, Message2
		syscall
		
		li $v0, 5
		syscall
		move $s1,$v0
		
		beq $s1,0,error # checks for divide by 0 error
		
		move $a0,$s0
		move $a1,$s1
		add $v0,$0,$0
		
		jal recursion
		
		move $s2,$v0
		
		li $v0, 4 
		la $a0, Message3
		syscall
		
		li $v0, 1
		move $a0, $s2
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 4
		la $a0, Message4
		syscall
		
		li $v0, 4 
		la $a0, newLine
		syscall
		
		li $v0, 5 #gets user input for repeating the process
		syscall
		move $s4,$v0
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		beq $s4,1,main
		
		li $v0,10
		syscall
	error:
		li $v0, 4
		la $a0, Message5
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
			
		j loop2
		
	recursion:		
		addi $sp, $sp, -4 
		sw $ra, 0($sp) # saves $ra in stack
		slt $s2,$a0,$a1
		beq $s2,$0,else
		addi $sp, $sp, 8 #base case
		jr $ra
		
	else:	sub $a0,$a0,$a1 #else subtracts $a1 from $a0 and calls recursion again
		addi $v0,$v0,1
		jal recursion
		lw $ra, 0($sp) loads the address of $ra
		addi $sp, $sp, 4
		jr $ra 
