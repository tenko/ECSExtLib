.code _winui_onCallback
    push rsp
    push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15
	  call rsi ; call on 2rd argument
	  pop r15
	  pop r14
	  pop r13
	  pop r12
	  pop	rbx
	  pop	rbp
	  pop	rsp
    ret

