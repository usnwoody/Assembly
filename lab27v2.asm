.data

str1: .asciiz "Program Description\t\tLAB 27\n\n"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall\n\n"
str3: .asciiz "\nCreation Date:\t\t\t"
str5: .asciiz "/"
str6: .asciiz "\nPlease input the two numbers:\n"
str7: .asciiz "\nSum is:\t"
str8: .asciiz "\nDifference is:\t" 
str9: .asciiz "\nProduct is:\t"
str10: .asciiz "\nQuotient is:\t"
str11: .asciiz "\nRemainder is:\t"
num1: .word 03
num2: .word 06
num3: .word 2018


.text
main:

li $v0,4	# Load program 4 to print string
la $a0,str1	# Tell process what string to use
syscall		# complete instructions to this point

li $v0,4	# Load program 4 to print string
la $a0,str2	# Tell process what string to use
syscall		# complete instructions to this point

li $v0,4	# Load program 4 to print string
la $a0,str3	# Tell process what string to use
syscall		# complete instructions to this point

# Date Section of Header:
la $s0,num1
lw $a0,0($s0)
li $v0,1
syscall

la $s0,num2
lw $a0,0($s0)
li $v0,1
syscall
la $s0,num3
lw $a0,0($s0)
li $v0,1
syscall
# End of Date Section of Header

# Ask user for input
li $v0,4	# Load program 4 to print string
la $a0,str6	# Tell process what string to use
syscall		# complete instructions to this point

li $v0,5
syscall
add $s0,$v0,$0

li $v0,5
syscall
add $s1,$v0,$0
# End user input

# Addition Section
add $s3,$s0,$s1
li $v0,4	# Load program 4 to print string
la $a0,str7	# Tell process what string to use
syscall		# complete instructions to this point
add $a0,$s3,$0
li $v0,1
syscall
# End of Addition Section

# Subtraction Section
sub $s3,$s0,$s1	# Subtraction Section
li $v0,4	# Load program 4 to print string
la $a0,str8	# Tell process what string to use
syscall		# complete instructions to this point
add $a0,$s3,$0
li $v0,1
syscall
# End of Subtraction Section

# Multiplication Section
mult $s0,$s1
li $v0,4	# Load program 4 to print string
la $a0,str9	# Tell process what string to use
syscall		# complete instructions to this point
mflo $a0
li $v0,1
syscall
# End of Multiplication Section

# Division Section
div $s0,$s1
li $v0,4	# Load program 4 to print string
la $a0,str10	# Tell process what string to use
syscall		# complete instructions to this point
mflo $a0
li $v0,1
syscall
li $v0,4	# Load program 4 to print string
la $a0,str11	# Tell process what string to use
syscall		# complete instructions to this point
mfhi $a0
li $v0,1
syscall
# End of Division Section
