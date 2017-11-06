include Irvine32.inc
.data
str1 BYTE ": The letter grade is ",0
grade BYTE ?
.code
main PROC
; your codes go here.
again:
    ; your codes go here.
    ; Print the grade (optional)
; your codes go here.
    exit
main ENDP
CalcGrade proc
; Calculates a letter grade
; Receives: EAX = numeric grade
; Returns:  AL = letter grade
Grade_A:
; your codes go here.
Grade_B:
; your codes go here.
;Repeat for Grade_C, Grade_D, and Grade_F
finished:
   ret
CalcGrade endp
END main
