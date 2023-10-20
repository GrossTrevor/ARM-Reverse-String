.section .data

input_prompt  :   .asciz  "Please enter a string: \n"
input_format:    .asciz "%[^\n]"
output_format:   .asciz "%c"
new_line_format: .ascii "\n"

.section .text

.global main

main:

# print the input prompt
ldr x0, =input_prompt
bl printf

# create space on the stack...
sub sp, sp, 8
# ...and zero it out
stur xzr, [sp]

# read the input string into the space on the stack
ldr x0, =input_format
mov x1, sp
bl scanf

# save input string address
mov x0, sp
mov x1, 0

# begin printing
bl revstr

# reclaim initial stack space
add sp, sp, 8

# print a new line
ldr x0, =new_line_format
bl printf

# exit the program
b exit

revstr:

    # create space on the stack for...
    sub sp, sp, 16
    # ...the return address...
    stur x30, [sp, 8]
    # ...and the input string address
    stur x0, [sp, 0]
 
    #load a byte of the input string...
    ldrb w1, [x0, 0]
    # ...and check if it is null...
    cmp w1, 0
    # ...and branch if false to rec
    bne rec

    # print a new line
    ldr x0, =new_line_format
    bl printf

    # load return address
    ldur x30, [sp, 8]

    # reclaim stack space
    add sp, sp, 16
   
    # branch to return address
    br x30


rec:

    # print the byte
    ldr x0, =output_format
    bl printf
    
    # load return address...
    ldur x30, [sp, 8]
    # ...and input string address
    ldur x0, [sp, 0]

    # increment input string address
    add x0, x0, 1

    # recursively branch with link to revstr
    bl revstr
    
    # begin post-return recursive section:

    # load return address...
    ldur x30, [sp, 8]
    # ...and input string address
    ldur x0, [sp, 0]

    # load a byte of the input string (in reverse)
    ldrb w1, [x0, 0]

    # print the byte
    ldr x0, =output_format
    bl printf

    # load return address...
    ldur x30, [sp, 8]
    # ...and input string address
    ldur x0, [sp, 0]

    # reclaim stack space
    add sp, sp, 16

    # branch to return address
    br x30


# branch to this label on program completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret

