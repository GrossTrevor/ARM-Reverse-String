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

sub sp, sp, 24
ldr x0, = input_format
mov x1, sp
bl scanf
mov x0, sp
mov x1, 0

revstr:
	ldrb w1, [x0, x1]
    #ldr x0, = output_format
    stur w1, [sp, -4]
    stur x0, [sp, 0]
    ldr x0, = output_format
    bl printf
	add x1, x1, 1
    ldur x0, [sp, 0]
	cmp w1, 0
	bne revstr


# branch to this label on program completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret

