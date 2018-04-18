.data

str1: .asciiz "Program Description\t\tASSIGNMENT 2"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall"
str3: .asciiz "\nCreation Date:\t\t\t"
str4: .asciiz "/"
num1: .word 04
num2: .word 01
num3: .word 2018
# End of header variables ---------------------------------------------
# Program Variables:
array1: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
line: .asciiz "\n========================================================="
colon: .asciiz ": "
err1: .asciiz "\n***ERROR***The array size must be between 1 and 20. Try again!\n"
err2: .asciiz "\n***ERROR***Number must be positive and divisable by 3. Try again!\n"
size: .asciiz "\nPlease enter the size of the array:  "
fill: .asciiz "\nEnter the numbers to fill the array:\n"
space: .asciiz "\n"

.text
#------------------------------------------------------------------------
# Header
li $v0,4    # Load program 4 to print string
la $a0,str1 # Tell processor what string to use
syscall     # complete instructions to this point
la $a0,str2 
syscall     
la $a0,str3 
syscall     
la $t0,num1
lw $a0,0($t0)
li $v0,1
syscall
li $v0,4    
la $a0,str4 
syscall     
la $t1,num2
lw $a0,0($t1)
li $v0,1
syscall
li $v0,4    
la $a0,str4 
syscall     
la $t2,num3
lw $a0,0($t2)
li $v0,1
syscall
li $v0,4
la $a0,line
syscall
#----------------------------End Header------------------------------------

#	Description of register use:
#	$s0 = array pointer
#	$s1 = 20
#	$s2 = 1
#	$s3 = 3
#	$s4 = 4
#	$t0 = counter limit
#	$t1 = 
#	$t2 = 
#	$t3 = 
#	$t4 = 
#	$t5 = 
#	$t6 = 
#	$t7 = 
#	$t8 = 
#	$t9 = divisability checker

#------------------------------------------------------------------------
main:

	li $s1,20
	li $s2,1
	li $s5,3
	li $s4,4
	

Begin:
	jal readNum			# Go to request the number
	jal verifySize		# Go to check size of numnber input
	add $a1,$s3,$0		# Store user input array size to $a1 to pass to function
	la $s0,array1		# Set address of array1
	li $v0,4
	la $a0,fill			# Request user input array elements
	syscall
	jal createArray		# Go to create the array
	jal nextPrint
	jal swap
	jal beforePrint


done:
	li $v0,10
	syscall

#--------------------------------------------------------------

error1:
	li $v0,4
	la $a0,err1					# Print error message
	syscall
	j Begin						# Return to main to allow user to retry
	
error2:
	li $v0,4
	la $a0,err2					# Print error message
	syscall
	j startArray					# Return to clear out $t8  
#--------------------------------------------------------------

readNum:
	li $v0,4
	la $a0,size					# Request user to input number between 1 and 20
	syscall
	li $v0,5					# Accept user input
	syscall				
	jr $ra						# Return to main
#--------------------------------------------------------------

verifySize:	
	bgt $v0,$s1,error1			# If input is greater than 20, error
	blt $v0,$s2,error1			# If input is less than 1, error
	add $s3,$v0,$0				# Store acceptable input to $s0
	jr $ra					# Input passed check, return to main
	
#--------------------------------------------------------------

createArray:
	add $t0,$a1,$0				# Initialize counter to uper input array size amount
startArray:
	beq $t0,$0,arrayEnd			# When counter reaches 0, go to next section
	li $v0,5				# Accept user input
	syscall
	add $t9,$v0,$0				# Store input to be divided
	div $t9,$s5				# Divide to check for divisibility
	mfhi $t8				# Store remainder to check for 0
	bne $t8,$0,error2			# If remainder was not 0, go to error
	sw $v0,0($s0)				# Store input to array
	addi $s0,$s0,4				# Add 4 to move to next array item to be input
	addi $t0,$t0,-1				# Decrement counter
	j startArray				# Return to beginning 
	
arrayEnd:	
	la $s0,array1
	jr $ra					# Array created, return to main
#--------------------------------------------------------------	

swap:
	add $t6,$s3,$0				# Store original user input to $t6
	mult $t6,$s4				# Multiply by 4
	mflo $t8				# store product in $t8
				
	la $s0,array1
	la $s5,array1
	addi $t8,$t8,-4
	add $s5,$s5,$t8				# Subtract the result from $s0 address pointer
	

	li $t8,0				# Zero out $t8
swapStart:	
	bge $s0,$s5,swapEnd	
	lw $t7,0($s0)				# Load the element from the end of the array
	lw $t9,0($s5)				# Load the element from the beginning of the array
	sw $t7,0($s5)				# Store element in beginning of array
	sw $t9,0($s0)				# Store element in end of array
	addi $s0,$s0,4				# Increment to move to next element from beginning of array
	addi $s5,$s5,-4				# Decrement to move to previous element from end of array
	addi $t8,$t8,4				# Number to subtract to return to beginning of array after swap
	j swapStart
swapEnd:
	jr $ra

#--------------------------------------------------------------

beforePrint:
	sub $s0,$s0,$t8 			# Go back to the start of array1 
nextPrint:	
	add $t6,$s3,$0				# Set counter limit to original user input
print:
	beq $t6,$0,printEnd			# When counter is 0, go to next section
	li $v0,4
	la $a0,space
	syscall
	li $v0,1				# Load integer
	lw $a0,0($s0)				# Load $a0 with the element in array
	syscall
	addi $t6,$t6,-1				# Decrement the counter
	addi $s0,$s0,4				# Move to next element in array
	j print
printEnd:
	jr $ra					
