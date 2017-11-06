# GroupProjectCIS20
Group project for CIS 20 Assembly Language

Project collaborators: Inderpal Virdi, Padraic Reilly, Obaid Hasseeb, Stephen Miller

Create a procedure named CalcGrade that receives an integer value between 0 and 100, and returns a 
single capital letter in the AL register. Preserve all other regist
er values between calls to the procedure. 
The letter returned by the procedure should be according to the following ranges:
Score Range
 Letter Grade
-------------------------
90 to 10
 A 
80 to  89        
 B 
70 to  79       
 C 
60 to  69       
 D 
 0 to  59        
 F 
 
Write a test program that generates 10 random integers between 50 and 100, inclusive. Each time an 
integer is generated, pass it to the CalcGrade procedure.  You can test your program using a debugger, 
or if you prefer to use the book's library, you can display each integer and its corresponding letter grade
