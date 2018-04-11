.data

str1: .asciiz "Program Description\t\tLAB 32"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall"
str3: .asciiz "\nCreation Date:\t\t\t"
str4: .asciiz "/"
num1: .word 03
num2: .word 20
num3: .word 2018
# End of header variables ---------------------------------------------
# Program Variables:
array: .word 0,0,0,0,0,0,0,0,0,0
str5: .asciiz "\nHow many numbers would you like to enter: "
str6: .asciiz "\nEnter number "
median: .asciiz "\nThe median is: "
err1: .asciiz "***Error, array can't have more than 10 elements. Try again: "
err2: .asciiz "***Error, array can't have less than 2 elements. Try again: "
line: .asciiz "\n========================================================="
colon: .asciiz ": "
.text
main:
#------------------------------------------------------------------------
# Header
li $v0,4    # Load program 4 to print string
la $a0,str1 # Tell processor what string to use
syscall     # complete instructions to this point
li $v0,4    
la $a0,str2 
syscall     
li $v0,4    
la $a0,str3 
syscall     
la $s7,num1
lw $a0,0($s7)
li $v0,1
syscall
li $v0,4    
la $a0,str4 
syscall     
la $s7,num2
lw $a0,0($s7)
li $v0,1
syscall
li $v0,4    
la $a0,str4 
syscall     
la $s7,num3
lw $a0,0($s7)
li $v0,1
syscall
#----------------------------End Header------------------------------------

#	Description of register use:
#	$s0 = user entered number
#	$s1 = number to increment for printout of "Enter number" section
#	$s2 =
#	$s3 =
#	$t0 = original user input (array size)
#	$t1 = 2
#	$t2 = 
#	$t3 = max value for number of array elements (11)
#	$t4 = min value for number of array elements (1)
#	$t5 = remainder
#	$t6 = 4
#	$t7 =
#	$t8 =
#	$t9 =

#------------------------------------------------------------------------

li $t1,2			# Set $t1 to 2
li $t3,11			# Set $t3 to 11
li $t4,1			# Set $t4 to 1
li $t6,4			# Set $t6 to 4


input:
	li $v0,4
	la $a0,str5		# Prints request for number of elements for the array
	syscall
	li $v0,5		# Accept user input
	syscall
	add $s0,$v0,$0		# Store user input in $s0
	blt $s0,$t4,error2	# Ensure num of elements is greater than $t3
	bgt $s0,$t3,error1	# Ensure num of elements is less than $t4
    
	li $s1,1		# Initial value for numbers to be displayed to user
	add $t0,$t0,$s0		# Store user input to be used as upper limit of counter
 	add $t8,$t8,$s0		# Store orginal user input to $t8
	la $s0,array		# Set address of array to $s0
    

    
    
entryLoop:
	beq $t0,$0,check	# when finished, go to check
	li $v0,4		
	la $a0,str6		# Tell user to enter number
	syscall
	li $v0,1
	add $a0,$s1,$0		# Print number in series to be input by user
	syscall
	li $v0,4		
	la $a0,colon		# insert ":"
	syscall
	li $v0,5		# Accept user input for array elements
	syscall
	sw $v0,0,($s0)		# Store user input in array
	addi $s0,$s0,4		# Move to next array address
	addi $s1,$s1,1		# Increment number to be printed for input
	addi $t0,$t0,-1		# Increment counter
	j entryLoop

    
check:
	la $s0,array
	div $t8,$t1 		# Divide by 2
	mflo $t7
	mfhi $t9		# Set remainder to $t9
	bne $t9,$0,odd		# If remainder is not 0, go to odd
	j even			# Otherwise, jump to even
    
odd:    
   	mult $t7,$t6		# Multiply by 4
    	mflo $t8		# Store product in $t8
   	add $s4,$t8,$s0    	# Add product of to move that many spaces in array
	
	li $v0,4
	la $a0,line		# Print lines 
	syscall
	la $a0,median		# Print median statement
	syscall
	lw $a0,0,($s4)		# Print median number
	li $v0,1
	syscall
	j done
    	
even:
	lw $t9,0,($s0)		# Get first number for median
	addi $s0,$s0,-4		# Move back to previous number in array
	lw $t8,0,($s0)		# Load next number into $t8
	add $s3,$t8,$t9		# add numbers to average them
	div $s3,$t1		# divide sum by 2 
	mflo $s3		
	
	
	li $v0,4
	la $a0,line
	syscall
	la $a0,median
	syscall
	add $s0,$s0,$s2
	li $v0,1
	la $a0,0($s3)
	syscall


done:
li $v0,10
syscall

#--------------------------------------------------------------
# Error Section

error1: 
    li $v0,4
    la $a0,err1
    syscall
    j input
    
error2: 
    li $v0,4
    la $a0,err2
    syscall
    j input
