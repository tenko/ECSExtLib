; Windows 64bit assembler wrapper for functional calls as currently ECS does not handle callbacks and float/double arguments
.code TTF_SetTextColorFloat_wrap
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b
    sub rsp, 8

    mov rcx, [rdi + 0]
    movss   xmm1, dword [rdi + 8]
    movss   xmm2, dword [rdi + 16]
    movss   xmm3, dword [rdi + 24]
    push qword [rdi + 32]

    sub rsp, 32
    call dword @TTF_SetTextColorFloat
    mov rsp, rdi
    jmp rbx