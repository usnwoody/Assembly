.data

str1: .asciiz "Program Description\t\tLAB 29"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall"
str3: .asciiz "\nCreation Date:\t\t\t"
str4: .asciiz "/"
num1: .word 03
num2: .word 13
num3: .word 2018
# End of header variables ---------------------------------------------

str5: .asciiz "\n\nEnter an integer between 0-10:\n"
str6: .asciiz " is not within the range. Enter another number."
str7: .asciiz "!=1"
str8: .asciiz "==>*****ERROR: "
str9: .asciiz "!="



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
# End Header---------------------------------------------------------------



loop1:
	# Ask user for input
	li $v0,4   		# Load program 4 to print string
	la $a0,str5 	# Tell processor what string to use
	syscall     
	li $v0,5    	# Get user input
	syscall
	add $s0,$v0,$0  # End user input

	blt $s0,0,ErrorRange
	bgt $s0,10,ErrorRange
	beq $s0,0,zero
	add $t2,$s0,$0	# Maintain the original number
	add $t1,$t1,1	# Initialize $t1 to 1
loop2:		
	beq $t1,$t2,finish
	mult $s0,$t1
	mflo $s0
	add $t1,$t1,1
	j loop2

	



finish:
	li $v0,1
	add $a0,$t2,$0
	syscall
	li $v0,4
	la $a0,str9
	syscall
	li $v0,1
	add $a0,$s0,$0
	syscall
	j done
	
zero:
	li $v0,1
	add $a0,$s0,$0
	syscall
	li $v0,4
	la $a0,str7
	syscall
	j done

done:
li $v0,10
syscall

#--------------------------------------------------------------
# Error Section

ErrorRange:
		li $v0,4   		# Load program 4 to print string
		la $a0,str8 	# Tell processor what string to use
		syscall
		li $v0,1     
		add $a0,$s1,$0
		la $a0,str6
		j loop1
		
