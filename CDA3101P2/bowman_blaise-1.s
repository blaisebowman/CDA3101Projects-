
.section .data
stringFormat : .asciz "%[^\n]"
numFormat: .asciz "%d"
input:    .space 256
prompt: .asciz "Input a String: "
prompt2: .asciz "Error\n"
newLine: .asciz "\n"

.section .text
.global main

main:

ldr x0, =prompt
bl printf //used to display prompt

ldr x0, =stringFormat
ldr x1, =input

bl scanf

ldr x1, =input //...rev ldrsw x0, =input

mov x20, x1

bl strloop

label:

#move the updated string into register x1
mov x1, x10
#print the updated string (vowels replaced with x)
ldr x0, =input
bl printf

#flush the buffer
ldr x0, =newLine
bl printf
b exit

exit:
#exit from the program
mov x0, #0
mov x8 ,#93
svc #0

strloop:
mov x19, #0
b L1
L1:
add x10,x19,x20 //adress of y[i] is in x10,,, x20 is the pointer to the string
ldrb w11, [x10,#0] //loads the byte into w11
# compare y[i] to ascii values
cmp w11, #65 //ASCII A
b.eq replace
cmp w11, #69 //ASCII E
b.eq replace
cmp w11, #73 //ASCII I
b.eq replace
cmp w11, #79 //ASCII O
b.eq replace
cmp w11, #85 //ASCII U
b.eq replace
cmp w11, #97 //ASCII a
b.eq replace
cmp w11, #101 // ASCII e
b.eq replace
cmp w11, #105 //ASCII i
b.eq replace
cmp w11, #111 //ASCII o
b.eq replace
cmp w11, #117 //ASCII u
b.eq replace
L3:
strb w11, [x10, #0]
CBZ w11,L2 //if y[i] = 0 (null character) go to L2;
add x19,x19,#1 //i=i+1 (increment i) //if not end of user's string, increment i and repeat for next char
b L1 //Go to L1
# Used at the ending of the user inputed string
L2:
//mov x1, x10
b label //back to main
#used to replace the current vowel with a lower-case x
replace:
mov w11, #120 //120 is the ascii value for lower-case x
b L3

