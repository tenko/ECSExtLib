; Windows 64bit assembler wrapper for functional calls as currently ECS does not handle callbacks and float/double arguments

; Callback iii variant
.code _system_callback_iii
  .duplicable
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
  .duplicable
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b
    movss   xmm0, dword [rdi + 0]
    sub rsp, 32
    call rax
    mov rsp, rdi
    jmp rbx

; Call function/procedure : (arg : LENGTH; x : REAL32)[: ARG];
.code _system_call_variant_if
  .duplicable
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b
    mov rcx, [rdi + 0]
    movss   xmm1, dword [rdi + 8]
    sub rsp, 32
    call rax
    mov rsp, rdi
    jmp rbx
    
; Call function/procedure : (arg : LENGTH; x : REAL32; y : REAL32)[: ARG];
.code _system_call_variant_iff
  .duplicable
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

; Call function/procedure : (arg1: LENGTH; arg2 : LENGTH; x : REAL32)[: ARG];
.code _system_call_variant_iif
  .duplicable
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b
    mov rcx, [rdi + 0]
    mov rdx, [rdi + 8]
    movss   xmm2, dword [rdi + 16]
    sub rsp, 32
    call rax
    mov rsp, rdi
    jmp rbx
     
; Call function/procedure : (x : REAL32; y : REAL32)[: ARG];
.code _system_call_variant_ff
  .duplicable
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
  .duplicable
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
  .duplicable
    pop rbx
    mov rdi, rsp
    and rsp, ~1111b
    movsd   xmm0, qword [rdi + 0]
    movsd   xmm1, qword [rdi + 8]
    sub rsp, 32
    call rax
    mov rsp, rdi
    jmp rbx
