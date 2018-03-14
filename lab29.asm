.data

str1: .asciiz "Program Description\t\tLAB 29"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall"
str3: .asciiz "\nCreation Date:\t\t\t"
str4: .asciiz "/"
num1: .word 03
num2: .word 13
num3: .word 2018
# End of header variables ---------------------------------------------

str5: .asciiz "\n\nHow many positive number that is divisable by 6 you want to add?\n"
str6: .asciiz "\nThe Sum of the positive numbers between 1 and 100 that are devisable by 6, is: "
str7: .asciiz "\nEnter a number: \n"
str8: .asciiz "\n==>*****ERROR: "
str9: .asciiz "is not a positive number. Enter another number."
str10: .asciiz "is not in range of 1 to 100. Enter another number."
str11: .asciiz " is not divisible by 6. Enter another number." 
str12: .asciiz " is divisible by 6."


#------------------------------------------------------------------------
.text
main:
# Header
li $v0,4    # Load program 4 to print string
la $a0,str1 # Tell processor what string to use
syscall     # complete instructions to this point

li $v0,4    # Load program 4 to print string
la $a0,str2 # Tell processor what string to use
syscall     # complete instructions to this point

li $v0,4    # Load program 4 to print string
la $a0,str3 # Tell processor what string to use
syscall     # complete instructions to this point

# Date Section of Header:
la $s0,num1
lw $a0,0($s0)
li $v0,1
syscall
li $v0,4    # Load program 4 to print string
la $a0,str4 # Tell processor what string to use
syscall     # complete instructions to this point
la $s0,num2
lw $a0,0($s0)
li $v0,1
syscall
li $v0,4    # Load program 4 to print string
la $a0,str4 # Tell processor what string to use
syscall     # complete instructions to this point
la $s0,num3
lw $a0,0($s0)
li $v0,1
syscall
# End of Date Section of Header
# End Header---------------------------------------------------------------


# Ask user for input
li $v0,4   		# Load program 4 to print string
la $a0,str5 	# Tell processor what string to use
syscall     
li $v0,5    	# Get user input
syscall

add $s0,$v0,$0  # End user input
add $t1,$s0,$0	# Store $s0 in $t1
add $t0,$t0,1	# Initialize $t0 to 1
add $t2,$t2,6	# Initialize $t2 to 6
	
loop1:   
		
	# Ask user for numbers to add
	li $v0,4   		# Load program 4 to print string
	la $a0,str7 	# Tell processor what string to use
	syscall     
	li $v0,5    	# Get user input
	syscall
	
	add $s1,$v0,$0		# Put user input into $s1
	blt $s1,1,ErrorPos	# If number isn't in positive, go to positivity error
	bgt $s1,100,ErrorRange	# If number isn't in range, go to range error
	div $s1,$t2
	mfhi $t3
	bne $t3,0,ErrorDiv	# If remainder is not 0, go to divisability error
	beq $t3,0,branch1
	branch1:
		beq $t0,$t1,done
		li $v0,1
		add $a0,$s1,$0
		syscall
		li $v0,4
		la $a0,str12
		syscall
		add $s2,$s1,$s2
		addi $t0,$t0,1
		j loop1

done:

li $v0,4
la $a0,str6
syscall
li $v0,1
add $a0,$s2,$0
syscall


li $v0,10
syscall

#--------------------------------------------------------------
# Error Section

ErrorPos:
		li $v0,4   		# Load program 4 to print string
		la $a0,str8 	# Tell processor what string to use
		syscall
		li $v0,1     
		add $a0,$s1,$0
		la $a0,str9
		j loop1
		
ErrorRange:
		li $v0,4   		# Load program 4 to print string
		la $a0,str8 	# Tell processor what string to use
		syscall
		li $v0,1
		add $a0,$s1,$0
		syscall		
		la $a0,str10
		syscall
		j loop1
		
ErrorDiv:
		li $v0,1
		add $a0,$s1,$0
		syscall		
		li $v0,4   		# Load program 4 to print string
		la $a0,str11
		syscall
		j loop1