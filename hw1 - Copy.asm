;Program 1, two numbers	(Hw1.asm)
;author : Thomas Weathers
;Course / Project ID : 	CS 271 / Program #1				Date: 1/12/19
;Description:	this program takes in a users input of two integers, then produces the sum, difference, multiplicative,
;				and quotient of the two, as well as providing a remainder

 
 INCLUDE Irvine32.inc


 .data

 intro_0	BYTE	"author: Thomas Weathers",0
 intro_1	BYTE	"Hi, welcome to my program, nice to meet you!",0
 intro_2	BYTE	"This program will take in two numbers and provide the solutons to the +, -, *, and / operators of them",0
 ask1		BYTE	"give me a number?",0
 ask2		BYTE	"give me another number",0
 num_1		DWORD ?
 num_2		DWORD ?
 adios		BYTE	"Goodbye, have a nice day!",0
 added		DWORD ?
 subtract	DWORD ?
 multiply	DWORD ?
 division	DWORD ?
 remainder	DWORD ?
 add_sign	BYTE	" + ",0
 sub_sign	BYTE	" - ",0
 mult_sign	BYTE	" * ",0
 div_sign	BYTE	" / ",0
 equal_sign BYTE	" = ",0
 rem	BYTE	" Rem: ",0

.code
main PROC

; Introduce the program
	mov		edx, OFFSET intro_0
	call	WriteString
	call	CrLf
	mov		edx, OFFSET intro_1
	call	WriteString
	call	CrLf
	mov		edx, OFFSET intro_2
	call	WriteString
	call	CrLf

; Get number 1
	mov		edx, OFFSET ask1
	call	WriteString
	call	ReadInt
	mov		num_1, eax

; Get number 2
	mov		edx, OFFSET ask2
	call	WriteString
	call	ReadInt
	mov		num_2, eax

;calculate numbers

;calculate sum

	mov		eax, num_1
	call	WriteDec
	mov		edx, OFFSET add_sign
	call	WriteString
	mov		eax, num_2
	call	WriteDec
	mov		edx, OFFSET equal_sign
	call	WriteString

	mov		eax, num_1
	add		eax, num_2
	mov		added, eax
	
	mov		eax, added
	call	WriteDec
	call	CrLf


;calculate subtraction

	mov		eax, num_1
	call	WriteDec
	mov		edx, OFFSET sub_sign
	call	WriteString
	mov		eax, num_2
	call	WriteDec
	mov		edx, OFFSET equal_sign
	call	WriteString

	mov		eax, num_1
	sub		eax, num_2
	mov		subtract, eax
	
	mov		eax, subtract
	call	WriteInt
	call	CrLf

;calculate multiplication

	mov		eax, num_1
	call	WriteDec
	mov		edx, OFFSET mult_sign
	call	WriteString
	mov		eax, num_2
	call	WriteDec
	mov		edx, OFFSET equal_sign
	call	WriteString

	mov		eax, num_1
	mov		ebx, num_2
	mul		ebx
	mov		multiply, eax
	
	mov		eax, multiply
	call	WriteDec
	call	CrLf

;calculate division and remainder

	mov		eax, num_1
	call	WriteDec
	mov		edx, OFFSET div_sign
	call	WriteString
	mov		eax, num_2
	call	WriteDec
	mov		edx, OFFSET equal_sign
	call	WriteString

	mov		eax, num_1
	cdq
	mov		ebx, num_2
	div		ebx
	mov		division, eax
	mov		remainder, edx
	
	mov		eax, division
	call	WriteDec
	mov		edx, OFFSET rem
	call	WriteString
	mov		eax, remainder
	call	WriteDec
	call	CrLf

;goodbye
	mov		edx, OFFSET adios
	call	WriteString
	call	CrLf

	exit ; exit to operating system
main ENDP

; insert additional procedures here

END main