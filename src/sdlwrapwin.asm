; Windows 64bit assembler wrapper for functional calls as currently ECS does not handle callbacks and float/double arguments
.code SDL_SetRenderDrawColorFloat_wrap
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
    call dword @SDL_SetRenderDrawColorFloat
    mov rsp, rdi
    jmp rbx

.code SDL_RenderTextureRotated_wrap
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b
    sub rsp, 8

    mov rcx, [rdi + 0]
    mov rdx, [rdi + 8]
    mov r8, [rdi + 16]
    mov r9, [rdi + 24]
    push qword [rdi + 32]
    push qword [rdi + 40]
    push qword [rdi + 48]

    sub rsp, 32
    call dword @SDL_RenderTextureRotated
    mov rsp, rdi
    jmp rbx

.code SDL_SetTextureColorModFloat_wrap  
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
    call dword @SDL_SetTextureColorModFloat
    mov rsp, rdi
    jmp rbx
     
.code SDL_RenderLine_wrap
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
    call dword @SDL_RenderLine
    mov rsp, rdi
    jmp rbx

.code SDL_RenderDebugText_wrap
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b

    mov rcx, [rdi + 0]
    movss   xmm1, dword [rdi + 8]
    movss   xmm2, dword [rdi + 16]
    mov r9, [rdi + 24]

    sub rsp, 32
    call dword @SDL_RenderDebugText
    mov rsp, rdi
    jmp rbx
