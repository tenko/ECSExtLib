; Linux 64bit assembler wrapper for functional calls as currently ECS does not handle float/double arguments

.code SDL_SetRenderScale_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    jmp	dword @SDL_SetRenderScale
    mov  [rsp + 8], rax
    ret
    
.code SDL_SetRenderDrawColorFloat_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    movss   xmm2, dword [rsp + 32]
    mov	rsi, [rsp + 40]
    jmp	dword @SDL_SetRenderDrawColorFloat
    mov  [rsp + 8], rax
    ret

.code SDL_RenderTextureRotated_wrap
    mov	rdi, [rsp + 8]
    mov	rsi, [rsp + 16]
    mov	rdx, [rsp + 24]
    mov	rcx, [rsp + 32]
	movsd   xmm0, qword [rsp + 40]
    mov	r8, [rsp + 48]
    mov	r9, [rsp + 56]
	jmp	dword @SDL_RenderTextureRotated
	mov  [rsp + 8], rax
    ret

.code SDL_SetTextureColorModFloat_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    movss   xmm2, dword [rsp + 32]
    mov	rsi, [rsp + 40]
    jmp	dword @SDL_SetTextureColorModFloat
    mov [rsp + 8], rax
    ret
     
.code SDL_RenderLine_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    movss   xmm2, dword [rsp + 32]
    movss   xmm3, dword [rsp + 40]
    jmp	dword @SDL_RenderLine
    mov  [rsp + 8], rax
    ret
    
.code SDL_RenderPoint_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    jmp	dword @SDL_RenderPoint
    mov  [rsp + 8], rax
    ret

.code SDL_RenderDebugText_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    mov	rsi, [rsp + 32]
    jmp	dword @SDL_RenderDebugText
    mov  [rsp + 8], rax
    ret
    
.code SDL_randf_wrap
    jmp	dword @SDL_randf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_acos_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_acos
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_acosf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_acosf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_asin_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_asin
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_asinf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_asinf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_atan_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_atan
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_atanf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_atanf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_atan2_wrap
    movsd   xmm0, qword [rsp + 8]
    movsd   xmm1, qword [rsp + 16]
    jmp	dword @SDL_atan2
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_atan2f_wrap
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    jmp	dword @SDL_atan2f
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_ceil_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_ceil
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_ceilf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_ceilf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_copysign_wrap
    movsd   xmm0, qword [rsp + 8]
    movsd   xmm1, qword [rsp + 16]
    jmp	dword @SDL_copysign
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_copysignf_wrap
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    jmp	dword @SDL_copysignf
    movss   dword [rsp + 8], xmm0
    ret
     
.code SDL_cos_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_cos
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_cosf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_cosf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_exp_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_exp
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_expf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_expf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_fabs_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_fabs
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_fabsf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_fabsf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_floor_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_floor
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_floorf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_floorf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_trunc_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_trunc
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_truncf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_truncf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_fmod_wrap
    movsd   xmm0, qword [rsp + 8]
    movsd   xmm1, qword [rsp + 16]
    jmp	dword @SDL_fmod
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_fmodf_wrap
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    jmp	dword @SDL_fmodf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_isinf_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_isinf
    mov   [rsp + 8], rax
    ret

.code SDL_isinff_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_isinff
    mov  [rsp + 8], rax
    ret

.code SDL_isnan_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_isnan
    mov   [rsp + 8], rax
    ret

.code SDL_isnanf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_isnanf
    mov  [rsp + 8], rax
    ret
    
.code SDL_log_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_log
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_logf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_logf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_log10_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_log10
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_log10f_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_log10f
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_pow_wrap
    movsd   xmm0, qword [rsp + 8]
    movsd   xmm1, qword [rsp + 16]
    jmp	dword @SDL_pow
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_powf_wrap
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    jmp	dword @SDL_powf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_round_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_round
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_roundf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_roundf
    movss   dword [rsp + 8], xmm0
    ret
             
.code SDL_sin_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_sin
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_sinf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_sinf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_sqrt_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_sqrt
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_sqrtf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_sqrtf
    movss   dword [rsp + 8], xmm0
    ret

.code SDL_tan_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_tan
    movsd   qword [rsp + 8], xmm0
    ret

.code SDL_tanf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_tanf
    movss   dword [rsp + 8], xmm0
    ret
    