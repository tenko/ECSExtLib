; Linux 64bit assembler wrapper for functional calls as currently ECS does not handle float/double arguments

; Call function/procedure : (x : REAL32)[: ARG];
.code _system_call_variant_f
    pop rbx
    movss   xmm0, dword [rsp + 0]
    mov r12, rsp
    and rsp, ~1111b
    call    rax
    mov rsp, r12
    jmp rbx

; Call function/procedure : (x : REAL32; y : REAL32)[: ARG];
.code _system_call_variant_ff
    pop rbx
    movss   xmm0, dword [rsp + 0]
    movss   xmm1, dword [rsp + 8]
    mov r12, rsp
    and rsp, ~1111b
    call    rax
    mov rsp, r12
    jmp rbx
        
; Call function/procedure : (arg : LENGTH; x : REAL32; y : REAL32)[: ARG];
.code _system_call_variant_iff
    pop rbx
    mov rdi, [rsp + 0]
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    mov r12, rsp
    and rsp, ~1111b
    call    rax
    mov rsp, r12
    jmp rbx


; Call function/procedure : (x : REAL64)[: ARG];
.code _system_call_variant_d
    pop rbx
    movsd   xmm0, qword [rsp + 0]
    mov r12, rsp
    and rsp, ~1111b
    call    rax
    mov rsp, r12
    jmp rbx

; Call function/procedure : (x : REAL64; y : REAL64)[: ARG];
.code _system_call_variant_dd
    pop rbx
    movsd   xmm0, qword [rsp + 0]
    movsd   xmm1, qword [rsp + 8]
    mov r12, rsp
    and rsp, ~1111b
    call    rax
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
