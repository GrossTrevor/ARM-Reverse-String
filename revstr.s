.section .data

input_prompt  :   .asciz  "Please enter a string: \n"
input_format:    .asciz "%[^\n]"
output_format:   .asciz "%c"
new_line_format: .ascii "\n"

.section .text

.global main

# print each letter as they occur then print a new line and print off the stack in reverse order

main:

ldr x0, = input_prompt
bl printf
mov x1, 0

revstr:
	ldurb x0, [= input_format, x1]
	bl printf
	cmp x0, 0
	b.ne rec
	mov x1, 0
	br x30

rec:
	sub sp, sp, 8
	add x1, x1, 8
	sturb x0, [sp]
	bl revstr
	ldurb x0, [sp]
	bl printf
	add sp, sp, 8
	b exit

# branch to this label on program completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret