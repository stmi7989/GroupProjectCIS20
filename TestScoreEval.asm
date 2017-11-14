TITLE CalcGrade								      (CalcGrade.asm)
; Names : Inderpal Virdi, Padraic Reilly, Obaid Hasseeb, Stephen Miller
; Creation Date : 11/15/17
; Revisions : 2
; Program Description :
	; Create a procedure named CalcGrade that receives an integer value between 0 and 100, and returns  single capital letter in the AL register. 
	; Preserve all other values between calls to the procedure. The letter returned by the procedure should be according to the following:
	; Score 90 to 100 Grade A
	; Score 80 to 89 Grade B
	; Score 70 to 79 Grade C
	; Score 60 to 69 Grade D
	; Score 0 to 59 Grade F
	; Write test program that generates 10 random integers between 50 and 100 inclusive. 
	; Each time an integer is generated, it is passed to the CalcGrade procedure.
.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO,dwExitCode:dword
INCLUDE Irvine32.inc
    
.data
	greet BYTE "Welcome to GradeCalc",0
	goodbye BYTE "Quitting",0
	menu_1 BYTE "--------------------------",0
	menu_2 BYTE "-   Choose an option     -",0
	menu_3 BYTE "- A. 10 Random Grades    -",0
	menu_4 BYTE	"- B. User Chooses Number -",0
	menu_5 BYTE	"- C. Exit Program        -",0
	menu_6 BYTE	"--------------------------",0
	get_option BYTE "Enter option: ",0
	option_A BYTE "a",0
	option_B BYTE "b",0
	option_C BYTE "c",0
	get_number_of_grades BYTE "How many grades to return? ",0
	grade_string BYTE "Your grade is ",0
	grade BYTE ?,0
	out_of_range BYTE "The integer is not <= 100 and >= 0",0
	too_much BYTE "That's too much!",0
	not_enough BYTE "That's not enough!",0
	wrong_letter BYTE "Input must be A, B, or C",0
	
	.code
main PROC
	call Menu
	
	invoke ExitProcess,0
main ENDP

Menu PROC
	; Displays menu
begin:
	mov edx, OFFSET menu_1
	call WriteString
	call Crlf
	mov edx, OFFSET menu_2
	call WriteString
	call Crlf
	mov edx, OFFSET menu_3
	call WriteString
	call Crlf
	mov edx, OFFSET menu_4
	call WriteString
	call Crlf
	mov edx, OFFSET menu_5
	call WriteString
	call Crlf
	mov edx, OFFSET menu_6
	call WriteString
	call Crlf

get: ; user input
	mov edx, OFFSET get_option
	call WriteString
	call ReadChar
	call Crlf
	or al, 20h  
	;check range of input against ASCII binary values of A-C
	cmp al, option_A
	jl too_low
	cmp al, option_C
	jg too_high
	cmp al, option_A
	je optionA
	cmp al, option_B
	je optionB
	cmp al, option_C
	je optionC

optionA:
	; user chose option A -
	; returns 10 random grades
	call Random
	jmp begin

optionB:
	; user chose option B -
	; user chooses how many grades to return
	call User_Input
	jmp begin

optionC:
	; user chose option C -
	; user chose to quit the program
	mov edx, OFFSET goodbye
	call WriteString
	call Crlf
	ret

too_high:
	mov edx, OFFSET wrong_letter
	call WriteString
	call Crlf
	jmp get

too_low:
	mov edx, OFFSET wrong_letter
	call WriteString
	call Crlf
	jmp get
Menu ENDP

Random PROC
	call Randomize
	mov ecx,10
again: 
	mov eax,51
	call RandomRange
	add eax,50
	call GradeCalc
	mov edx,0
	mov edx, OFFSET grade_string
	call WriteString
	mov grade,al
	mov edx, OFFSET grade
	call WriteString
	call Crlf
	loop again
    ret
Random ENDP

User_Input PROC
ask: ; for user input
	mov edx, OFFSET get_number_of_grades
	call WriteString
	call ReadInt
	call Crlf

	; check that user input is in range
	cmp eax,51
	jge too_high
	cmp eax,0
	jle too_low
	jmp begin

too_high:
	mov edx, OFFSET too_much
	call WriteString
	call Crlf
	jmp ask

too_low:
	mov edx, OFFSET not_enough
	call WriteString
	call Crlf
	jmp ask
	
begin: ; loop
	call Randomize
	mov ecx,eax
again:
	mov eax,51
	call RandomRange
	add eax,50
	call GradeCalc
	mov edx,0
	mov edx, OFFSET grade_string
	call WriteString
	mov grade,al
	mov edx, OFFSET grade
	call WriteString
	call Crlf
	loop again
	ret
User_Input ENDP

GradeCalc PROC
OutofRangeHigh:
	cmp	eax,101
	jb  Grade_A
	mov edx, OFFSET out_of_range
	call WriteString
	call Crlf
	call WriteDec
	jmp finished

Grade_A:
	cmp	eax,90
	jb	Grade_B
	mov	al,'A'
	jmp	finished

Grade_B:
	cmp	eax,80
	jb	Grade_C
	mov	al,'B'
	jmp	finished
	
Grade_C:
	cmp	eax,70
	jb	Grade_D
	mov	al,'C'
	jmp	finished

Grade_D:
	cmp	eax,60
	jb	Grade_F
	mov	al,'D'
	jmp	finished

Grade_F:
	cmp eax,0
	jb  OutofRangeLow
	mov	al,'F'
	jmp finished

OutofRangeLow:
	mov edx, OFFSET out_of_range
	call WriteString
	call Crlf
	call WriteDec
	jmp finished
finished:
	ret

GradeCalc ENDP

END main
