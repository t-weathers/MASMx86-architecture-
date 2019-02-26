;COMPOSITE NUMBERS(homework4.asm)
;author : Thomas Weathers
;Course / Project ID :	CS 271 / Homework 4: composite numbers			Date: 2/17/19
;Description:	This program will take in a user entered number, validate that is is between 1 and 400, and then
;				produce this number of composite numbers in increasing order


 
 INCLUDE Irvine32.inc


 UPPER_LIMIT = 400	 ;setting constant of the upper limit to 400, this is max entered value
 
 .data

 intro_name				BYTE	"-----COMPOSITE NUMBER CALCULATOR-----",0
 intro_author			BYTE	"author: Thomas Weathers",0
 intro_description		BYTE	"This program will take in your input as the user, a number from 1-400",0
 intro_description_2	BYTE	"then generate that number of composite numbers. ",0
 exit_0					BYTE	"no values entered ",0
 oor					BYTE	"number out of range",0
 spaces					BYTE	"   ",0

 prompt_name			BYTE	"what is your name?",0
 hello					BYTE	"hello ",0
 user_name				BYTE	33 DUP (0)
 prompt_number			BYTE	"Please provide the number of composite numbers you would like [1 - 400]",0
 prompt_number_2		BYTE	"please give a number [1 - 400]: ",0
 inputted_num			DWORD	?

 current_number			DWORD	4
 is_composite			DWORD	0 
 counter_squared		DWORD	0
 num_printed			DWORD	0
 counter				DWORD	0
 num_inputted			BYTE	"number of values entered: ",0
 num_validated			DWORD	0



 goodbye				BYTE	"goodbye ",0
 


.code

;-------------------------------------
;introduction
;this introdocues the user to the program by printing a description and the author
;this also sotres the users inputted name
;-------------------------------------
introduction PROC

	;this block prints the name of the program and the name of the author

	mov edx, OFFSET intro_name				;prepare name of program so WriteString can print it
	call	WriteString						;print the name of the program
	call CrLf
	mov edx, OFFSET intro_author			;prepare name of author so WriteString can print it
	call WriteString						;print the name of the program
	call CrLf

	;prints out the description of the program for the user,

	mov edx, OFFSET intro_description
	call	WriteString
	call CrLf
	mov edx, OFFSET intro_description_2
	call	WriteString
	call CrLf
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

	ret

introduction ENDP


;-----------------------------------
;GetUserData
;collects the user's input an integer from 1-400
;this is then validated and reprompted through calling Validate
;pre: user inputs value into inputted_num
;post: validated number is stored in num_validated
;-----------------------------------
GetUserData PROC
	mov	edx, OFFSET prompt_number_2
	call	WriteString						;print prompt for number
	call	ReadInt
	mov	inputted_num, eax				

	Call Validate

	mov eax, inputted_num		
	mov num_validated, eax					; set validated inputted_num to num_validated
				
	ret

GetUserData ENDP


;-----------------------------------
;Validate
;this validates the user's inputted number to see that it is within the specifications [1-400]
;pre:inputted_num contains a number inputted from user 
;post: inputted num contains a number that has been validated as within the bounds
;-----------------------------------
Validate PROC
	jmp first_round

	reprompt:
		mov edx, OFFSET oor
		call WriteString
		call CrLf
		mov	edx, OFFSET prompt_number_2			;prompt for the next number
		call	WriteString
		call	ReadInt
		mov	inputted_num, eax

		first_round:
			cmp inputted_num, UPPER_LIMIT
			jg	reprompt		; if num is greater than 400, reprompt


			;if the number inputted is less than 1

			cmp inputted_num, 1 
			jl	reprompt				; if it is less than 1,  reprompt


	ret

Validate ENDP

;-----------------------------------
;DisplayComposites
;display the nth number of composite numbers
;pre: validated number of composites to be printed is stored
;post: correct number of compite numbers is printed to screen in correct format
;-----------------------------------
DisplayComposites PROC
	mov ecx, num_validated			;set loop to be the number of composites desired
	loop1:

		CALL isComposite					

		mov eax, is_composite	
		cmp eax, 0							;if not composite
		je kg2

		print:
			mov eax, num_printed
			mov ebx, 10
			div ebx								; check if number of printed composites is % 10
			cmp edx, 0				
			jne no_new_line
				
			CALL CrLf

			no_new_line:						;not the %10'th number of printed values
				mov eax, current_number
				call WriteDec
				mov edx, OFFSET spaces			;print 3 spaces following number
				call WriteString
				inc current_number
				inc num_printed
				jmp correct_found				;jump to decrement and loop number of successful prints



		kg2:					;if not composite
			inc current_number
			jmp loop1			;loop again without decrementing number of successful numbers found
			
		correct_found:
			loop loop1

DisplayComposites ENDP



;-----------------------------------
;isComposite
;will verify that the number that is being inputted is composite, and set is_composite to correct value
;pre: current_number is the number that is being checked for composite. 
;post: this procedure will exit with is_composite being 1 (true) or 0 (false)
;-----------------------------------
isComposite PROC
	mov counter, 2

	loopComposite:
		mov edx,0
		mov eax, current_number
		cdq
		div counter				
		cmp edx, 0						;find remainder of dividing current number by counter
		jne kg
										 ;yes its composite
			mov is_composite, 1
			ret

		kg:								;not compsite with this divisor (at least)
			inc counter
			mov eax, counter
			cmp eax,current_number		;exit loop, not composite
			jge jmpout

			jmp loopComposite


	jmpout:							
		mov is_composite, 0					;did not pass composite test, set to prime value
		ret

isComposite ENDP




;-----------------------------------
;Farewell
;this prints the goodbye message to the user
;post: "goodybe user" is printed to the screen
;-----------------------------------
farewell PROC

		call CrLf
		call CrLf
		mov edx, OFFSET goodbye							;print "goodbye"
		call	WriteString
		mov edx, OFFSET user_name						;print users name
		call	WriteString
		call CrLf

		ret

farewell ENDP


;----------------------------
;main
;main driver for the program
;----------------------------
main PROC

	call introduction			;calls the introduction procedure

	call GetUserData			;collects user data (number from 1-400) and verify's it

	call DisplayComposites		;print the composite numbers

	call farewell				;say goodbye to the user

	exit ; exit to operating system
main ENDP


END main
