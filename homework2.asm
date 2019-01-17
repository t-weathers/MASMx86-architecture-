;Fibonacci Numbers	(homework2.asm)
;author : Thomas Weathers
;Course / Project ID :	CS 271 / Homework 2: Fibonacci Numbers			Date: 1/16/19
;Description:	This program takes in a user input between 1 and 46, stores the value, then generates the fibonacci
;				numbers to the nth digit, where n is the inputted number. if a user enters an invalid number the program
;				will keep prompting the user until a valid input is recieved

 
 INCLUDE Irvine32.inc


 UPPER_LIMIT = 0	 ;setting constant of the upperlimit to 0 at first, this will be changed to a number from 1-46 that the user inputs
 NUM_PER_LINE_LIMIT = 5		;this is the constant number of fibonacci numbers to be displayed in a single line
 

 .data

 intro_name		BYTE	"-----FIBONACCI NUMBERS-----",0
 intro_author	BYTE	"author: Thomas Weathers",0
 intro_description	BYTE	"This program will take in your input as the user, store the value",0
 intro_description_2	BYTE	"then generatethe fibonacci numbers to the nth digit",0

 prompt_name	BYTE	"what is your name?",0
 hello			BYTE	"hello ",0
 user_name		BYTE	33 DUP (0)
 prompt_number	BYTE	"Please provide the number of fibonacci digits you would like to see [1-46]",0
 inputted_num	DWORD	?
 FiveSpace		BYTE	"     ",0

 num_printed_in_line	DWORD	0
 total_printed	DWORD	0

 previous_num	DWORD	1
 current_num	DWORD	1

 goodbye		BYTE	"goodbye "
 


.code
main PROC

	;------------
	;INTRODUCTION
	;------------

	;this block prints the name of the program and the name of the author

	mov edx, OFFSET intro_name				;prepare name of program so WriteString can print it
	call	WriteString						;print the name of the program
	call CrLf
	mov edx, OFFSET intro_author			;prepare name of author so WriteString can print it
	call WriteString						;print the name of the program
	call CrLf


	;prompt the user for their name, store it in user_name

	mov	edx, OFFSET prompt_name				;prepares prompt for user name for writeString WriteString 
	call	WriteString						;print the prompt for the name from the user
	mov		edx, OFFSET user_name			;prepares user_name for ReadString
	mov		ecx,32							;set the length to be read in from ReadString, creating a buffer
	call	ReadString						;read in the string from the user, which is stored in User_name


	;prints out the user name preceeded by "hello ".

	mov edx, OFFSET hello
	call	WriteString
	mov edx, OFFSET user_name
	call	WriteString
	call CrLf

	;-----------------
	;USER INSTRUCTIONS
	;-----------------

	;prints out the description of the program for the user,

	mov edx, OFFSET intro_description
	call	WriteString
	call CrLf
	mov edx, OFFSET intro_description_2
	call	WriteString
	call CrLf
	call CrLf
	


	;----------------------------------
	;GET USER INPUTTED LIMIT AND VERIFY
	;----------------------------------


	;prompts the user for a number between 1-46, stores it in inputted_num, 
	;if it is not valid it will reprompt 

	loop1:
		mov	edx, OFFSET prompt_number
		call	WriteString
		call	ReadInt
		mov	inputted_num, eax

		;if the number inputted is less than one

		cmp inputted_num, 1
		jl	loop1						; if it is less than 1, loop again

		;if the number inputted is more than 46

		cmp inputted_num, 46
		jg	loop1						; if it is greater than 46, loop again

	UPPER_LIMIT = inputted_num			;set the upper limit to the number that the user gave, it is now verified

	;-------------------------
	;DISPLAY FIBONACCI NUMBERS
	;-------------------------
	
	;print the first number (1) before the loop starts
	;this is printed in every scenario so it is printed
	;before the loop

	mov eax, current_num
	call	WriteDec
	mov	edx, OFFSET FiveSpace
	call	WriteString

	;increment the number of numbers printed in total and in this line

	inc num_printed_in_line
	inc	total_printed

	;set the counter for the following loop (L1) to be the Upper Limit
	;that the user has entered

	mov	ecx, UPPER_LIMIT
	L1:

		;if the total printed is greater than or equal to the upper limit, exit loop
		;L2 is the "exit loop" jump

		mov	eax, total_printed
		cmp eax, UPPER_LIMIT
		jge L2

		;if the number printed thus far in this line is greater than or equal to 5, add a new line character
		;then reset the number printed in this line to 0
		
		mov eax, num_printed_in_line
		cmp eax, NUM_PER_LINE_LIMIT
		jl L3
		call	CrLf
		mov	num_printed_in_line,0

		L3:

			;prints out the current number of the fibonacci sequence

			mov eax,current_num
			call	WriteDec
			mov	edx,OFFSET FiveSpace
			call	WriteString
			
			;adds the two numbers together, previous and current

			mov	eax, current_num
			mov	ebx, previous_num
			add eax,ebx					;store the next number to be printed in eax, the sum of current and previous sum

			;sets previous to current number, 
			;sets current number to the new added number

			mov ebx,current_num
			mov	previous_num, ebx
			mov	current_num,eax


		;increment the number printed in this line and total printed numbers

		inc	num_printed_in_line
		inc	total_printed

		;start over in loop, this decrements ecx

		loop L1

	;L2 is the "escape" loop, this will exit the loop L1

	L2:

		

	;--------
	;FAREWELL
	;--------

	;prints the goodbye for the program, stating the users name afterwards

	call CrLf
	call CrLf
	mov edx, OFFSET goodbye
	call	WriteString
	mov edx, OFFSET user_name
	call	WriteString
	call CrLf



	exit ; exit to operating system
main ENDP


END main