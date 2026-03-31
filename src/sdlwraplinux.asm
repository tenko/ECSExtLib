; Linux 64bit assembler wrapper for functional calls as currently ECS does not handle callbacks and float/double arguments       
.code SDL_RenderCoordinatesToWindow_wrap
  pop rbx
    mov rdi, [rsp + 0]
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    mov rsi, [rsp + 24]
    mov rdx, [rsp + 32]
    mov r12, rsp
    and rsp, ~1111b
    call dword @SDL_RenderCoordinatesToWindow
    mov rsp, r12
    jmp rbx
    
.code SDL_SetRenderDrawColorFloat_wrap
    pop rbx
    mov rdi, [rsp + 0]
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    movss   xmm2, dword [rsp + 24]
    movss   xmm3, dword [rsp + 32]
    mov r12, rsp
    and rsp, ~1111b
    call dword @SDL_SetRenderDrawColorFloat
    mov rsp, r12
    jmp rbx 

.code SDL_RenderTextureRotated_wrap
    pop rbx
    mov rdi, [rsp + 0]
    mov rsi, [rsp + 8]
    mov rdx, [rsp + 16]
    mov rcx, [rsp + 24]
    movss   xmm0, dword [rsp + 32]
    mov r8, [rsp + 40]
    mov r9, [rsp + 48]
    mov r12, rsp
    and rsp, ~1111b
    call dword @SDL_RenderTextureRotated
    mov rsp, r12
    jmp rbx

.code SDL_SetTextureColorModFloat_wrap
    pop rbx
    mov rdi, [rsp + 0]
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    movss   xmm2, dword [rsp + 24]
    mov r12, rsp
    and rsp, ~1111b
    call dword @SDL_SetTextureColorModFloat
    mov rsp, r12
    jmp rbx

.code SDL_RenderLine_wrap
    pop rbx
    mov rdi, [rsp + 0]
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    movss   xmm2, dword [rsp + 24]
    movss   xmm3, dword [rsp + 32]
    mov r12, rsp
    and rsp, ~1111b
    call dword @SDL_RenderLine
    mov rsp, r12
    jmp rbx

.code SDL_RenderDebugText_wrap
    pop rbx
    mov rdi, [rsp + 0]
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    mov rsi, [rsp + 24]
    mov r12, rsp
    and rsp, ~1111b
    call dword @SDL_RenderDebugText
    mov rsp, r12
    jmp rbx
