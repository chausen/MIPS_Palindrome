# First SPIM Assignment
	# Program 1
	# Name:  Clay Hausen
	# Class: CDA3101
	# Date:  1/30/15
# Start with data declarations
#
	.data
str1: .asciiz "Programming assignment 1 for CDA3101\n"
str2: .asciiz "This palindrome checker only deals with positive integer number.\n"
str3: .asciiz "\nEnter a number to check if it is a palindrome or not:\n"
str4: .asciiz " is a palindrome number.\n"
str5: .asciiz " is not a palindrome number.\n"
str6: .asciiz "\nEnter 1 to continue, or 0 to exit.\n"
newline: .asciiz "\n"
# num = $t0
# reverse = $t1
# temp = $t2

.align 2

.globl main
.text

main:

    la $a0, str1          # load str1 address into $a0
    li $v0, 4             # load I/O code for string output into $v0
    syscall               # execute syscall to output str1

    la $a0, str2          # load str2 address into $a0
    syscall               # execute syscall to output str2

BEGIN:
    addi $t0, $0, 0       # initialize sum to 0
    addi $t1, $0, 0       # initialize reverse to 0
    addi $t2, $0, 0       # initialize temp to 0.
    addi $t4, $0, 10      # $t4 = 10

    li $v0, 4             # load I/O code for string output into $v0
    la $a0, str3          # load str3 address into $a0
    syscall               # execute syscall to output str3

    li $v0, 5             # load I/O code for inputting integer into $v0
    syscall               # input integer into $v0
    move $t0, $v0         # move input integer into $t0; num = $t0
    move $t2, $t0         # temp = num


LOOP:
    beq $t2, $0, END      # break if temp == 0
    mult $t1, $t4         # store reverse*10 in LO
    mflo $t1              # move reverse*10 from LO to reverse
    div $t2, $t4          # temp%10 stored in HI, temp/10 in LO
    mfhi $t2              # temp = temp%10
    add $t1, $t1, $t2     # reverse = reverse + temp%10
    mflo $t2              # temp = temp/10
    j LOOP                # reiterate

END:   
    add $a0, $t0, $0      # set $a0 equal to num
    li $v0, 1             # load I/O code for integer output into $v0
    syscall               # output num
    li $v0, 4             # load I/O code for string output into $v0

    bne $t0, $t1, IF      # if num != reverse, go to IF
    la $a0, str4          # load str4 address into $a0
    syscall               # execute syscall to output str4
    j ELSE                # if num == reverse, skip IF and go to ELSE

IF:
    la $a0, str5          # load str5 address into $a0
    syscall               # execute syscall to output str5

ELSE:
    la $a0, str6          # load str6 address into $a0
    syscall               # prompt whether or not to restart program
    li $v0, 5             # load I/O code for inputting integer into $v0
    syscall               # receive input

    bne $v0, $0, BEGIN    # jump to main if 0 is not input

    li $v0, 10            # load code for termininating the program into $v0
    syscall               # terminate program
