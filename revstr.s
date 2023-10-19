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

    sub sp, sp, 24
    stur x30, [sp, 16]
    stur x1, [sp, 8]
    stur x0, [sp, 0]

	ldrb w1, [x0]
    cmp w1, 0
    bne recstr

    ldr x0, = new_line_format
	bl printf

	ldur x30, [sp, 16]
    br x30

recstr:
    
    ldr x0, = output_format
    bl printf

	ldur x30, [sp, 16]
    ldur x1, [sp, 8]
    ldur x0, [sp, 0]
    add sp, sp, 24
    add x0, x0, 1
    bl revstr

    ldur x30, [sp, 16]
    ldur x1, [sp, 8]
    ldur x0, [sp, 0]
    add sp, sp, 24
    ldrb w1, [x0]
    ldr x0, = output_format
    bl printf
    br x30



# branch to this label on program completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret

