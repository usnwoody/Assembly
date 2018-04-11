.data

str1: .asciiz "Program Description\t\tLAB 37 More on Array"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall"
str3: .asciiz "\nCreation Date:\t\t\t"
str4: .asciiz "/"
num1: .word 04
num2: .word 10
num3: .word 2018
# End of header variables ---------------------------------------------
# Program Variables:
line: .asciiz "\n========================================================="
array1: .word 0,0,0,0,0,0,0,0,0,0
in: .asciiz "\nInput a number between 3 and 10:\t"
error1: .asciiz "\nNumber out of range. Try again!"
load: .asciiz "\nEnter the numbers:\n"
max: .asciiz "\nThe max number is:\t"
return: .asciiz "\n"
.text
#------------------------------------------------------------------------
# Header
li $v0,4    	# Load program 4 to print string
la $a0,str1 	# Tell processor what string to use
syscall     	# Complete instructions to this point
la $a0,str2 	# Tell processor what string to use
syscall     	# Complete instructions to this point
la $a0,str3 	# Tell processor what string to use
syscall     	# Complete instructions to this point
la $t0,num1		# Load num1 into $t0
lw $a0,0($t0)	# Which element to print
li $v0,1		# Print integer
syscall			# Complete instructions to this point
li $v0,4    	# Load program 4 to print string
la $a0,str4 	# Tell processor what string to use
syscall     	# Complete instructions to this point
la $t1,num2		# Load num2 into $t1
lw $a0,0($t1)	# Which element to print
li $v0,1		# Print integer
syscall			# Complete instructions to this point
li $v0,4    	# Load program 4 to print string
la $a0,str4 	# Tell processor what string to use
syscall     	# Complete instructions to this point
la $t2,num3		# Load num3 into $t2
lw $a0,0($t2)	# Which element to print
li $v0,1		# Print integer
syscall			# Complete instructions to this point
li $v0,4		# Load program 4 to print string
la $a0,line		# Tell processor what string to use
syscall			# Complete instructions to this point
#----------------------------End Header------------------------------------

main:
	la $s0,array1
	li $v0,4    
	la $a0,in              	 # Request user input
	syscall
errFix:
	li $v0,5
	syscall
	li $t9,11
	li $t8,2
	bge $v0,$t9,error      	 # Error if greater than or equal to 11
	ble $v0,$t8,error    	 # Error if less than or equal to 2
	add $s3,$v0,$0
	add $a1,$s3,$0
	li $v0,4
	la $a0,load          	 # Request user input array elements
	syscall
	jal fillArray
	
    	la $s0,array1		# Pass array address
    	add $a1,$s3,$0		# Pass array size
	jal printArray
	
	la $s0,array1		# Pass array address
	add $a1,$s3,$0		# Pass array size
	li $t2,0		# Ensure $t2 is zeroed
	jal findMax
	add $s4,$v1,$0		# move max number to be printed
	
	li $v0,4
	la $a0,max		# print max statement
	syscall
	li $v0,1		# print max
	add $a0,$s4,$0		# place number to be printed (max) 
	syscall
	li $v0,4		
	la $a0,line		# Print line
	syscall
	
done:
	li $v0,10		# End of program
	syscall		        # Execute

#--------------------------------------------------------------
error:
    li $v0,4
    la $a0,error1		# Print error message
    syscall
    j errFix

fillArray:
	add $t0,$a1,$0
startFill:
	beq $t0,$0,doneFill		
	li $v0,5			# Accept user input
	syscall	
	sw $v0,0($s0)		# Store array element
	addi $t0,$t0,-1		# Increment counter
	addi $s0,$s0,4		# Move to next array element
	j startFill
doneFill:
	jr $ra
    
printArray:
	add $t0,$a1,$0
beginPrint:
	beq $t0,$0,donePrint
	li $v0,4
	la $a0,return
	syscall		
	lw $a0,0($s0)		# load array element
	li $v0,1		# print integer
	syscall	
	addi $t0,$t0,-1		# Increment counter
	addi $s0,$s0,4		# Move to next array element
	j beginPrint
donePrint:
	li $v0,4
	la $a0,line
	syscall
	jr $ra
	
findMax:
	add $t0,$a1,$0
beginMax:
	beq $t0,$0,doneMax		
	lw $t1,0($s0)		# load array element

	bgt $t1,$t2,greater
	blt $t1,$t2,less
less:	
	addi $s0,$s0,4
	addi $t0,$t0,-1
	j beginMax
	
greater:
	add $t2,$t1,$0		# store largest number in t2
	addi $s0,$s0,4
	addi $t0,$t0,-1
	j beginMax
	
doneMax:
	add $v1,$t2,$0
	jr $ra