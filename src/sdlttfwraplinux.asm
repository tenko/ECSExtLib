; Linux 64bit assembler wrapper for functional calls as currently ECS does not handle callbacks and float/double arguments       
.code TTF_SetTextColorFloat_wrap
    pop rbx
    mov rdi, [rsp + 0]
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    movss   xmm2, dword [rsp + 24]
    movss   xmm3, dword [rsp + 32]
    mov r12, rsp
    and rsp, ~1111b
    call dword @TTF_SetTextColorFloat
    mov rsp, r12
    jmp rbx 
