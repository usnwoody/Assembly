.data

str1: .asciiz "Program Description\t\tLAB 36"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall"
str3: .asciiz "\nCreation Date:\t\t\t"
str4: .asciiz "/"
num1: .word 04
num2: .word 05
num3: .word 2018
# End of header variables ---------------------------------------------
# Program Variables:
line: .asciiz "\n========================================================="
colon: .asciiz ": "
input: .byte ' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
space: .asciiz "\n"
enc: .byte ' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
space1: .asciiz "\n"
dec: .byte ' ',' ',' ',' ',' ',' ',' ',' ',' ',' '
space2: .asciiz "\n"
inReq: .asciiz "\nInput a string of 9 characters:\n"
decrypted: .asciiz "\nThe decrypted message is:\t"
encrypted: .asciiz "\nThe encrypted message is:\t"

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
#	$s0 = 
#	$s1 =
#	$s2 = 
#	$s3 = 
#	$s4 = 
#	$t0 = 
#	$t1 = 
#	$t2 = 
#	$t3 = 
#	$t4 = 
#	$t5 = 
#	$t6 = 
#	$t7 = 
#	$t8 = 
#	$t9 = 

#------------------------------------------------------------------------
main:
	li $s0,10		# Key value
	
	li $v0,4
	la $a0,inReq		# input request
	syscall
	
	li $v0,8		# Get user input of char
	la $a0,input		# Store input in "input" array
	li $a1,10		# Recieve 9 char and use last char for end of string
	syscall
	
	la $s2,input		# set $s2 to input 
	la $s3,enc
	la $s4,dec
	li $t3,10
Loop1:	
	beq $t3,$0,en
	lb $t1,0($s2)		# load byte from input array
	xor $t2,$t1,$s0		
	sb $t2,0($s3)
	addi $s2,$s2,1
	addi $s3,$s3,1
	addi $t3,$t3,-1
	li $t1,0
	li $t2,0
	j Loop1
		
en: 
	la $s3,enc
	li $v0,4
	la $a0,encrypted
	syscall	
printEncr:	
	li $v0,4		# Print string
	la $a0,enc		# From enc array
	syscall
	
	li $t3,10
Loop2:	
	beq $t3,$0,de
	lb $t1,0($s3)		# load byte from input array
	xor $t2,$t1,$s0		
	sb $t2,0($s4)
	addi $s3,$s3,1
	addi $s4,$s4,1
	addi $t3,$t3,-1
	li $t1,0
	li $t2,0
	j Loop2

	
de: 
	li $v0,4
	la $a0,decrypted
	syscall	
printDecr:	
	li $v0,4		# Print string
	la $a0,dec		# From dec array
	syscall
	
done:
	li $v0,10
	syscall

#--------------------------------------------------------------

