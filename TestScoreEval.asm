TITLE CalcGrade								      (CalcGrade.asm)
; Names : Inderpal Virdi, Padraic Reilly, Obaid Hasseeb, Stephen Miller
; Creation Date : 11/15/17
; Revisions : 1
; Date : 11/06/17
; Program Description :
	; Create a procedure named CalcGrade that receives an integer value between 0 and 100, and returns  single capital letter in the AL register. 
	; Preserve all other values between calls to the procedure. The letter returned by the procedure should be according to the following:
	; Score 90 to 100 Grade A
	; Score 80 to 89 Grade B
	; Score 70 to 79 Grade C
	; Score 60 to 69 Grade D
	; Score 0 to 59 Grade F
	; Write test program that generates 10 random integers between 50 and 100 inclusive. 
	; Each time an integer is generated, pass is to the CalcGrade procedure. You can test your program using a debugger,
    ; or if you prefer to use the book's library, you can display each integer and its corresponding letter grade.

INCLUDE Irvine32.inc
    
.data
	newString BYTE "Your grade is ",0
	grade BYTE ?,0
	out_of_range BYTE "The integer is not <= 100 and >= 0",0
	
	.code
main PROC
	call Randomize
	mov ecx,10
again: 
	mov eax,51
	call RandomRange
	add eax,50
	call GradeCalc
	mov edx,0
	mov edx, OFFSET newString
	call WriteString
	mov grade,al
	mov edx, OFFSET grade
	call WriteString
	call Crlf
	loop again
    exit
main ENDP

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
