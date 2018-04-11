.data

str1: .asciiz "Program Description\t\tLAB 36 Celcius to Fahrenheit"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall"
str3: .asciiz "\nCreation Date:\t\t\t"
str4: .asciiz "/"
num1: .word 04
num2: .word 08
num3: .word 2018
# End of header variables ---------------------------------------------
# Program Variables:
line: .asciiz "\n========================================================="
cel: .asciiz "\nPlease input a temperature in Celsius:\n=>"
fah: .asciiz "\nThe temperature in Fahrenheit is: \n=>" 
num4: .float 32
num5: .float 1.8
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
	li $v0,4				# Print string
	la $a0,cel				# Print request for celcius number
	syscall					# Execute 
	li $v0,6				# Accept user input (float)
	syscall
	mov.s $f9,$f0 					# Execute
	l.s $f1,num4				# Load 32 into $f1
	l.s $f2,num5				# Load 1.8 into $f2
	
	mul.s $f9,$f9,$f2			# Multiply values to get result in Fahrenheit			
	add.s $f9,$f9,$f1
	li $v0,2				# Print single float
	mov.s $f12,$f9				# Move value to $f12 for printing
	syscall					# Execute
	
done:
	li $v0,10		# End of program
	syscall			# Execute

#--------------------------------------------------------------


	
	
