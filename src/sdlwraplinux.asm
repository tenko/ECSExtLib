; Linux 64bit assembler wrapper for functional calls as currently ECS does not handle float/double arguments

.code SDL_SetRenderScale_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    jmp	dword @SDL_SetRenderScale
    ret
    
.code SDL_SetRenderDrawColorFloat_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    movss   xmm2, dword [rsp + 32]
    mov	rsi, [rsp + 40]
    jmp	dword @SDL_SetRenderDrawColorFloat
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
    ret

.code SDL_SetTextureColorModFloat_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    movss   xmm2, dword [rsp + 32]
    mov	rsi, [rsp + 40]
    jmp	dword @SDL_SetTextureColorModFloat
    ret
     
.code SDL_RenderLine_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    movss   xmm2, dword [rsp + 32]
    movss   xmm3, dword [rsp + 40]
    jmp	dword @SDL_RenderLine
    ret
    
.code SDL_RenderPoint_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    jmp	dword @SDL_RenderPoint
    ret

.code SDL_RenderDebugText_wrap
    mov	rdi, [rsp + 8]
    movss   xmm0, dword [rsp + 16]
    movss   xmm1, dword [rsp + 24]
    mov	rsi, [rsp + 32]
    jmp	dword @SDL_RenderDebugText
    ret
    
.code SDL_randf_wrap
    jmp	dword @SDL_randf
    ret

.code SDL_acos_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_acos
    ret

.code SDL_acosf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_acosf
    ret

.code SDL_asin_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_asin
    ret

.code SDL_asinf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_asinf
    ret

.code SDL_atan_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_atan
    ret

.code SDL_atanf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_atanf
    ret

.code SDL_atan2_wrap
    movsd   xmm0, qword [rsp + 8]
    movsd   xmm1, qword [rsp + 16]
    jmp	dword @SDL_atan2
    ret

.code SDL_atan2f_wrap
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    jmp	dword @SDL_atan2f
    ret

.code SDL_ceil_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_ceil
    ret

.code SDL_ceilf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_ceilf
    ret

.code SDL_copysign_wrap
    movsd   xmm0, qword [rsp + 8]
    movsd   xmm1, qword [rsp + 16]
    jmp	dword @SDL_copysign
    ret

.code SDL_copysignf_wrap
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    jmp	dword @SDL_copysignf
    ret
     
.code SDL_cos_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_cos
    ret

.code SDL_cosf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_cosf
    ret

.code SDL_exp_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_exp
    ret

.code SDL_expf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_expf
    ret

.code SDL_fabs_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_fabs
    ret

.code SDL_fabsf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_fabsf
    ret

.code SDL_floor_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_floor
    ret

.code SDL_floorf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_floorf
    ret

.code SDL_trunc_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_trunc
    ret

.code SDL_truncf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_truncf
    ret

.code SDL_fmod_wrap
    movsd   xmm0, qword [rsp + 8]
    movsd   xmm1, qword [rsp + 16]
    jmp	dword @SDL_fmod
    ret

.code SDL_fmodf_wrap
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    jmp	dword @SDL_fmodf
    ret

.code SDL_isinf_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_isinf
    mov   [rsp + 8], rax
    ret

.code SDL_isinff_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_isinff
    ret

.code SDL_isnan_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_isnan
    mov   [rsp + 8], rax
    ret

.code SDL_isnanf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_isnanf
    ret
    
.code SDL_log_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_log
    ret

.code SDL_logf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_logf
    ret

.code SDL_log10_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_log10
    ret

.code SDL_log10f_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_log10f
    ret

.code SDL_pow_wrap
    movsd   xmm0, qword [rsp + 8]
    movsd   xmm1, qword [rsp + 16]
    jmp	dword @SDL_pow
    ret

.code SDL_powf_wrap
    movss   xmm0, dword [rsp + 8]
    movss   xmm1, dword [rsp + 16]
    jmp	dword @SDL_powf
    ret

.code SDL_round_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_round
    ret

.code SDL_roundf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_roundf
    ret
             
.code SDL_sin_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_sin
    ret

.code SDL_sinf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_sinf
    ret

.code SDL_sqrt_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_sqrt
    ret

.code SDL_sqrtf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_sqrtf
    ret

.code SDL_tan_wrap
    movsd   xmm0, qword [rsp + 8]
    jmp	dword @SDL_tan
    ret

.code SDL_tanf_wrap
    movss   xmm0, dword [rsp + 8]
    jmp	dword @SDL_tanf
    ret
    