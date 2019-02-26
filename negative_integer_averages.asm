;Negative Integer Averages(homework3.asm)
;author : Thomas Weathers
;Course / Project ID :	CS 271 / Homework 3: Negative Integer Average			Date: 1/27/19
;Description:	This program takes in a user input between -100 and 1, stores the value and repeats this process,
;				when a number outside this range is entered the program will return the average of the previously 
;				entered negative numbers


 
 INCLUDE Irvine32.inc


 LOWER_LIMIT = -101	 ;setting constant of the lower limit to -101 at first, all user input must be above this
 
 .data

 intro_name				BYTE	"-----NEGATIVE INTEGER AVERAGE-----",0
 intro_author			BYTE	"author: Thomas Weathers",0
 intro_description		BYTE	"This program will take in your input as the user, store the value",0
 intro_description_2	BYTE	"then generate the average of those numbers. ",0
 intro_description_3	BYTE	"This program will accept negative numbers from -100 to -1. If a number greater ",0
 intro_description_4	BYTE	"than 0 is entered, the program will stop and calculate the previous values",0
 exit_0					BYTE	"no values entered ",0
 oor					BYTE	"number out of range",0

 prompt_name			BYTE	"what is your name?",0
 hello					BYTE	"hello ",0
 user_name				BYTE	33 DUP (0)
 prompt_number			BYTE	"Please provide the number you would like to add to the average [-100 - -1]",0
 prompt_number_2		BYTE	"please give a number: ",0
 inputted_num			DWORD	?

 current_total			DWORD	0
 num_entries			DWORD	0
 average				DWORD	?
 num_inputted			BYTE	"number of values entered: ",0

 print_sum				BYTE	"sum: ",0
 print_avg				BYTE	"average: ",0

 goodbye				BYTE	"goodbye ",0
 


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
	mov edx, OFFSET intro_description_3
	call	WriteString
	call CrLf
	mov edx, OFFSET intro_description_4
	call	WriteString
	call CrLf
	call CrLf

	;-------------------------------------

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

	;----------------------------------
	;GET USER INPUTTED LIMIT AND VERIFY
	;----------------------------------

	;prompts the user for a number between -100 to -1, stores it in inputted_num, 
	;if it is not valid it will end the loop 

	mov	edx, OFFSET prompt_number
	call	WriteString

	loop1:  ;reprompt loop
		mov	edx, OFFSET prompt_number_2
		call	WriteString
		call	ReadInt
		mov	inputted_num, eax

		;if the number inputted is less than -101

		cmp inputted_num, LOWER_LIMIT
		jle	out_of_range		; if it is less than -101, exit loop


		;if the number inputted is more than -1

		cmp inputted_num, -1 
		jg	jump_out						; if it is greater than -1,  exit loop


		;----add to sum-----

		;this adds the sum of the inputted number to the running total
		mov eax, current_total
		mov ebx, inputted_num
		add eax, ebx
		mov current_total, eax

		;increments the number of entries so far
		mov eax, num_entries
		add eax,1
		mov num_entries, eax


		jmp loop1

	;------out of range-------
	;prints the "out of range" phrase and jumps back to top of loop

	out_of_range:
		
		mov edx, OFFSET oor
		call WriteString
		call CrLf
		jmp loop1

	;-------------------------

	;------jump-out----------
	;this is the exit jump for loop1
	;checks if the there are 0 numbers entered total, to avoid div by 0

	jump_out:

		cmp num_entries, 0
		je	if_empty		;will skip the division to avoid division by 0

	;------------------------

	;------if more than	0 entries by user----

		;this prints the sum of the numbers

		mov	edx, OFFSET print_sum
		call	WriteString
		mov eax, current_total
		call	WriteInt
		call CrLf

		;this prints the number of entries so far

		mov edx,OFFSET num_inputted
		call WriteString
		mov eax, num_entries
		call WriteDec
		call CrLf

		;calculates the average of the numbers

		mov eax, current_total
		cdq 
		idiv num_entries

		;this prints out the average of the numbers 

		mov average, eax
		mov edx, OFFSET print_avg
		call WriteString
		mov eax, average
		call WriteInt
		call CrLf
		

		
		jmp	farewell

	;-----------if_empty-------------------
	;if there are no entries so far, to avoid div by 0

	if_empty:
		
		mov edx, OFFSET exit_0
		call	WriteString
		call CrLf
		jmp farewell
		
	;---------------------------------------

	;--------
	;FAREWELL to user
	;--------

	farewell:

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
