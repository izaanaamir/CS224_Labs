.data
	arrayMess: .asciiz "Please choose the operation by entering the corresponding number:\n1. Return the minimum value stored in the array\n2. Return the maximum value stored in the array\n"
	arrayMess2: .asciiz "3. Find the sum of all array elements\n4. Check if array elements are a palindrome\n5. Quit\n"
	MatrixSizeMess: .asciiz "Please enter the dimensions of the matrix:"
	newLine: .asciiz "\n"
	arrayMess3: .asciiz "Enter the digits you want to be saved in the Matrix row by row:\n"
	areIdentical: .asciiz "The minimum number in the array is:"
	areNotIdentical: .asciiz "The array's lower and upper half are not identical\n"
	rowMess: .asciiz "Enter the row of the matrix: "
	colMess: .asciiz "Enter the column of the matrix: "
	copyMess: .asciiz "Would you like to perform row-wise or column wise copy:\n1. Row-wise:\n2. Column Wise\n"
	ispalindromeMesage: .asciiz "The array is a palindrome"
	displayCopyMatrixOp: .asciiz "Press 1 to display original matrix. Press 2 to display copied matrix\n"
	MatrixMess: .asciiz "Please choose the operation by entering the corresponding number:\n1. Enter the matrix dimensions and specify the values\n2. Enter the matrix dimensions and enter in-order numbers\n"
	MatrixMess2: .asciiz "3. Display a desired element of the matrix by specifying its row and column number\n4. Display entire matrix row by row for matrixes less than size 4\n"
	MatrixMess3: .asciiz "5. Copy a matrix to another matrix: (row wise or column wise)\n6. Quit\n"
.text
	main:
		li $v0, 4            #Prints the array message
		la $a0, MatrixMess
		syscall
		
		li $v0, 4            #Prints the array message
		la $a0, MatrixMess2
		syscall
		
		li $v0, 4            #Prints the array message
		la $a0, MatrixMess3
		syscall
		
		li $v0, 5           # gets the number of elements
    		syscall
    		
    		beq $v0,1,enterDimensionsSpec
    		beq $v0,2,enterDimensionsNotSpec
    		beq $v0,3,displayRowCol
    		beq $v0,4,displayEntireMatrix
    		beq $v0,5,copyMatrix
    		beq $v0,6,quit


		
	enterDimensionsSpec:
		
		li $v0, 4            #Prints the Matrix size message
		la $a0, MatrixSizeMess
		syscall
		
		li $v0, 5           # gets the number of elements of matrix
    		syscall
    		move $s0,$v0	#stores dimensions of matrix in $s0

    		  		
    		mul $s1,$s0,$s0 		#stores total number of elements in $s1
    		sll $s2,$s1,2   # multiplies by 4, stores total number of elements in $s2
    				
    		move $a0,$s2	#allocates dynamic memory
    		li $v0,9
    		syscall
    		
    		move $s3,$v0 # moves the value of the starting address temporarily at $s2 as $v0 is used in system calls
    		
    		#enter array Message
		li $v0, 4
		la $a0, arrayMess3
		syscall
    		
    		add $t0,$0,$0
    		add $t1,$0,$0   
    		add $t2,$0,$0		
    		move $t1,$s1
    		move $t2,$s3
    		
    	while:  beq $t0, $t1, main 
		li $v0, 5
		syscall
		
		sw $v0,($t2)
		addi $t0,$t0,1	
		addi $t2,$t2,4	
		j while

	enterDimensionsNotSpec:
		li $v0, 4            #Prints the array message
		la $a0, MatrixSizeMess
		syscall
		
		li $v0, 5           # gets the number of elements
    		syscall
    		move $s0,$v0	#stores dimensions of matrix in $s0
    		  		
    		mul $s1,$s0,$s0 		
    		sll $s2,$s1,2   # multiplies by 4
    				
    		move $a0,$s2	#allocates dynamic memory
    		li $v0,9
    		syscall
    		
    		move $s3,$v0 # moves the value of the starting address temporarily at $s2 as $v0 is used in system calls
    		
    		
    		add $t0,$0,$0
    		add $t1,$0,$0   
    		add $t2,$0,$0	
    		addi $t3,$0,1
    		move $t1,$s1
    		move $t2,$s3
    		
    	while2: beq $t0, $t1, main 		
		sw $t3,($t2)
		addi $t2,$t2,4	
		addi $t3,$t3,1	
		addi $t0,$t0,1
		j while2

	displayRowCol:
    		add $t0,$0,$0
    		add $t1,$0,$0   
    		add $t2,$0,$0	
    		add $t3,$0,$0
    		add $t4,$0,$0
		
		li $v0, 4            #Prints the array message
		la $a0, rowMess
		syscall

		li $v0, 5           # gets the row
    		syscall
    		move $t0,$v0
    		
    		li $v0, 4            #Prints the array message
		la $a0, colMess
		syscall
		
		
		li $v0, 5           # gets the number of elements
    		syscall
    		move $t1,$v0
    		
    		addi $t0,$t0,-1
    		addi $t1,$t1,-1
    		mul $t0,$t0,$s0
    		mul $t0,$t0,4
    		
    		mul $t1,$t1,4
    		
    		add $t2,$t1,$t0
    		
    		add $t3,$t2,$s3
    		
    		lw $t4, ($t3)
    		
    		li $v0, 1
		move $a0, $t4
		syscall	
		
		li $v0, 4
		la $a0, newLine
		syscall	
		
    		
    		j main
    		
    	displayEntireMatrix:
    		
    		li $v0, 4
		la $a0, displayCopyMatrixOp
		syscall	
		
		li $v0, 5           # gets the number of elements
    		syscall
    		
    		beq $v0,1, dispOrg
    		beq $v0,2, displayCopied
   	displayCopied:
		add $t0,$0,$0
    		move $t1,$s1  
    		move $t2,$s4	
    		move $t3,$s0
    		add $t4,$0,$0
    		add $t5,$0,$0
    		addi $t6,$t0,1

    		j while3
    		
    dispOrg:	add $t0,$0,$0
    		move $t1,$s1  
    		move $t2,$s3	
    		move $t3,$s0
    		add $t4,$0,$0
    		add $t5,$0,$0
    		addi $t6,$t0,1

    		
    	while3: beq $t0, $t1, main 		
		lw $t4,($t2)
		
		li $v0, 1
		move $a0, $t4
		syscall	
		
		div $t6,$t3
		mfhi $t5
		
		beq $t5, 0,newLineD
		
	loop4:			
		addi $t0,$t0,1
		addi $t6,$t6,1	
		addi $t2,$t2,4	
		j while3	
		
	newLineD:
		li $v0, 4
		la $a0, newLine
		syscall	
		
		j loop4
			
    	copyMatrix:
    		move $a0,$s2	#allocates dynamic memory
    		li $v0,9
    		syscall
    		
    		move $s4,$v0
    		
    		add $t0,$0,$0
    		move $t1,$s1  	
    		add $t2,$0,$0
    		move $t3,$s3
    		move $t4,$s4
    		move $t5,$t0
    		addi $t8,$0,1
    		move $t7,$s0
    		move $t8,$s3

	
    		li $v0, 4            #Prints the array message
		la $a0, copyMess
		syscall
	
		li $v0, 5           # chooses whether row wise or column wise operation
    		syscall
   		
    		beq $v0,1,loop5
    		beq $v0,2,loop6
    		
    loop5:	beq $t0, $t1, main
    		lw $t2, ($t3)
    		sw $t2, ($t4)
    		
    		addi $t0,$t0,1
    		addi $t3,$t3,4
    		addi $t4,$t4,4
    		j loop5

   loop6:	beq $t0, $t1, main
   
    		lw $t2, ($t3)
    		sw $t2, ($t4)
    		
    		addi $t0,$t0,1		
    		addi $t4,$t4,4
    		
    		mul $t6,$s0,4    		
    		add $t3,$t3, $t6
    		div $t0,$s0
    		mfhi $t5
    		beq $t5, $0,check
    		j loop6
    	check:
    		
    		addi $t3,$t8,4   		
    		add $t8,$t8,4
    		j loop6
	quit: 
		li $v0,10
		syscall
		