#PART 1. CIRCULAR ARRAYS SHIFTING
.data
	Message: .asciiz "Press the corresponding number for the operation you require\n1. Shift Left Circular\n2. Shift Right Circular\n"
	
	newLine: .asciiz "\n"
	Message2: .asciiz "Enter a decimal number to be shifted\n"
	Message3: .asciiz "Enter the amount by which to be shifted\n"
	Message4: .asciiz "The number to be shifted left was:"
	Message5: .asciiz "The amount by which to shift the number left was:"
	Message6: .asciiz "The shifted amount in hex is:"
	Message7: .asciiz "The number to be shifted right was:"
	Message8: .asciiz "The amount by which to shift the number right was:"
	
.text
	main:		
		li $v0, 4
		la $a0, Message
		syscall
		
		li $v0, 5
		syscall
		move $s0,$v0
		
		beq $s0,1,shiftLeftCircular
		beq $s0,2,shiftRightCircular		
		
	shiftLeftCircular:
		li $v0, 4
		la $a0, Message2
		syscall
		
		li $v0, 5
		syscall
		move $s1,$v0
		
		li $v0, 4
		la $a0, Message3
		syscall
		
		li $v0, 5
		syscall
		move $s2,$v0
		
		move $a0,$s1
		move $a1,$s2
		
		addi $sp, $sp, -8

		sw $s0, 4($sp)
		sw $s1, 0($sp) 
		
		jal performShiftLeft
		
		lw $s1, 0($sp) 
		lw $s0, 4($sp) 
		addi $sp, $sp, 8
		move $s3,$v0
		
		li $v0, 4
		la $a0, Message4
		syscall
			
		li $v0, 1
		move $a0, $s1
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 4
		la $a0, Message5
		syscall
		
		li $v0, 1
		move $a0, $s2
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		
		li $v0, 4
		la $a0, Message6
		syscall
		
		li $v0, 34
		move $a0, $s3
		syscall
		
		li $v0,10
		syscall
		
		
	shiftRightCircular:
		li $v0, 4
		la $a0, Message2
		syscall
		
		li $v0, 5
		syscall
		move $s1,$v0
		
		li $v0, 4
		la $a0, Message3
		syscall
		
		li $v0, 5
		syscall
		move $s2,$v0
		
		move $a0,$s1
		move $a1,$s2
		
		jal performShiftRight
		
		move $s3,$v0
		
		li $v0, 4
		la $a0, Message7
		syscall
		
		li $v0, 1
		move $a0, $s1
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		
		li $v0, 4
		la $a0, Message8
		syscall
		
		li $v0, 1
		move $a0, $s2
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		li $v0, 4
		la $a0, Message6
		syscall
		
		li $v0, 34
		move $a0, $s3
		syscall
		
		li $v0,10
		syscall
		
	performShiftLeft:
		subu $at,$0,$a1
		srlv $at, $a0,$at
		sllv $v0, $a0,$a1
		or $v0,$v0,$at
		jr $ra
		
	performShiftRight:
		subu $at,$0,$a1
		sllv $at, $a0,$at
		srlv $v0, $a0,$a1
		or $v0,$v0,$at
		jr $ra
	

	

#PART 2: ARRAY PROCESSING

.data
	arrayMess: .asciiz "Please choose the operation by entering the corresponding number:\n1. Return the minimum value stored in the array\n2. Return the maximum value stored in the array\n"
	arrayMess2: .asciiz "3. Find the sum of all array elements\n4. Check if array elements are a palindrome\n5. Quit\n"
	arraySizeMess: .asciiz "Please enter the number of elements you want to store:"
	newLine: .asciiz "\n"
	arrayMess3: .asciiz "Enter the digits you want to be saved in the Array:\n"
	areIdentical: .asciiz "The minimum number in the array is:"
	areNotIdentical: .asciiz "The array's lower and upper half are not identical\n"
	minMessage: .asciiz "The minimum value in the array is: "
	maxMessage: .asciiz "The maximum value in the array is: "
	sumMessage: .asciiz "The sum of the elements of the array is:"
	ispalindromeMesage: .asciiz "The array is a palindrome"
	isnotpalindromeMesage: .asciiz "The array is not a palindrome"

.text
	main:
	
		jal createArray
		
		move $a0,$v0
		move $a1,$v1
		jal arrayOperations
		
		li $v0,10
		syscall
		
	createArray:
		
		li $v0, 4            #Prints the array message
		la $a0, arraySizeMess
		syscall
		
		li $v0, 5           # gets the number of elements
    		syscall
    		move $v1,$v0
    		  		
    		sll $s0,$v0,2   # multiplies by 4
    				
    		move $a0,$s0	#allocates dynamic memory
    		li $v0,9
    		syscall
    		
    		move $s5,$v0 # moves the value of the starting address temporarily at $t5 as $v0 is used in system calls
    		move $s6,$v0
    		
    		#enter array Message
		li $v0, 4
		la $a0, arrayMess3
		syscall
    		
    	while:  beq $s1, $s0, return 
		li $v0, 5
		syscall
		
		sw $v0,($s5)
		addi $s1,$s1,4	
		addi $s5,$s5,4	
		j while
		
	return:
		move $v0,$s6
	 	jr $ra
	
	arrayOperations:
		move $s0,$a0 #puts starting index in $s0
		move $s1,$a1 #puts size in $s1
	
while2:		li $v0, 4           
		la $a0, arrayMess
		syscall
		
		li $v0, 4           
		la $a0, arrayMess2
		syscall
		
		li $v0, 5
		syscall
		move $s2,$v0
				
		addi $sp, $sp, -8
		sw $s0, 4($sp)
		sw $s1, 0($sp) 
		
		beq $s2,1,returnMin	
		beq $s2,2,returnMax
		beq $s2,3,returnSum
		beq $s2,4,isPalindrome
		beq $s5,5,returnline
		
		
	
returnline:	
		
		jr $ra
		
	returnMin:
		
		li $v0, 4           
		la $a0, minMessage
		syscall
		
		sll $s2,$s1,2 	# multiplies $s1 by 4 and sets it to $s2
		addi $s2,$s2,-4
		lw $s4,($s0) 	#loads the value in $s0 of heap memory into $s4
		addi $s0,$s0,4
		add $s7,$0,$0
	loop:	beq $s7, $s2, Equal
		lw $s5,($s0)
		slt $s6,$s5,$s4
		bne $s6,$0,setLessthan
		addi $s7,$s7,4
		addi $s0,$s0,4
		j loop
		
	setLessthan:
		move $s4,$s5	
		addi $s7,$s7,4
		addi $s0,$s0,4		
		j loop
	Equal:
		li $v0, 1
		move $a0, $s4
		syscall	
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		lw $s1, 0($sp) 
		lw $s0, 4($sp) 
		addi $sp, $sp, 8
		
		j while2
	returnMax:
		
		li $v0, 4           
		la $a0, maxMessage
		syscall
		
		sll $s2,$s1,2 	# multiplies $s1 by 4 and sets it to $s2
		addi $s2,$s2,-4
		lw $s4,($s0) 
		add $s7,$0,$0	
		addi $s0,$s0,4
	loop2:	beq $s7, $s2, Equal
		lw $s5,($s0)
		slt $s6,$s5,$s4
		beq $s6,$0,setGreaterThan
		addi $s7,$s7,4
		addi $s0,$s0,4
		j loop2
		
	setGreaterThan:
		move $s4,$s5	
		addi $s0,$s0,4	
		addi $s7,$s7,4	
		j loop2
		
	returnSum:	
		li $v0, 4           
		la $a0, sumMessage
		syscall
		
		sll $s2,$s1,2
		add $s7,$0,$0
		add $s4,$0,$0
	loop3:	beq $s7, $s2, Equal
		lw $s5,($s0)
		add $s4,$s4,$s5
		addi $s0,$s0,4
		addi $s7,$s7,4
		j loop3
		
	isPalindrome:			
		sll $s2,$s1,2 # multiply by 4
		add $s5,$s0,$s2 # finds the last element
		addi $s5,$s5,-4 #to start from the last element
		srl $s2,$s1,2
		sll $s2,$s2,1
		sll $s2,$s2,2
			
		add $s1,$0,$0
	loop4: 	beq $s1, $s2, checkPalindrome
		lw $s4,($s0) # loads an element from first half into $t4
		lw $s6,($s5) # loads an element from second half into $t6
		bne $s4,$s6,checkfailed	
		addi $s0,$s0,4
		addi $s1,$s1,4   #increments $t1
		addi $s5,$s5,-4
		j loop4
		
	checkPalindrome:
		li $v0, 4           
		la $a0, ispalindromeMesage
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		j while2
		
	checkfailed:
		li $v0, 4           
		la $a0, isnotpalindromeMesage
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		j while2
