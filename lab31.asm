.data

str1: .asciiz "Program Description\t\tLAB 31"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall"
str3: .asciiz "\nCreation Date:\t\t\t"
str4: .asciiz "/"
num1: .word 03
num2: .word 15
num3: .word 2018
# End of header variables ---------------------------------------------
# ***Program Variables: ***
line: .asciiz "\n======================================================\n"
array: .word 0,0,0,0,0,0,0,0,0,0
ent: .asciiz "\nEnter the number of elements: \n"
n: .asciiz "Enter number: "
rev: .asciiz "The content of the array in reverse order is:\n"
err1: .asciiz "***Error, array can't have more than 10 elements. Try again: "
err2: .asciiz "***Error, array can't have less than 2 elements. Try again: "
new: .asciiz "\n"

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
#----------------------- End Header ------------------------------

li $v0,4
la $a0,ent	# Ask user for number of elements
syscall

add $t3,$t3,1
add $t4,$t4,10

input:
    
    li $v0,5    	# Get user input
    syscall
    add $s0,$v0,$0  # End user input
    blt $s0,$t3,error2    # Ensure num of elements is greater than x
    bgt $s0,$t4,error1   # Ensure num of elements is less than y
    

    add $t2,$s0,$0	# Maintain the original user input number of elements
    add $t0,$t0,$t2  # Load counter limit with user input
    la $s0,array    # Set address of array to $s0
    li $v0,4
    la $a0,line
    syscall
    
loop1:
    beq $t0,$0,next
    li $v0,4
    la $a0,n
    syscall
    li $v0,5
    syscall
    sw $v0,0($s0)
    addi $s0,$s0,4
    addi $t0,$t0,-1
    j loop1
    
next:
    li $v0,4
    la $a0,line
    syscall
    la $a0,n    # Print message that array is being printed in reverse order
    addi $s0,$s0,-4    # Move out of garbage area of memory
    li $v0,4
    la $a0,rev
    syscall
    
loop2:
    beq $t2,$0,done
    lw $a0,0($s0)
    li $v0,1
    syscall
    addi $s0,$s0,-4
    addi $t2,$t2,-1
    li $v0,4
    la $a0,new
    syscall
    j loop2
   
    
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
