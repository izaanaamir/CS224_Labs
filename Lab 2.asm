CS224
Lab No. 02
Section No. 006
Izaan Aamir
22001488
04/03/2022




.data
	arrayMess: .asciiz "Please choose the operation by entering the corresponding number:\n1. Return the minimum value stored in the array\n2. Return the maximum value stored in the array\n"
	arrayMess2: .asciiz "3. Find the sum of all array elements\n4. Check if array elements are a palindrome\n5. Quit\n"
	arraySizeMess: .asciiz "Please enter the number of elements you want to store:"
	newLine: .asciiz "\n"
	tabMess: .asciiz "\t"
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
		
		addi $sp, $sp, -8
		sw $a0, 4($sp)
		sw $a1, 0($sp) 
		
		jal bubbleSort
		
		lw $a1, 0($sp) 
		lw $a0, 4($sp) 
		addi $sp, $sp, 8
		
		jal processSortedArray
		
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
	 
	 bubbleSort:
	 	move $s0,$a0 #puts starting index in $s0
		move $s1,$a1 #puts size in $s1
		
		add $s2,$0,$0 #used
		add $s3,$0,$0 #loadin first word
		add $s4,$0,$0 #loading second world
		add $s5,$0,$0
		add $s6,$0,$0 # inner loop max number
		add $s7,$0,$0 
		
		sll $s2,$s1,2
		addi $s2,$s2,-4 # last element until which to loop until
		move $s6,$s0
		
		
		
outerloop:	beq $s7,$s2,Exit
		add $s5,$0,$0		
		move $s6,$s0	
			
							
innerLoop:	beq $s5,$s2, outerLoopCond
		lw $s3,($s6)
		addi $s6,$s6,4
		lw $s4,($s6)
		addi $s5,$s5,4
		slt $s1,$s3,$s4
		bne $s1,$0,skip
		sw $s3,($s6)
		addi $s6,$s6,-4
		sw $s4,($s6)
		addi $s6,$s6,4
		
	skip:   j innerLoop	
		
outerLoopCond: 	addi $s7,$s7,4
		j outerloop
		
	Exit:	jr $ra
	
processSortedArray:
		move $s0,$a0 #puts starting index in $s0
		move $s1,$a1
		sll $s2,$s1,2 	# multiplies $t1 by 4 and sets it to $t3
		#addi $s2,$s2,-4
		 
		add $s7,$0,$0	#loads the value in $t0 of heap memory into $t4
	loop3:	beq $s7, $s2, Exit3	
		lw $s4,($s0)
		addi $s7,$s7,4
		addi $s0,$s0,4
		
		srl $s6,$s7,2
		
		li $v0, 1        
		move $a0, $s6
		syscall
		
		addi $sp, $sp, -24
	
		sw $s0, 20($sp)
		sw $s1, 16($sp)
		sw $s2, 12($sp)
		sw $s3, 8($sp)
		sw $ra, 4($sp)
		sw $s4, 0($sp)
		
		add $s1,$0,$0
		addi $s3,$0,10
		
		jal sumDigits
		
		lw $s4, 0($sp)
		lw $ra,4($sp)
		lw $s3, 8($sp) 
		lw $s2, 12($sp)
		lw $s1, 16($sp) 
		lw $s0, 20($sp) 
		
		addi $sp, $sp, 24
		
		li $v0, 4            #Prints the array message
		la $a0, tabMess
		syscall
		
		li $v0, 1          
		move $a0, $v1
		syscall
		
		li $v0, 4            #Prints the array message
		la $a0, tabMess
		syscall
		
		li $v0, 1          
		move $a0, $s4
		syscall
		
		li $v0, 4           
		la $a0, newLine
		syscall
		
		j loop3
		
	sumDigits:
		div $s4,$s3	 
		mflo $s2 #quotient
		mfhi $s0 #remainder
		beq $s2,0,Exit2
		add $s1,$s1,$s0
		move $s4,$s2
		j sumDigits
		
		
	Exit2:
		add $s1,$s1,$s0
		move $v1,$s1
		jr $ra	
		
	Exit3:
		jr $ra