; Windows 64bit assembler wrapper for functional calls as currently ECS does not handle callbacks and float/double arguments

; Callback iii variant
.code _system_callback_iii
    push rsp
    push rbp
    push rbx
    push rsi
    push rdi
    push r12
    push r13
    push r14
    push r15
    
    push r8
    push rdx
	  call rcx ; call on 1st argument
	  pop rdx
	  pop r8
	  
	  pop r15
	  pop r14
	  pop r13
	  pop r12
	  pop rdi
	  pop rsi
	  pop	rbx
	  pop	rbp
	  pop rsp
    ret

; Call function/procedure : (x : REAL32)[: ARG];
.code _system_call_variant_f
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b
    movss   xmm0, dword [rdi + 0]
    sub rsp, 32
    call rax
    mov rsp, rdi
    jmp rbx

; Call function/procedure : (arg : LENGTH; x : REAL32; y : REAL32)[: ARG];
.code _system_call_variant_iff
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b
    mov rcx, [rdi + 0]
    movss   xmm1, dword [rdi + 8]
    movss   xmm2, dword [rdi + 16]
    sub rsp, 32
    call rax
    mov rsp, rdi
    jmp rbx
        
; Call function/procedure : (x : REAL32; y : REAL32)[: ARG];
.code _system_call_variant_ff
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b
    movss   xmm0, dword [rdi + 0]
    movss   xmm1, dword [rdi + 8]
    sub rsp, 32
    call rax
    mov rsp, rdi
    jmp rbx
        
; Call function/procedure : (x : REAL64)[: ARG];
.code _system_call_variant_d
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b
    movsd   xmm0, qword [rdi + 0]
    sub rsp, 32
    call rax
    mov rsp, rdi
    jmp rbx

; Call function/procedure : (x : REAL64; y : REAL64)[: ARG];
.code _system_call_variant_dd
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b
    movsd   xmm0, qword [rdi + 0]
    movsd   xmm1, qword [rdi + 8]
    sub rsp, 32
    call rax
    mov rsp, rdi
    jmp rbx
    
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
