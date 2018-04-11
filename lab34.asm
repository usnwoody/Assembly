.data

str1: .asciiz "Program Description\t\tLAB 34"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall"
str3: .asciiz "\nCreation Date:\t\t\t"
str4: .asciiz "/"
num1: .word 03
num2: .word 25
num3: .word 2018
# End of header variables ---------------------------------------------
# Program Variables:
array1: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
line: .asciiz "\n========================================================="
colon: .asciiz ": "
decimal: .asciiz "\nInput a number in decimal form:\t"
bin: .asciiz "\nThe number in binary is:\t"
error: .asciiz "\nThe number cant be negative, please try again"

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
la $t0,num2
lw $a0,0($t0)
li $v0,1
syscall
li $v0,4    
la $a0,str4 
syscall     
la $t0,num3
lw $a0,0($t0)
li $v0,1
syscall
li $v0,4
la $a0,line
syscall
#----------------------------End Header------------------------------------

#	Description of register use:
#	$s0 = Store users input
#	$s1 = 
#	$t0 = 
#	$t1 = 
#	$t2 = 
#	$t3 = 
#	$t4 = 
#	$t5 = 
#	$t6 = 

#------------------------------------------------------------------------
main:
	li $t2,0
	li $v0,4
	la $a0,decimal		# Request number from user
	syscall

input:
	li $v0,5
	syscall
	blt $v0,$0,error1	# Ensure user input is 0 or higher
	add $a1,$v0,$0		# Store user input in $a1
	
# Function call
	jal binary
	

end:
	li $v0,10			# End program
	syscall
	
#------------------------------------------------------------------------

binary:

	add $t1,$a1,$0		# Put value entered by user into $t5 for use in function
	add $t5,$t1,$0
	li $t8,2		# For dividing by 2
	addi $sp,$sp,-4		# Change stack pointer
	sw $ra,0,($sp)		# Store return address

Loop:
	beq $t1,$0,Exit
	div $t1,$t8 		# 
	mflo $t1  		# storing in s0 for division
	mfhi $s4
	addi $sp,$sp,-4
	sw $s4,0($sp)
	addi $t5,$t5,-1
	addi $t2,$t2,1		# Count how many times loop has executed
	j Loop
Exit:
	jal print
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

print:	
	li $v0,4
	la $a0,line			# Print visual break line
	syscall
	la $a0,bin			# Print binary number prefix statment
	syscall
	li $t1,32		# set $t1 to 32 since we are using 32 bits in binary
	sub $t6,$t1,$t2		# Find number of zeros to be used
zeros:
	beq $t6,$0,integers
	li $v0,1
	la $a0,0
	syscall
	addi $t6,$t6,-1
	j zeros
integers:	
	beq $t2,$0,final
	lw $a0,0($sp)
	addi $sp,$sp,4
	li $v0,1
	syscall
	addi $t2,$t2,-1
	j integers
final:
	li $v0,4
	la $a0,line			# Print visual break line
	syscall
	jr $ra	
	

error1:
	li $v0,4
	la $a0,error
	j input
	
