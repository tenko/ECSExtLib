.code _winui_onCallback
    push rbp
    push rbx
    push rsi
    push rdi
    push r12
    push r13
    push r14
    push r15
    sub rsp, 20
	  call rdx ; call on 2rd argument
	  add rsp, 20
	  pop r15
	  pop r14
	  pop r13
	  pop r12
	  pop rdi
	  pop rsi
	  pop	rbx
	  pop	rbp
    ret