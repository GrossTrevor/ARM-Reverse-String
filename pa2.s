.section .data

input_prompt  :   .asciz  "Please enter a string: \n"
input_format:    .asciz "%[^\n]"
output_format:   .asciz "%c"
new_line_format: .ascii "\n"

.section .text

.global main

main:


# branch to this label on program completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret