.data

str1: .asciiz "Program Description\t\tOutput\n\n"
str2: .asciiz "Author:\t\t\t\tMike Woodall\n\n"
str3: .asciiz "Creation Date:\t\t\t03/06/2018\n\n"
str4: .asciiz "Here is the report of top 3 employees in Texas Instruments Company:\n"
str5: .asciiz "==================================================================\n"
str6: .asciiz "Last Name\tFirst Name\tPosition\tSalary\n"
str7: .asciiz "~~~~~~~~\t~~~~~~~~\t~~~~~~~\t\t~~~~~~\n"
str8: .asciiz "Smith\t\tAdam\t\tDirector\t"
str9: .asciiz "Hadden\t\tMary\t\tDirector\t"
str10: .asciiz "Simpson\t\tMike\t\tManager\t\t"
str11: .asciiz " \n"
num1: .word 99010
num2: .word 95220
num3: .word 80000


.text
main:

li $v0,4	# Load program 4 to print string

la $a0,str1	# Tell process what string to use
syscall		# complete instructions to this point

la $a0,str2	# Tell process what string to use
syscall

la $a0,str3	# Tell process what string to use
syscall

la $a0,str4
syscall

la $a0,str5
syscall

la $a0,str6
syscall

la $a0,str7
syscall

la $a0,str8
syscall

li $v0,1

la $s0,num1
lw $a0,0($s0)
li $v0,1
syscall

li $v0,4

la $a0,str11
syscall
la $a0,str9
syscall

li $v0,1

la $s0,num2
lw $a0,0($s0)
li $v0,1
syscall

li $v0,4

la $a0,str11
syscall
la $a0,str10
syscall

li $v0,1

la $s0,num3
lw $a0,0($s0)
li $v0,1
syscall

li $v0,4
la $a0,str11
syscall
la $a0,str5
syscall

li $v0,10
syscall