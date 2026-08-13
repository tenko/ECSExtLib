; Linux 64bit assembler wrapper for functional calls as currently ECS does not handle callbacks and float/double arguments

; Callback iii variant
.code _system_callback_iii
  .default
    push rsp
    push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15
    
    push rdx
    push rsi
	  call rdi ; call on 1st argument
	  pop rsi
	  pop rdx
	  
	  pop r15
	  pop r14
	  pop r13
	  pop r12
	  pop	rbx
	  pop	rbp
	  pop	rsp
	  
    ret

; Call function/procedure : (x : REAL32)[: ARG];
.code _system_call_variant_f
  .default
    pop rbx
    movss   xmm0, dword [rsp + 0]
    mov r12, rsp
    and rsp, ~1111b
    call    rax
    mov rsp, r12
    jmp rbx

; Call function/procedure : (arg : LENGTH; x : REAL32)[: ARG];
.code _system_call_variant_if
  .default
    pop rbx
    mov rdi, [rsp + 0]
    movss   xmm0, dword [rsp + 8]
    mov r12, rsp
    and rsp, ~1111b
    call    rax
    mov rsp, r12
    jmp rbx
    
; Call function/procedure : (x : REAL32; y : REAL32)[: ARG];
.code _system_call_variant_ff
  .default
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
  .default
    pop rbx
    mov rdi, [rsp + 0]
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    mov r12, rsp
    and rsp, ~1111b
    call    rax
    mov rsp, r12
    jmp rbx


; Call function/procedure : (arg1: LENGTH; arg2 : LENGTH; x : REAL32)[: ARG];
.code _system_call_variant_iif
  .default
    pop rbx
    mov rdi, [rsp + 0]
    mov rsi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    mov r12, rsp
    and rsp, ~1111b
    call    rax
    mov rsp, r12
    jmp rbx
    
; Call function/procedure : (x : REAL64)[: ARG];
.code _system_call_variant_d
  .default
    pop rbx
    movsd   xmm0, qword [rsp + 0]
    mov r12, rsp
    and rsp, ~1111b
    call    rax
    mov rsp, r12
    jmp rbx

; Call function/procedure : (x : REAL64; y : REAL64)[: ARG];
.code _system_call_variant_dd
  .default
    pop rbx
    movsd   xmm0, qword [rsp + 0]
    movsd   xmm1, qword [rsp + 8]
    mov r12, rsp
    and rsp, ~1111b
    call    rax
    mov rsp, r12
    jmp rbx
