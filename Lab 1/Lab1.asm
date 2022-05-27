#PART 1: TWISTING AN ARRAY
.data
	array: .space 80
	arrayMess: .asciiz "Enter the digits you want to be saved in the Array:\n"
	arraySizeMess: .asciiz "Please enter the number of elements you want to store:"
	newLine: .asciiz "\n"
	doneSoFar: .asciiz "Done So far"
	arrayMess2: .asciiz "Here are the following elements in the Array:\n"
.text 
	main:		
		li $v0, 4
		la $a0, arraySizeMess
		syscall
		
		#getting the number of elements of the Array
		li $v0, 5
		syscall
		move $t0,$v0
		
		#enter array Message
		li $v0, 4
		la $a0, arrayMess
		syscall
		
		#Stores the user inputs in the array
		add $t1,$zero, $zero
		add $t3,$zero, $zero
		sll $t2,$t0,2
	while:  beq $t1, $t2, displayMessage 
		li $v0, 5
		syscall
		move $t3,$v0
		sw $t3,array($t1)
		addi $t1,$t1,4	
		j while
		
	displayMessage:
		li $v0, 4
		la $a0, arrayMess2
		syscall
		add $t1,$zero, $zero
	loop:	beq $t1, $t2, twistedArray 
		lw $t4,array($t1)
		addi $t1,$t1,4
		li $v0,1
		move $a0, $t4		
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		j loop
		
	twistedArray:
		add $t1,$zero, $zero
		div $t2,$t0, 2 # divides the total number of elements by 2
		mfhi $t7
		bne $t7,$zero,oddLoop
	loop2:	add $t5,$t5,$t2 # determines middle+1
		sll $t2,$t2,2	
		sll $t5,$t5,2	
	evenLoop: beq $t1, $t2, displayTwistedArray
		lw $t4,array($t1) # loads an element from first half into $t4
		lw $t6,array($t5) # loads an element from second half into $t6
		sw $t6,array($t1) # saves the value in $t6 to the first half of the array	
		sw $t4,array($t5) # saves the value in $t4 to the second half of the array	
		addi $t1,$t1,4   #increments $t1
		addi $t5,$t5,4
		j evenLoop
		
	oddLoop: 
		addi $t5,$zero,1
		j loop2
		
	displayTwistedArray:
		li $v0, 4
		la $a0, arrayMess2
		syscall
		add $t1,$zero, $zero
		sll $t2,$t0,2
	loop3:	beq $t1, $t2, Exit 
		lw $t4,array($t1)
		addi $t1,$t1,4
		li $v0,1
		move $a0, $t4		
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		j loop3
	Exit:
		li $v0,10
		syscall

#PART 2: CHECKING IF FIRST AND SECOND HALF OF AN ARRAY ARE IDENTICAL
.data
	array: .space 80
	arrayMess: .asciiz "Enter the digits you want to be saved in the Array:\n"
	arraySizeMess: .asciiz "Please enter the number of elements you want to store:"
	newLine: .asciiz "\n"
	arrayMess2: .asciiz "Here are the following elements in the Array:\n"
	areIdentical: .asciiz "The array's lower and upper half are identical\n"
	areNotIdentical: .asciiz "The array's lower and upper half are not identical\n"
.text 
	main:		
		li $v0, 4
		la $a0, arraySizeMess
		syscall
		
		#getting the number of elements of the Array
		li $v0, 5
		syscall
		move $t0,$v0
		
		#enter array Message
		li $v0, 4
		la $a0, arrayMess
		syscall
		
		#Stores the user inputs in the array
		add $t1,$zero, $zero
		add $t3,$zero, $zero
		sll $t2,$t0,2
	while:  beq $t1, $t2, displayMessage 
		li $v0, 5
		syscall
		move $t3,$v0
		sw $t3,array($t1)
		addi $t1,$t1,4	
		j while
		
	displayMessage:
		li $v0, 4
		la $a0, arrayMess2
		syscall
		add $t1,$zero, $zero
	loop:	beq $t1, $t2, checkIdentical 
		lw $t4,array($t1)
		addi $t1,$t1,4
		li $v0,1
		move $a0, $t4		
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		j loop
		
	checkIdentical:
		add $t1,$zero, $zero
		div $t2,$t0, 2 # divides the total number of elements by 2
		mfhi $t7
		bne $t7,$zero,oddLoop
	loop2:	add $t5,$t5,$t2 # determines middle+1
		sll $t2,$t2,2	
		sll $t5,$t5,2	
	evenLoop: beq $t1, $t2, Equal
		lw $t4,array($t1) # loads an element from first half into $t4
		lw $t6,array($t5) # loads an element from second half into $t6
		bne $t4,$t6,notEqual	
		addi $t1,$t1,4   #increments $t1
		addi $t5,$t5,4
		j evenLoop
		
	oddLoop: 
		addi $t5,$zero,1
		j loop2
		
	notEqual:
		li $v0, 4
		la $a0, areNotIdentical
		syscall
		j Exit
		
	Equal:
		li $v0, 4
		la $a0, areIdentical
		syscall
		j Exit
		
	Exit:
		li $v0,10
		syscall
		

# PART 3: CALCULATING AN ARITHMETIC EXPRESSION
.data
	firstInput: .asciiz "Enter the value of a:"
	secondInput: .asciiz "Enter the value of b:"
	thirdInput: .asciiz "Enter the value of c:"
	newLine: .asciiz "\n"
	Message: .asciiz "The output is:"
.text 
	main:		
		li $v0, 4
		la $a0, firstInput
		syscall
		
		#getting the number of elements of the Array
		li $v0, 5
		syscall
		move $t0,$v0
		
		li $v0, 4
		la $a0, secondInput
		syscall
		
		#getting the number of elements of the Array
		li $v0, 5
		syscall
		move $t1,$v0
		
		li $v0, 4
		la $a0, thirdInput
		syscall
		
		#getting the number of elements of the Array
		li $v0, 5
		syscall
		move $t2,$v0
		
		sub $t3,$t1,$t2
		mul $t4, $t0,$t3
		
		#addi $t6,$zero,$zero
	loop:	sgt $t6, $t7, $t4
		bne $t6,$zero,calculate
		addi $t7,$t7,16
		j loop
		
	calculate:	
		addi $t7,$t7,-16
		sub $t7,$t4,$t7
		j output
		
	output:	li $v0, 4
		la $a0, Message
		syscall
		
		li $v0,1
		move $a0, $t7
		syscall
		
		li $v0,10
		syscall
		
