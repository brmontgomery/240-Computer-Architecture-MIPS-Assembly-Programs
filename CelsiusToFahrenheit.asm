#  Assignment 2
#  Converts between Fahrenheit and Celsius and back
#
#  By Brian Montgomery
#  10/4/2021
# -----------------------------------------------------
#  Data Declarations

.data
header:		.asciiz	"Assignment 2: Temperature Conversion\nEnter 0 for Celsius to Fahrenheit Conversion or 1 for Fahrenheit to Celsius Conversion. Alternatively input a number greater than 1 to quit the program.\n"
CtoFHeader: .asciiz	"\n\nCelsius to Fahrenheit Chosen\n\nPlease input a temperature to be converted (conversions will be rounded to the nearest whole number): \n"
FtoCHeader: .asciiz	"\n\nFahrenheit to Celsius Chosen\n\nPlease input a temperature to be converted (conversions will be rounded to the nearest whole number): \n"
ansMsg:		.asciiz	"\n\nYour converted value is: "
newLines:	.ascii	"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
value:		.word	0

# -----------------------------------------------------
#  text/code section
.text
.globl	main
.ent	main
main:
Loop:	li	$v0,	4						# call code for print string
		la	$a0,	header					# address of NULL terminated str hdr (starting text)
		syscall								# system call

		li	$v0,	5						# call code for read integer
		syscall

		li	$t0,	1						# set temp variable to 1 for the next comparison
		slt	$t1,	$t0,	$v0				# check if input is more than 1
		bne $0,		$t1		Quit			# quit if the input was greater than 1

		beq	$0,		$v0		CtoF			# check to see if user input 0 or 1 jump if necessary

FtoC:										# Fahrenheitto Celsius
		#get value
		li	$v0,	4						# call code for print string
		la	$a0,	FtoCHeader				# address of NULL terminated str hdr (starting text)
		syscall								# system call

		li	$v0,	5						# call code for read integer
		syscall

		#calculate
		li		$t0,	32
		sub		$v0,	$v0,	$t0			# subtract 32
											  
		li		$t0,	5					# set the multiply value
		mul		$t1,	$v0,	$t0			# multiply by 5
											  
		li		$t0,	9					# set divide value
		div		$t1,	$t0					# divide by 9
		mflo	$t1							# get quotient
		mfhi	$t0							# get remainder
											  
		li		$t2,	4					# set midpoint value
		slt		$t0,	$t2,	$t0			# check if remainder is greater than 2
											  
		beq		$t0,	$0,		Print		# if remainder is 2 or less, go straight to print
		addi	$t1,	$t1,	1			# else add 1 to the main number
		j		Print						#jump to the print section

CtoF:										# Fahrenheit to Celsius
		#get value
		li	$v0,	4						# call code for print string
		la	$a0,	CtoFHeader				# address of NULL terminated str hdr (starting text)
		syscall								# system call

		li	$v0,	5						# call code for read integer
		syscall

		#calculate
		li		$t0,	9					# set the divide value
		mul		$t1,	$v0,	$t0			# multiply by 9

		li		$t0,	5					# set the divide value
		div		$t1,	$t0					# divide by 5
		mflo	$t1							# get quotient
		mfhi	$t0							# get remainder

		addi	$t1,	$t1,	32			# add the final 32
											  
		li		$t2,	2					# set midpoint value
		slt		$t0,	$t2,	$t0			# check if remainder is greater 
									 		  
		beq		$t0,	$0,		Print		# Print if remainder is 2 or less
		addi	$t1,	$t1,	1			# else add 1 to the main number
		j		Print						#jump to the print section
		
Print:										#ending prints
		sw		$t1,	value				# save to variable

		li		$v0,	4					# call code for print string
		la		$a0,	ansMsg				# addr of NULL terminated str
		syscall								# system call

		li		$v0,	1					# call code for print integer
		lw		$a0,	value				# value for integer to print
		syscall								# system call

		li		$v0,	4					# call code for print string
		la		$a0,	newLines			# addr of NULL terminated str
		syscall								# system call

		j Loop								#jump back to the start of the program

Quit:
		li      $v0,	10					# terminate program run and
		syscall								# Exit 
.end main