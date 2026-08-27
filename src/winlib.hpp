// Windows library support
// Copyright (C) Florian Negele

#if defined __amd64__
    
    #define FUNCTIONVAR(library, name, variant) asm ( \
	CONST (_##name) SHARED GROUP (_##library##_imports) REQUIRE (_##library##_sentinel) ALIGNMENT (IMAGE_THUNK_DATA_SIZE) IMAGE_THUNK_DATA (@_##name##_hint - BASE) \
	CONST (_##name##_hint) SHARED ALIGNMENT (2) IMAGE_IMPORT_BY_NAME (0, #name) \
	CODE (name) SHARED \
	INSTR (mov rax, [rip + @_##name ]) \
	INSTR (jmp dword @_system_call_variant_##variant) \
	);
	
    #define FUNCTIONRAW(library, name) asm ( \
	CONST (_##name) SHARED GROUP (_##library##_imports) REQUIRE (_##library##_sentinel) ALIGNMENT (IMAGE_THUNK_DATA_SIZE) IMAGE_THUNK_DATA (@_##name##_hint - BASE) \
	CONST (_##name##_hint) SHARED ALIGNMENT (2) IMAGE_IMPORT_BY_NAME (0, #name) \
	CODE (name) SHARED \
	INSTR (mov rax, [rip + @_##name ]) \
	INSTR (jmp rax) \
	);
	
#else

	#error platform not supported

#endif