.data

str1: .asciiz "Program Description\t\tLAB 33"
str2: .asciiz "\nAuthor:\t\t\t\tMike Woodall"
str3: .asciiz "\nCreation Date:\t\t\t"
str4: .asciiz "/"
num1: .word 03
num2: .word 25
num3: .word 2018
# End of header variables ---------------------------------------------
# Program Variables:
prices: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
coupons: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
line: .asciiz "\n========================================================="
colon: .asciiz ": "
items: .asciiz "\nHow many items are you purchasing: "
each: .asciiz "\nPlease enter the price of item #"
enterCoupon: .asciiz "\nPlease enter the amount off for coupon #"
thanks: .asciiz "\nThank you for shopping with us!"
charge: .asciiz "\nYour total charge is: "
err1: .asciiz "\n***You can't buy less than 1 item. Try again: "
err2: .asciiz "\n***You can't buy more than 20 items. Try again: "
err3: .asciiz "\nSorry this coupon is not acceptable"

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
#	$t0 = 
#	$t1 = 
#	$t2 = 
#	$t3 = 
#	$t4 = 
#	$t5 = 
#	$t6 = 

#------------------------------------------------------------------------
main:

begin:
	li $v0,4		
	la $a0,items		# Tell user to enter number
	syscall
	li $v0,5		# Get number from user
	syscall
	la $s6,prices
	la $s7,coupons
	
check1:	
	li $t0,1
	li $t1,20
	blt $v0,$t0,error1
	bgt $v0,$t1,error2 
	add $s4,$v0,$0		# Store user input that passed the check	
	add $t0,$s4,$0
	li $s1,1		# Set $s1 to 1 to print item # to be entered
	add $a1,$0,$s4		# Give the number of items to be priced to function
	jal FillPriceArray	# Go to enter item prices function

	li $s1,1		# Set $s1 to 1 to print item # to be entered
	li $t5,4
	mult $s4,$t5
	mflo $t5
	sub $s6,$s6,$t5
	la $s6,prices

			
	add $a1,$0,$s4		# Give the number of items to be discounted to function
	jal FillCouponArray
	

total:
	li $v0,4
	la $a0,charge		# print total charge statement
	syscall
	add $a0,$t7,$0		# Print total
	li $v0,1
	syscall
	


end:
	li $v0,10
	syscall
	
#------------------------------------------------------------------------	
# Error Section

error1: 
    li $v0,4
    la $a0,err1
    syscall
    j begin
    
error2: 
    li $v0,4
    la $a0,err2
    syscall
    j begin
    
# End Error Section	          
			
FillPriceArray:	
	add $t0,$a1,$0		
number1:
	beq $t0,0,next1		# When finished with loop, go to $ra
	li $v0,4
	la $a0,each		# Print price request
	syscall
	add $a0,$s1,$0		# Print number in series to be input by user
	li $v0,1
	syscall
	li $v0,4
	la $a0,colon		# Print ":"
	syscall
	li $v0,5
	syscall
	sw $v0,0,($s6)		# Store user input in array
	addi $s6,$s6,4		# Move to next array element
	addi $s1,$s1,1		# Increment number in series for user to input 
	addi $t0,$t0,-1		# Decrement counter
	j number1
next1:
	jr $ra 			# Return to main
	

FillCouponArray:
	add $t0,$a1,$0		
number2:
	beq $t0,$0,next2		# When finished with loop, go to $ra
	lw $t5,0($s6)		# Store original price for comparison
	li $v0,4
	la $a0,enterCoupon	# Print coupon amount request
	syscall
	add $a0,$s1,$0		# Print number in series to be input by user
	li $v0,1
	syscall
	li $v0,4
	la $a0,colon		# Print ":"
	syscall
discountCheck:
	li $v0,5		# User input of coupon amount
	syscall
	blt $v0,$t5,less	# Compare user input and orginal price to ensure it is lower
	add $v0,$0,$0		# Place 0 in $v0 to be stored in coupon array
less:	
	add $t9,$v0,$0		# Store $s in array
	sw $v0,0($s7)
	lw $t1,0($s6)
	lw $t2,0($s7)
	sub $t6,$t1,$t2		# Subtract coupon amount from original price
	add $t7,$t7,$t6		# Accumulated sums
	addi $s7,$s7,4
	addi $s6,$s6,4
	addi $s1,$s1,1		# Increment number in series for user to input 
	addi $t0,$t0,-1		# Decrement counter
	j number2
next2:
	jr $ra			# Return to main
	
