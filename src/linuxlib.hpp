// Linux library support
// Copyright (C) Florian Negele

#include <def/assembly>


#if defined __amd64__
    
    #define FUNCTIONVAR(library, name, variant) asm ( \
	CONST (_##name##_symbol) SHARED GROUP (_symbol_table) REQUIRE (_dynamic_section_##library) ALIGNMENT (ADDRSIZE) SYMBOL_TABLE_ENTRY (position (@_##name##_string) + 1, 0, 0, STB_GLOBAL << 4 | STT_FUNC, STV_DEFAULT, 0) \
	CONST (_##name##_string) SHARED GROUP (_string_table) BYTE (#name, 0) \
	CONST (_##name##_relocation) SHARED GROUP (_relocation_table) ALIGNMENT (ADDRSIZE) RELOCATION_TABLE_ENTRY (@_##name, R_TYPE, index (@_##name##_symbol) + 1, 0) \
	CONST (_##name) SHARED REQUIRE (_##name##_relocation) ALIGNMENT (ADDRSIZE) RESERVE (ADDRSIZE) \
	CODE (name) SHARED \
	INSTR (mov rax, [rip + @_##name ]) \
	INSTR (jmp dword @_system_call_variant_##variant) \
	);
	
    #define FUNCTIONRAW(library, name) asm ( \
	CONST (_##name##_symbol) SHARED GROUP (_symbol_table) REQUIRE (_dynamic_section_##library) ALIGNMENT (ADDRSIZE) SYMBOL_TABLE_ENTRY (position (@_##name##_string) + 1, 0, 0, STB_GLOBAL << 4 | STT_FUNC, STV_DEFAULT, 0) \
	CONST (_##name##_string) SHARED GROUP (_string_table) BYTE (#name, 0) \
	CONST (_##name##_relocation) SHARED GROUP (_relocation_table) ALIGNMENT (ADDRSIZE) RELOCATION_TABLE_ENTRY (@_##name, R_TYPE, index (@_##name##_symbol) + 1, 0) \
	CONST (_##name) SHARED REQUIRE (_##name##_relocation) ALIGNMENT (ADDRSIZE) RESERVE (ADDRSIZE) \
	CODE (name) SHARED \
	INSTR (mov rax, [rip + @_##name ]) \
	INSTR (jmp rax) \
	);
	
#else

	#error platform not supported

#endif
