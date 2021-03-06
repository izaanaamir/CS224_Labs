#ARITHMETIC EQUATION
.data
	firstInput: .asciiz "Enter the value of a:"
	secondInput: .asciiz "Enter the value of b:"
	thirdInput: .asciiz "Enter the value of d:"
	newLine: .asciiz "\n"
	Message: .asciiz "The output is:"
	errorMess: .asciiz "Invalid Input! Results in Divide by zero Error"
.text 
	main:		
		li $v0, 4
		la $a0, firstInput
		syscall
		
		
		li $v0, 5
		syscall
		move $t0,$v0
		
		li $v0, 4
		la $a0, secondInput
		syscall
		
	
		li $v0, 5
		syscall
		move $t1,$v0

		
		sub $t3,$t0,$t1 # a- b
		mul $t4, $t0,$t1
		sub $t5,$t4,$t1
		div $t5,$t0
		mfhi $t6
		beq $t6,$zero,error
		div $t3,$t6
		mflo $t7
		
	error: 
		li $v0, 4
		la $a0, errorMess
		syscall
		
		li $v0,10
		syscall
		
	output:	li $v0, 4
		la $a0, Message
		syscall
		
		li $v0,1
		move $a0, $t7
		syscall
		
		li $v0,10
		syscall
	
#PART WHICH TAKES USER INPUT AND DISPLAYS MENU
.data
	array: .space 400
	arrayMess: .asciiz "Enter the digits you want to be saved in the Array:\n"
	arraySizeMess: .asciiz "Please enter the number of elements you want to store:"
	newLine: .asciiz "\n"
	arrayMess2: .asciiz "Here are the following elements in the Array:\n"
	displayGUIMenu: .asciiz "Please choose one of the following options by entering the corresponding number\n"
	option1: .asciiz "1. Find sum of numbers smaller than a given number\n"
	option2: .asciiz "2. Find the number of odd and even numbers in the array\n"
	option3: .asciiz "3. Display the number of occurrences of the array elements NOT divisible by a certain input number\n"
	option4: .asciiz "4. Quit\n"
	summationPrompt: .asciiz "Enter the number from which the sum should be less than: "
	oddNums: .asciiz "The odd numbers are: "
	evenNums: .asciiz "The even numbers are: "
	getInputNum: .asciiz "Enter the number by which to divide: "
	
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
	while:  beq $t1, $t2, displayGUIMessage 
		li $v0, 5
		syscall
		move $t3,$v0
		sw $t3,array($t1)
		addi $t1,$t1,4	
		j while
	
	displayGUIMessage:
		li $v0, 4
		la $a0, displayGUIMenu
		syscall
		
		li $v0, 4
		la $a0, option1
		syscall
		
		li $v0, 4
		la $a0, option2
		syscall
		
		li $v0, 4
		la $a0, option3
		syscall
		
		li $v0, 4
		la $a0, option4
		syscall
		
		li $v0, 5 #GETTING THE OPTION FROM THE USER
		syscall
		move $t1,$v0
		
		beq $t1,1,Summation
		beq $t1,2,OddEven
		beq $t1,3,NotDivisible
		beq $t1,4,Quit
		
	Summation: 	 #PART 1
		li $v0, 4
		la $a0, summationPrompt
		syscall
		
		li $v0, 5 #getting the summation number from the user
		syscall
		move $t2,$v0 #saves number to $t2
		
		add $t1,$zero, $zero
		add $t6,$zero, $zero
		sll $t5,$t0,2
	loop:	beq $t1, $t5, displaySum 
		lw $t4,array($t1)
		addi $t1,$t1,4
		slt $t7,$t4,$t2
		beq $t7,$zero,addProcess 
		add $t6,$t6,$t4
		j loop
		
	addProcess:
		j loop
	
	displaySum:
		li $v0,1
		move $a0, $t6		
		syscall	
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		j displayGUIMessage	
	
	OddEven:add $t1,$zero, $zero #PART 2
		add $t6,$zero, $zero
		addi $t7,$zero,2
		sll $t5,$t0,2
	loop2:	beq $t1, $t5, displayOddEven 
		lw $t4,array($t1)
		div $t4,$t7
		addi $t1,$t1,4
		mfhi $t2
		beq $t2,$zero,evenNumber
		addi $s1,$s1,1
		j loop2
	
	evenNumber: 
		addi $s0,$s0,1	
		j loop2	
	displayOddEven:
	
		li $v0, 4
		la $a0, evenNums
		syscall
		
		li $v0,1
		move $a0, $s0		
		syscall	
		
		li $v0, 4
		la $a0, oddNums
		syscall
		
		li $v0,1
		move $a0, $s1		
		syscall		
	
		li $v0, 4
		la $a0, newLine
		syscall
		
		j displayGUIMessage
		
		
		
	NotDivisible:  #PART 3
		add $t1,$zero, $zero
		add $t6,$zero, $zero
		addi $t7,$zero,2
		sll $t5,$t0,2	
		
		li $v0, 4
		la $a0, getInputNum
		syscall
		
		li $v0, 5
		syscall
		move $t0,$v0
		
	loop3:  beq $t1, $t5, displayNotDivisable 
		lw $t4,array($t1)
		div $t4,$t0
		addi $t1,$t1,4
		mfhi $t2
		bne $t2,$zero,notDivisable
		j loop3
		
	notDivisable:
		addi $s2,$s2,1	
		j loop3	
		
	displayNotDivisable:
		li $v0,1
		move $a0, $s2		
		syscall		
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		j displayGUIMessage
		
										
	Quit:	li $v0,10
		syscall

#PROGRAM 1
##
## Program1.asm - prints out "hello world"
##
##	a0 - points to the string
##

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
	.globl __start 

__start:		# execution starts here
	la $a0,str	# put string address into a0
	li $v0,4	# system call to print
	syscall		#   out a string

	li $v0,10  # system call to exit
	syscall	#    bye bye


#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
str:	.asciiz "0123hello world\n"
n:	.word	10

##
## end of file Program1.asm


#PROGRAM 2
##
## Program2.asm asks user for temperature in Celsius,
##  converts to Fahrenheit, prints the result.
##
##	v0 - reads in Celsius
##	t0 - holds Fahrenheit result
##	a0 - points to output strings
##

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
	.globl __start	

__start:
	la $a0,prompt	# output prompt message on terminal
	li $v0,4	# syscall 4 prints the string
	syscall

	li $v0, 5	# syscall 5 reads an integer
	syscall

	mul $t0,$v0,9	# to convert,multiply by 9,
	div $t0,$t0,5	# divide by 5, then
	add $t0,$t0,32	# add 32

	la $a0,ans1	# print string before result
	li $v0,4
	syscall

	move $a0,$t0	# print integer result
	li $v0,1		# using syscall 1
	syscall

	la $a0,endl	# system call to print
	li $v0,4		# out a newline
	syscall

	li $v0,10		# system call to exit
	syscall		#    bye bye


#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
prompt:	.asciiz "Enter temperature (Celsius): "
ans1:	.asciiz "The temperature in Fahrenheit is "
endl:	.asciiz "\n"

##
## end of file Program2.asm

##
## Program2.asm asks user for temperature in Celsius,
##  converts to Fahrenheit, prints the result.
##
##	v0 - reads in Celsius
##	t0 - holds Fahrenheit result
##	a0 - points to output strings
##

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
	.globl __start	

__start:
	la $a0,prompt	# output prompt message on terminal
	li $v0,4	# syscall 4 prints the string
	syscall

	li $v0, 5	# syscall 5 reads an integer
	syscall

	mul $t0,$v0,9	# to convert,multiply by 9,
	div $t0,$t0,5	# divide by 5, then
	add $t0,$t0,32	# add 32

	la $a0,ans1	# print string before result
	li $v0,4
	syscall

	move $a0,$t0	# print integer result
	li $v0,1		# using syscall 1
	syscall

	la $a0,endl	# system call to print
	li $v0,4		# out a newline
	syscall

	li $v0,10		# system call to exit
	syscall		#    bye bye


#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
prompt:	.asciiz "Enter temperature (Celsius): "
ans1:	.asciiz "The temperature in Fahrenheit is "
endl:	.asciiz "\n"

##
## end of file Program2.asm

# PROGRAM 3
##
##	Program3.asm is a loop implementation
##	of the Fibonacci function
##        

#################################
#					 	#
#		text segment		#
#						#
#################################

	.text		
.globl __start
 
__start:		# execution starts here
	li $a0,3	# to calculate fib(7)
	jal fib		# call fib
	move $a0,$v0	# print result
	li $v0, 1
	syscall

	la $a0,endl	# print newline
	li $v0,4
	syscall

	li $v0,10
	syscall		# bye bye

#------------------------------------------------


fib:	move $v0,$a0	# initialise last element
	blt $a0,2,done	# fib(0)=0, fib(1)=1

	li $t0,0	# second last element
	li $v0,1	# last element

loop:	add $t1,$t0,$v0	# get next value
	move $t0,$v0	# update second last
	move $v0,$t1	# update last element
	sub $a0,$a0,1	# decrement count
	bgt $a0,1,loop	# exit loop when count=0
done:	jr $ra

#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
endl:	.asciiz "\n"

##
## end of Program3.asm
	
