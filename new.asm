.data

str1: .asciiz "Program Description\t\tLAB **"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall"
str3: .asciiz "\nCreation Date:\t\t\t"
str4: .asciiz "/"
num1: .word 03
num2: .word **
num3: .word 2018
# End of header variables ---------------------------------------------
# Program Variables:



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




done:
li $v0,10
syscall

#--------------------------------------------------------------
# Error Section
