;RANDOM NUMBER SORTER
;author : Thomas Weathers
;Course / Project ID :	CS 271 / Homework 5: random number sorter			Date: 2/23/19
;Description:	This program will take in a user entered number, validate that is is between 10 and 200, and then
;				produce a randomly developed array of numbers betweem 100 and 999
;				the progrma will then sort these using bubble sort, and display the median of the sorted array

 INCLUDE Irvine32.inc


 MAX = 200	 ;setting constant of max to 200, this is max entered value
 MIN = 10	;minimum value that can be entered by user
 HI = 999
 LO = 100
 



 .data

 intro_name				BYTE	"-----RANDOM NUMBER SORTER-----",0
 intro_author			BYTE	"author: Thomas Weathers",0
 intro_description		BYTE	"This program will take in your input as the user, a number from 10-200",0
 intro_description_2	BYTE	"then generate that number of random numbers between 100 and 999",0
 intro_description_3	BYTE	"the program will sort these numbers and display the median value",0
 oor					BYTE	"number out of range",0
 spaces					BYTE	"   ",0
 title_1				BYTE	"unsorted array",0
 title_2				BYTE	"sorted array",0
 title_3				BYTE	"median: ",0
 prompt_number			BYTE	"Please provide the number of composite numbers you would like [1 - 400]",0
 prompt_number_2		BYTE	"please give a number [10 - 200]: ",0
 request				DWORD	?
 array					DWORD	MAX	DUP(?)
 goodbye				BYTE	"goodbye ",0
 


.code
;----------------------------
;main
;main driver for the program
;----------------------------
main PROC
	call Randomize


	;-------------------
	;call introduction with param:	program name
	;								author name
	;								3 introductions to the program function
	;-------------------
	push OFFSET intro_name
	push OFFSET intro_author
	push OFFSET intro_description
	push OFFSET intro_description_2
	push OFFSET intro_description_3
	call introduction			;calls the introduction procedure

	;---------------------
	;call GetUserData with param: out of range warning (reference)
	;								prompt for number							
	;								length of array (request)
	;---------------------
	push OFFSET oor
	push OFFSET prompt_number_2
	push OFFSET request
	call GetUserData		


	;------------------
	;call fill_array with param:array(reference)
	;							length of array (request)
	;---------------
	push OFFSET array
	push request
	call fill_array

	;--------------
	;call display_array with param:	spaces title (3 spaces)
	;								the array (reference)
	;								request length of array (value)
	;								title "unsorted array" (reference)
	;--------------
	push OFFSET spaces
	push OFFSET array
	push request
	push OFFSET title_1
	call display_array


	;------------
	;call sort on array with param:	array (reference)
	;								length of array (value)
	;------------
	push OFFSET array
	push request
	call sort

	call CrLf

	;------------
	;call display_median with parameters:  title3 "median: " (reference)
	;										array (reference)
	;										length of array (value)
	;------------
	push OFFSET title_3
	push OFFSET array
	push request
	call display_median

	call CrLf


	;--------------
	;call display_array with param:	spaces title (3 spaces)
	;								the array (reference)
	;								request length of array (value)
	;								title "sorted array" (reference)
	;--------------
	push OFFSET spaces
	push OFFSET array
	push request
	push OFFSET title_2
	call display_array


	push OFFSET goodbye
	call farewell				;say goodbye to the user

	exit ; exit to operating system
main ENDP




;-------------------------------------
;introduction
;this introdocues the user to the program by printing a description and the author
;this also sotres the users inputted name
;paramters are the 5 introduction strings: intro_name, intro_author, intro_description,
;											intro_description_2, intro_description_3
;prints out the introductions
;-------------------------------------
introduction PROC
	push ebp
	mov ebp,esp

	;this block prints the name of the program and the name of the author

	mov edx, [ebp + 24]				;prepare name of program so WriteString can print it
	call	WriteString						;print the name of the program
	call CrLf
	mov edx, [ebp + 20]		;prepare name of author so WriteString can print it
	call WriteString						;print the name of the program
	call CrLf

	;prints out the description of the program for the user,

	mov edx, [ebp + 16]
	call	WriteString
	call CrLf
	mov edx, [ebp+12]
	call	WriteString
	call CrLf
	mov edx, [ebp+8]
	call	WriteString
	call CrLf
	call CrLf

	pop ebp
	ret 20

introduction ENDP


;-----------------------------------
;GetUserData
;collects the user's input an integer from 10-200
;this is then validated and reprompted through calling Validate
;pre: user inputs value into inputted_num
;post: validated number is stored in num_validated
;-----------------------------------
GetUserData PROC
	
	push ebp
	mov ebp, esp

	; take in variable request, set to new value that is validate


	mov	edx,[ ebp+12]
	call	WriteString						;print prompt for number
	call	ReadInt
	;mov	inputted_num, eax
	mov ebx, [ebp+8]
	mov [ebx],eax
	
	push [ebp+16]
	push [ebp+12]
	push [ebp + 8]

	Call Validate

			
	pop ebp
	ret 12

GetUserData ENDP


;-----------------------------------
;Validate
;this validates the user's inputted number to see that it is within the specifications [min-max]
;pre:inputted_num contains a number inputted from user
;parameters: error statement, request another number, storage variable (request)
;post: request contains a number that has been validated as within the bounds
;-----------------------------------
Validate PROC
	push ebp
	mov ebp,esp
	jmp first_round
	mov ebx, [ebp+8]		;ebx is storage variable

	reprompt:
		mov edx,[ebp + 16]
		call WriteString
		call CrLf
		mov	edx, [ebp+12]			;prompt for the next number
		call	WriteString
		call	ReadInt
												;eax is read int

		first_round:
			cmp eax, MAX
			jg	reprompt						; if num is greater than 400, reprompt


			;if the number inputted is less than 1

			cmp eax, MIN
			jl	reprompt						; if it is less than 1,  reprompt


		mov [ebx],eax
	pop ebp
	ret 12

Validate ENDP


;------------------------------------
;Fill Array
;this fills the array with random numbers, of the ammount that the user specified in request
;parameters: array, and length of array (request)
;post: array is filled with random values between 100-999
;------------------------------------
fill_array PROC
	push ebp
	mov ebp,esp
	mov esi, [ebp+12]			;esi starts at 0th index
	mov ecx, [ebp+8]			;ecx holds request num
	loop1:


		mov eax, HI
		sub eax, LO
		add eax,1
		call RandomRange			;generate random number
		add eax, LO

		mov [esi], eax				;add random number to this spot in array
		add esi, 4					;increment array by 4 bytes
		loop loop1



	pop ebp
	ret 8
fill_array ENDP




;------------------------------------
;display_array
;this displays the array, and the type of array in the title before
;parameters:spaces between letters, array(reference), array length (request), title of array
;------------------------------------
display_array PROC
	push ebp
	mov ebp,esp					;[ebp+8] is the title string
	mov esi, [ebp+16]			;esi starts at 0th index
	mov ecx, [ebp+12]			;ecx holds request num
	mov edx, [ebp+8]
	call WriteString
	call CrLf
								;make ebx a counter, if 10, set to 0 and crlf, else inc
	mov ebx, 0

	continue:
		mov eax,[esi]
		call WriteDec
		inc ebx
		mov edx, [ebp+20]
		call WriteString
		add esi,4
		newLine:
			cmp ebx, 10
			jl continue2
			call CrLf
			mov ebx, 0

		continue2:
			loop continue

	pop ebp
	ret 16
display_array ENDP


;-----------------------------------
;display median
;
;
;-----------------------------------
display_median PROC

	push ebp
	mov ebp,esp
	mov esi, [ebp+12]			;esi starts at 0th index
	mov ebx, [ebp+8]			;ecx holds request num
	mov edx, 0	

	call CrLf

	mov eax, ebx			;divide length by 2 and check if even or odd
	mov ecx, 2				;using the remainder
	div ecx
	cmp edx, 0
	jne ndiv2
										; if the length of the array is even
	mov ecx, 4					;multiply dsitance by 4 for stack space length
	mul ecx
	mov ecx, [esi + eax]
	sub eax, 4					
	mov eax, [esi + eax]
	add eax, ecx
	mov ecx, 2	
	div ecx						;divide to find middle
		
	mov edx, [ebp+16]			;print out title and number
	call WriteString
	call WriteDec
	jmp ToEnd

	ndiv2:										; if the length of the array is odd
		mov ebx, 4
		mul ebx									;already done accurate division because rem is the middle
		mov ecx, [esi + eax]
		mov edx, [ebp+16]
		call WriteString						;print out title and number
		mov eax, ecx 
		call WriteDec

	ToEnd:
		call CrLf

	pop ebp
	ret 12
display_median ENDP

;-----------------------------
;sort
;parameters: array (reference)
;			legth of array (request)
;this will sort the array using bubble sort to make a decrementing int array
;------------------------------

;///////////////////////////////////////////////////
;USES BUBBLESORT.ASM, GIVEN BY TEXTBOOK IRVINE X86  
;see textbook ch 9: pg 375
;///////////////////////////////////////////////////

sort PROC
	push ebp
	mov ebp,esp					
	mov ecx, [ebp+8]					
	mov eax, ecx
	dec eax
	mov ecx, eax

	Loop1:
		push ecx
			mov esi,[ebp+12]

	Loop2:
		mov eax, [esi]
		cmp [esi+4], eax
		jl Loop3
		xchg eax, [esi+4]
		mov [esi], eax

	Loop3:
		add esi,4
		loop Loop2
		pop ecx
		loop Loop1

	pop ebp
	ret 8
sort ENDP

;-----------------------------------
;Farewell
;this prints the goodbye message to the user
;post: "goodybe user" is printed to the screen
;-----------------------------------
farewell PROC
		push ebp
		mov ebp,esp	
		call CrLf
		call CrLf
		mov edx,[ebp+8]							;print "goodbye"
		call	WriteString
		call CrLf

		pop ebp
		ret 4

farewell ENDP


END main