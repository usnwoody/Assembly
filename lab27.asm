.data

str1: .asciiz "Program Description\t\tLAB 27\n\n"
str2: .asciiz "Author:\t\t\t\tMike Woodall\n\n"
str3: .asciiz "Creation Date:\t\t\t"
str4: .asciiz "\n"
str5: .asciiz "/"
str6: .asciiz "Please input the two numbers:"
str7: .asciiz "Sum is:\t"
str8: .asciiz "Difference is:\t" 
str9: .asciiz "Product is:\t"
str10: .asciiz "Quotient is:\t"
str11: .asciiz "Remainder is:\t"
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
li $v0,4	# Load program 4 to print string
la $a0,str5	# Tell process what string to use
syscall		# complete instructions to this point
la $s0,num2
lw $a0,0($s0)
li $v0,1
syscall
li $v0,4	# Load program 4 to print string
la $a0,str5	# Tell process what string to use
syscall		# complete instructions to this point
la $s0,num3
lw $a0,0($s0)
li $v0,1
syscall
li $v0,4	# Load program 4 to print string
la $a0,str4	# Tell process what string to use
syscall		# complete instructions to this point
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
la $a0,($s3)
li $v0,1
syscall
# End of Addition Section

# New line
li $v0,4	# Load program 4 to print string
la $a0,str4	# Tell process what string to use
syscall		# complete instructions to this point

# Subtraction Section
sub $s3,$s0,$s1	# Subtraction Section
li $v0,4	# Load program 4 to print string
la $a0,str8	# Tell process what string to use
syscall		# complete instructions to this point
la $a0,($s3)
li $v0,1
syscall
# End of Subtraction Section

# New line
li $v0,4	# Load program 4 to print string
la $a0,str4	# Tell process what string to use
syscall		# complete instructions to this point

# Multiplication Section
mult $s0,$s1
mfhi $t0
mflo $t1
li $v0,4	# Load program 4 to print string
la $a0,str9	# Tell process what string to use
syscall		# complete instructions to this point
la $a0,$t1
li $v0,1
syscall
# End of Multiplication Section

# New line
li $v0,4	# Load program 4 to print string
la $a0,str4	# Tell process what string to use
syscall		# complete instructions to this point

# Division Section
div $s0,$s1
mfhi $t0
mflo $t1
li $v0,4	# Load program 4 to print string
la $a0,str10	# Tell process what string to use
syscall		# complete instructions to this point
la $a0,($t1)
li $v0,1
syscall
# New line
li $v0,4	# Load program 4 to print string
la $a0,str4	# Tell process what string to use
syscall		# complete instructions to this point
li $v0,4	# Load program 4 to print string
la $a0,str11	# Tell process what string to use
syscall		# complete instructions to this point
la $a0,($t0)
li $v0,1
syscall
# End of Division Section
# New line
li $v0,4	# Load program 4 to print string
la $a0,str4	# Tell process what string to use
syscall		# complete instructions to this point