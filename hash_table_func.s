	.file	"hash_table_func.cpp"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"size_t find_word_in_table(char*, size_t, hash_table*)"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"hash_table_func.cpp"
.LC2:
	.string	"word"
.LC3:
	.string	"table"
.LC4:
	.string	"table->arr"
.LC5:
	.string	"!(key >= NUM_LISTS)"
	.text
	.p2align 4
	.globl	_Z18find_word_in_tablePcmP10hash_table
	.type	_Z18find_word_in_tablePcmP10hash_table, @function
_Z18find_word_in_tablePcmP10hash_table:
.LFB95:
	.cfi_startproc
	endbr64
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	test	rdi, rdi
	je	.L18
	test	rdx, rdx
	je	.L19
	mov	rax, QWORD PTR 8[rdx]
	test	rax, rax
	je	.L20
	cmp	rsi, 1023
	ja	.L21
	sal	rsi, 5
	mov	rbx, QWORD PTR [rax+rsi]
	test	rbx, rbx
	je	.L6
	mov	rbp, rdi
	xor	r12d, r12d
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L22:
	mov	rbx, QWORD PTR 16[rbx]
	test	rbx, rbx
	je	.L6
.L8:
	mov	rdi, QWORD PTR [rbx]
	mov	rsi, rbp
	add	r12, 1
	call	r_strcmp@PLT
	test	rax, rax
	jne	.L22
	mov	rax, r12
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L6:
	.cfi_restore_state
	xor	r12d, r12d
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	mov	rax, r12
	pop	r12
	.cfi_def_cfa_offset 8
	ret
.L18:
	.cfi_restore_state
	lea	rcx, .LC0[rip]
	mov	edx, 109
	lea	rsi, .LC1[rip]
	lea	rdi, .LC2[rip]
	call	__assert_fail@PLT
.L21:
	lea	rcx, .LC0[rip]
	mov	edx, 112
	lea	rsi, .LC1[rip]
	lea	rdi, .LC5[rip]
	call	__assert_fail@PLT
.L20:
	lea	rcx, .LC0[rip]
	mov	edx, 111
	lea	rsi, .LC1[rip]
	lea	rdi, .LC4[rip]
	call	__assert_fail@PLT
.L19:
	lea	rcx, .LC0[rip]
	mov	edx, 110
	lea	rsi, .LC1[rip]
	lea	rdi, .LC3[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE95:
	.size	_Z18find_word_in_tablePcmP10hash_table, .-_Z18find_word_in_tablePcmP10hash_table
	.section	.rodata.str1.8
	.align 8
.LC6:
	.string	"size_t find_text_in_table(find_info*, hash_table*, text*, size_t (*)(void*, size_t))"
	.section	.rodata.str1.1
.LC7:
	.string	"arr_word_pos"
.LC8:
	.string	"buffer"
.LC9:
	.string	"hash_func"
.LC10:
	.string	"buffer->words"
.LC11:
	.string	"WORD NOT FOUND TEXT_FIND"
	.text
	.p2align 4
	.globl	_Z18find_text_in_tableP9find_infoP10hash_tableP4textPFmPvmE
	.type	_Z18find_text_in_tableP9find_infoP10hash_tableP4textPFmPvmE, @function
_Z18find_text_in_tableP9find_infoP10hash_tableP4textPFmPvmE:
.LFB94:
	.cfi_startproc
	endbr64
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 8
	.cfi_def_cfa_offset 48
	test	rdi, rdi
	je	.L35
	mov	rbp, rsi
	test	rsi, rsi
	je	.L36
	mov	r12, rdx
	test	rdx, rdx
	je	.L37
	test	rcx, rcx
	je	.L38
	mov	rax, QWORD PTR 16[rdx]
	test	rax, rax
	je	.L39
	cmp	QWORD PTR 24[rdx], 0
	je	.L29
	mov	r13, rdi
	xor	ebx, ebx
	jmp	.L32
	.p2align 4,,10
	.p2align 3
.L30:
	add	rbx, 1
	cmp	QWORD PTR 24[r12], rbx
	jbe	.L29
	mov	rax, QWORD PTR 16[r12]
.L32:
	mov	rdx, rbx
	sal	rdx, 4
	mov	rdi, QWORD PTR [rax+rdx]
	mov	rdx, rbp
#APP
# 28 "hash_table_func.cpp" 1
	mov eax, 0xFFFFFFFF
	1:
	cmp byte ptr [rdi], 0
	je 2
	movzx r10d, byte ptr [rdi]
	crc32 eax, r10b
	inc rdi
	jmp 1
	2:
	not eax
	
# 0 "" 2
#NO_APP
	and	eax, 1023
	mov	DWORD PTR 0[r13+rbx*8], eax
	mov	rsi, rax
	call	_Z18find_word_in_tablePcmP10hash_table
	mov	DWORD PTR 4[r13+rbx*8], eax
	test	eax, eax
	jne	.L30
	lea	rdi, .LC11[rip]
	call	perror@PLT
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	mov	eax, 5
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L29:
	.cfi_restore_state
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
.L39:
	.cfi_restore_state
	lea	rcx, .LC6[rip]
	mov	edx, 79
	lea	rsi, .LC1[rip]
	lea	rdi, .LC10[rip]
	call	__assert_fail@PLT
.L38:
	lea	rcx, .LC6[rip]
	mov	edx, 78
	lea	rsi, .LC1[rip]
	lea	rdi, .LC9[rip]
	call	__assert_fail@PLT
.L37:
	lea	rcx, .LC6[rip]
	mov	edx, 77
	lea	rsi, .LC1[rip]
	lea	rdi, .LC8[rip]
	call	__assert_fail@PLT
.L36:
	lea	rcx, .LC6[rip]
	mov	edx, 76
	lea	rsi, .LC1[rip]
	lea	rdi, .LC3[rip]
	call	__assert_fail@PLT
.L35:
	lea	rcx, .LC6[rip]
	mov	edx, 75
	lea	rsi, .LC1[rip]
	lea	rdi, .LC7[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE94:
	.size	_Z18find_text_in_tableP9find_infoP10hash_tableP4textPFmPvmE, .-_Z18find_text_in_tableP9find_infoP10hash_tableP4textPFmPvmE
	.section	.rodata.str1.8
	.align 8
.LC12:
	.string	"void print_in_file(hash_table*, FILE*)"
	.section	.rodata.str1.1
.LC13:
	.string	"csv"
.LC14:
	.string	" %ld;%ld\n"
	.text
	.p2align 4
	.globl	_Z13print_in_fileP10hash_tableP8_IO_FILE
	.type	_Z13print_in_fileP10hash_tableP8_IO_FILE, @function
_Z13print_in_fileP10hash_tableP8_IO_FILE:
.LFB96:
	.cfi_startproc
	endbr64
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 8
	.cfi_def_cfa_offset 48
	test	rdi, rdi
	je	.L48
	mov	rax, QWORD PTR 8[rdi]
	mov	rbp, rdi
	test	rax, rax
	je	.L49
	mov	r12, rsi
	test	rsi, rsi
	je	.L50
	cmp	QWORD PTR [rdi], 0
	je	.L46
	xor	ebx, ebx
	lea	r13, .LC14[rip]
	jmp	.L45
	.p2align 4,,10
	.p2align 3
.L51:
	mov	rax, QWORD PTR 8[rbp]
.L45:
	mov	rdx, rbx
	mov	rcx, rbx
	mov	esi, 1
	mov	rdi, r12
	sal	rdx, 5
	add	rbx, 1
	mov	r8, QWORD PTR 16[rax+rdx]
	mov	rdx, r13
	xor	eax, eax
	call	__fprintf_chk@PLT
	cmp	QWORD PTR 0[rbp], rbx
	ja	.L51
.L46:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
.L48:
	.cfi_restore_state
	lea	rcx, .LC12[rip]
	mov	edx, 144
	lea	rsi, .LC1[rip]
	lea	rdi, .LC3[rip]
	call	__assert_fail@PLT
.L50:
	lea	rcx, .LC12[rip]
	mov	edx, 146
	lea	rsi, .LC1[rip]
	lea	rdi, .LC13[rip]
	call	__assert_fail@PLT
.L49:
	lea	rcx, .LC12[rip]
	mov	edx, 145
	lea	rsi, .LC1[rip]
	lea	rdi, .LC4[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE96:
	.size	_Z13print_in_fileP10hash_tableP8_IO_FILE, .-_Z13print_in_fileP10hash_tableP8_IO_FILE
	.section	.rodata.str1.8
	.align 8
.LC15:
	.string	"size_t insert_in_list(hash_table*, size_t, char*)"
	.section	.rodata.str1.1
.LC16:
	.string	"MEM ALLOC TROUBLE"
	.text
	.p2align 4
	.globl	_Z14insert_in_listP10hash_tablemPc
	.type	_Z14insert_in_listP10hash_tablemPc, @function
_Z14insert_in_listP10hash_tablemPc:
.LFB97:
	.cfi_startproc
	endbr64
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	test	rdi, rdi
	je	.L61
	mov	r12, rdx
	test	rdx, rdx
	je	.L62
	mov	rbx, rsi
	cmp	rsi, 1023
	ja	.L63
	mov	rbp, rdi
	mov	esi, 32
	mov	edi, 1
	call	calloc@PLT
	test	rax, rax
	je	.L64
	sal	rbx, 5
	add	rbx, QWORD PTR 8[rbp]
	mov	QWORD PTR [rax], r12
	mov	rdx, QWORD PTR [rbx]
	mov	QWORD PTR 24[rax], 0
	add	QWORD PTR 16[rbx], 1
	test	rdx, rdx
	je	.L65
	mov	QWORD PTR 16[rax], rdx
	mov	QWORD PTR 24[rdx], rax
	mov	QWORD PTR [rbx], rax
	xor	eax, eax
.L59:
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L65:
	.cfi_restore_state
	mov	QWORD PTR [rbx], rax
	mov	QWORD PTR 8[rbx], rax
	mov	QWORD PTR 16[rax], 0
	xor	eax, eax
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
.L64:
	.cfi_restore_state
	lea	rdi, .LC16[rip]
	call	perror@PLT
	mov	eax, 1
	jmp	.L59
.L63:
	lea	rcx, .LC15[rip]
	mov	edx, 161
	lea	rsi, .LC1[rip]
	lea	rdi, .LC5[rip]
	call	__assert_fail@PLT
.L62:
	lea	rcx, .LC15[rip]
	mov	edx, 160
	lea	rsi, .LC1[rip]
	lea	rdi, .LC2[rip]
	call	__assert_fail@PLT
.L61:
	lea	rcx, .LC15[rip]
	mov	edx, 159
	lea	rsi, .LC1[rip]
	lea	rdi, .LC3[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE97:
	.size	_Z14insert_in_listP10hash_tablemPc, .-_Z14insert_in_listP10hash_tablemPc
	.section	.rodata.str1.8
	.align 8
.LC17:
	.string	"size_t hash_table_fill(hash_table*, text*, size_t (*)(void*, size_t))"
	.text
	.p2align 4
	.globl	_Z15hash_table_fillP10hash_tableP4textPFmPvmE
	.type	_Z15hash_table_fillP10hash_tableP4textPFmPvmE, @function
_Z15hash_table_fillP10hash_tableP4textPFmPvmE:
.LFB98:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	test	rdi, rdi
	je	.L80
	mov	r12, rsi
	test	rsi, rsi
	je	.L81
	mov	rax, QWORD PTR 16[rsi]
	test	rax, rax
	je	.L82
	test	rdx, rdx
	je	.L83
	cmp	QWORD PTR 24[rsi], 0
	je	.L71
	mov	r13, rdi
	xor	ebx, ebx
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L75:
	add	rbx, 1
	cmp	QWORD PTR 24[r12], rbx
	jbe	.L71
	mov	rax, QWORD PTR 16[r12]
.L76:
	mov	r14, rbx
	mov	rdx, r13
	sal	r14, 4
	mov	rdi, QWORD PTR [rax+r14]
#APP
# 28 "hash_table_func.cpp" 1
	mov eax, 0xFFFFFFFF
	1:
	cmp byte ptr [rdi], 0
	je 2
	movzx r10d, byte ptr [rdi]
	crc32 eax, r10b
	inc rdi
	jmp 1
	2:
	not eax
	
# 0 "" 2
#NO_APP
	and	eax, 1023
	mov	rsi, rax
	mov	rbp, rax
	call	_Z18find_word_in_tablePcmP10hash_table
	test	rax, rax
	jne	.L75
	mov	rax, QWORD PTR 16[r12]
	mov	rsi, rbp
	mov	rdi, r13
	mov	rdx, QWORD PTR [rax+r14]
	call	_Z14insert_in_listP10hash_tablemPc
	test	rax, rax
	je	.L75
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L71:
	.cfi_restore_state
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	xor	eax, eax
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
.L80:
	.cfi_restore_state
	lea	rcx, .LC17[rip]
	mov	edx, 189
	lea	rsi, .LC1[rip]
	lea	rdi, .LC3[rip]
	call	__assert_fail@PLT
.L83:
	lea	rcx, .LC17[rip]
	mov	edx, 192
	lea	rsi, .LC1[rip]
	lea	rdi, .LC9[rip]
	call	__assert_fail@PLT
.L82:
	lea	rcx, .LC17[rip]
	mov	edx, 191
	lea	rsi, .LC1[rip]
	lea	rdi, .LC10[rip]
	call	__assert_fail@PLT
.L81:
	lea	rcx, .LC17[rip]
	mov	edx, 190
	lea	rsi, .LC1[rip]
	lea	rdi, .LC8[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE98:
	.size	_Z15hash_table_fillP10hash_tableP4textPFmPvmE, .-_Z15hash_table_fillP10hash_tableP4textPFmPvmE
	.section	.rodata.str1.1
.LC18:
	.string	"size_t words_arr_fill(text*)"
.LC19:
	.string	"buffer != nullptr"
.LC20:
	.string	"buffer->buff != nullptr"
.LC21:
	.string	"ENCODING ERROR"
	.text
	.p2align 4
	.globl	_Z14words_arr_fillP4text
	.type	_Z14words_arr_fillP4text, @function
_Z14words_arr_fillP4text:
.LFB99:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	test	rdi, rdi
	je	.L99
	mov	r12, QWORD PTR 8[rdi]
	mov	r14, rdi
	test	r12, r12
	je	.L100
	mov	QWORD PTR 24[rdi], 0
	mov	esi, 13
	mov	rdi, r12
	xor	r13d, r13d
	call	strchr@PLT
	test	rax, rax
	jne	.L101
	.p2align 4,,10
	.p2align 3
.L87:
	movsx	edi, BYTE PTR [r12]
	call	isalnum@PLT
	test	eax, eax
	je	.L89
.L102:
	mov	rbx, r12
	.p2align 4,,10
	.p2align 3
.L90:
	mov	rbp, rbx
	movsx	edi, BYTE PTR 1[rbx]
	add	rbx, 1
	call	isalnum@PLT
	test	eax, eax
	jne	.L90
	mov	rax, r13
	mov	rdx, rbx
	add	r13, 1
	sal	rax, 4
	sub	rdx, r12
	add	rax, QWORD PTR 16[r14]
	mov	QWORD PTR [rax], r12
	mov	QWORD PTR 8[rax], rdx
	mov	QWORD PTR 24[r14], r13
	cmp	BYTE PTR [rbx], 0
	je	.L93
	mov	BYTE PTR [rbx], 0
	movsx	edi, BYTE PTR 2[rbp]
	lea	r12, 2[rbp]
	mov	r13, QWORD PTR 24[r14]
	call	isalnum@PLT
	test	eax, eax
	jne	.L102
.L89:
	add	r12, 1
	jmp	.L87
	.p2align 4,,10
	.p2align 3
.L93:
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	xor	eax, eax
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
.L101:
	.cfi_restore_state
	lea	rdi, .LC21[rip]
	call	perror@PLT
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	mov	eax, 6
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
.L100:
	.cfi_restore_state
	lea	rcx, .LC18[rip]
	mov	edx, 221
	lea	rsi, .LC1[rip]
	lea	rdi, .LC20[rip]
	call	__assert_fail@PLT
.L99:
	lea	rcx, .LC18[rip]
	mov	edx, 220
	lea	rsi, .LC1[rip]
	lea	rdi, .LC19[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE99:
	.size	_Z14words_arr_fillP4text, .-_Z14words_arr_fillP4text
	.section	.rodata.str1.1
.LC22:
	.string	"MEMMORY ALLOC TRUBLE"
	.text
	.p2align 4
	.globl	_Z4ctorv
	.type	_Z4ctorv, @function
_Z4ctorv:
.LFB101:
	.cfi_startproc
	endbr64
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	mov	esi, 16
	mov	edi, 1
	call	calloc@PLT
	mov	esi, 32
	mov	edi, 1024
	mov	QWORD PTR [rax], 1024
	mov	r12, rax
	call	calloc@PLT
	mov	QWORD PTR 8[r12], rax
	test	rax, rax
	je	.L106
.L103:
	mov	rax, r12
	pop	r12
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L106:
	.cfi_restore_state
	lea	rdi, .LC22[rip]
	xor	r12d, r12d
	call	perror@PLT
	jmp	.L103
	.cfi_endproc
.LFE101:
	.size	_Z4ctorv, .-_Z4ctorv
	.section	.rodata.str1.1
.LC23:
	.string	"void clear(hash_table*)"
	.text
	.p2align 4
	.globl	_Z5clearP10hash_table
	.type	_Z5clearP10hash_table, @function
_Z5clearP10hash_table:
.LFB103:
	.cfi_startproc
	endbr64
	push	r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	push	r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	push	rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 8
	.cfi_def_cfa_offset 48
	test	rdi, rdi
	je	.L118
	cmp	QWORD PTR [rdi], 0
	mov	r13, rdi
	je	.L116
	mov	rax, QWORD PTR 8[rdi]
	xor	r12d, r12d
	.p2align 4,,10
	.p2align 3
.L113:
	mov	rbx, r12
	sal	rbx, 5
	add	rax, rbx
	mov	rbp, QWORD PTR 8[rax]
	cmp	rbp, QWORD PTR [rax]
	je	.L110
	.p2align 4,,10
	.p2align 3
.L111:
	mov	rdi, rbp
	mov	rbp, QWORD PTR 24[rbp]
	call	free@PLT
	mov	rax, QWORD PTR 8[r13]
	cmp	QWORD PTR [rax+rbx], rbp
	jne	.L111
.L110:
	mov	rdi, rbp
	add	r12, 1
	call	free@PLT
	mov	rax, QWORD PTR 8[r13]
	add	rbx, rax
	mov	QWORD PTR [rbx], 0
	mov	QWORD PTR 8[rbx], 0
	mov	QWORD PTR 16[rbx], 0
	cmp	QWORD PTR 0[r13], r12
	ja	.L113
.L116:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	rbp
	.cfi_def_cfa_offset 24
	pop	r12
	.cfi_def_cfa_offset 16
	pop	r13
	.cfi_def_cfa_offset 8
	ret
.L118:
	.cfi_restore_state
	lea	rcx, .LC23[rip]
	mov	edx, 324
	lea	rsi, .LC1[rip]
	lea	rdi, .LC3[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE103:
	.size	_Z5clearP10hash_table, .-_Z5clearP10hash_table
	.section	.rodata.str1.1
.LC24:
	.string	"void dtor(hash_table**)"
.LC25:
	.string	"*table"
	.text
	.p2align 4
	.globl	_Z4dtorPP10hash_table
	.type	_Z4dtorPP10hash_table, @function
_Z4dtorPP10hash_table:
.LFB102:
	.cfi_startproc
	endbr64
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	test	rdi, rdi
	je	.L123
	mov	rbx, rdi
	mov	rdi, QWORD PTR [rdi]
	test	rdi, rdi
	je	.L124
	mov	QWORD PTR [rdi], 0
	call	_Z5clearP10hash_table
	mov	rax, QWORD PTR [rbx]
	mov	rdi, QWORD PTR 8[rax]
	call	free@PLT
	mov	rdi, QWORD PTR [rbx]
	pop	rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	free@PLT
.L123:
	.cfi_restore_state
	lea	rcx, .LC24[rip]
	mov	edx, 308
	lea	rsi, .LC1[rip]
	lea	rdi, .LC3[rip]
	call	__assert_fail@PLT
.L124:
	lea	rcx, .LC24[rip]
	mov	edx, 309
	lea	rsi, .LC1[rip]
	lea	rdi, .LC25[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE102:
	.size	_Z4dtorPP10hash_table, .-_Z4dtorPP10hash_table
	.section	.rodata.str1.1
.LC26:
	.string	"size_t get_file_size(FILE*)"
.LC27:
	.string	"in"
	.text
	.p2align 4
	.globl	_Z13get_file_sizeP8_IO_FILE
	.type	_Z13get_file_sizeP8_IO_FILE, @function
_Z13get_file_sizeP8_IO_FILE:
.LFB104:
	.cfi_startproc
	endbr64
	sub	rsp, 168
	.cfi_def_cfa_offset 176
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 152[rsp], rax
	xor	eax, eax
	test	rdi, rdi
	je	.L130
	mov	r8, rdi
	xor	eax, eax
	mov	rdi, rsp
	mov	ecx, 18
	rep stosq
	mov	rdi, r8
	call	fileno@PLT
	mov	rdx, rsp
	mov	edi, 1
	mov	esi, eax
	call	__fxstat@PLT
	mov	rax, QWORD PTR 48[rsp]
	mov	rcx, QWORD PTR 152[rsp]
	xor	rcx, QWORD PTR fs:40
	jne	.L131
	add	rsp, 168
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L130:
	.cfi_restore_state
	lea	rcx, .LC26[rip]
	mov	edx, 346
	lea	rsi, .LC1[rip]
	lea	rdi, .LC27[rip]
	call	__assert_fail@PLT
.L131:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE104:
	.size	_Z13get_file_sizeP8_IO_FILE, .-_Z13get_file_sizeP8_IO_FILE
	.section	.rodata.str1.8
	.align 8
.LC28:
	.string	"text* read_from_file(FILE*, size_t*)"
	.section	.rodata.str1.1
.LC29:
	.string	"MEMORY ALLOCATION ERROR"
.LC30:
	.string	"MEMMORY ALLOCATION ERROR"
.LC31:
	.string	"READING FROM FILE ERROR"
	.text
	.p2align 4
	.globl	_Z14read_from_fileP8_IO_FILEPm
	.type	_Z14read_from_fileP8_IO_FILEPm, @function
_Z14read_from_fileP8_IO_FILEPm:
.LFB100:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	sub	rsp, 8
	.cfi_def_cfa_offset 48
	test	rdi, rdi
	je	.L139
	mov	r14, rdi
	mov	rbx, rsi
	mov	edi, 1
	mov	esi, 32
	call	calloc@PLT
	mov	r12, rax
	test	rax, rax
	je	.L140
	mov	rdi, r14
	call	_Z13get_file_sizeP8_IO_FILE
	mov	esi, 16
	lea	r13, 1[rax]
	mov	QWORD PTR [r12], r13
	mov	rdi, r13
	call	calloc@PLT
	mov	QWORD PTR 16[r12], rax
	test	rax, rax
	je	.L141
	mov	esi, 1
	mov	rdi, r13
	call	calloc@PLT
	mov	rdx, r13
	mov	rcx, r14
	mov	esi, 1
	mov	QWORD PTR 8[r12], rax
	mov	rdi, rax
	call	fread@PLT
	mov	r8, rax
	mov	rax, QWORD PTR [r12]
	lea	rdx, -1[rax]
	cmp	rdx, r8
	jne	.L142
	mov	rdx, QWORD PTR 8[r12]
	mov	BYTE PTR -1[rdx+rax], 0
.L132:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L142:
	.cfi_restore_state
	lea	rdi, .LC31[rip]
	xor	r12d, r12d
	call	perror@PLT
	mov	QWORD PTR [rbx], 3
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	mov	rax, r12
	pop	rbx
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
.L141:
	.cfi_restore_state
	lea	rdi, .LC30[rip]
	xor	r12d, r12d
	call	perror@PLT
	mov	QWORD PTR [rbx], 1
	jmp	.L132
.L140:
	lea	rdi, .LC29[rip]
	call	perror@PLT
	mov	QWORD PTR [rbx], 1
	jmp	.L132
.L139:
	lea	rcx, .LC28[rip]
	mov	edx, 260
	lea	rsi, .LC1[rip]
	lea	rdi, .LC27[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE100:
	.size	_Z14read_from_fileP8_IO_FILEPm, .-_Z14read_from_fileP8_IO_FILEPm
	.section	.rodata.str1.1
.LC32:
	.string	"size_t graph(hash_table*)"
.LC33:
	.string	"wb"
.LC34:
	.string	"graphs/dump.txt"
.LC35:
	.string	"COULDNT OPEN FILE GRAPH"
.LC36:
	.string	"digraph structs {\n"
	.section	.rodata.str1.8
	.align 8
.LC37:
	.string	"node [style=filled,color=\"hotpink\"];\n\n"
	.section	.rodata.str1.1
.LC38:
	.string	"\"%p\" [label=\"%ld\"]\n"
.LC39:
	.string	"\"%p\" [label = \"%s\" ]\n "
.LC40:
	.string	" \"%p\"->\"%p\" \n"
.LC41:
	.string	"\n\n\n"
.LC42:
	.string	"CLOSE FILE ERROR GRAPH"
	.section	.rodata.str1.8
	.align 8
.LC43:
	.string	"dot -Tpng graphs/dump.txt -o graphs/graph.png"
	.section	.rodata.str1.1
.LC44:
	.string	"SYSTEM COMM ERROR GRAPH"
	.section	.rodata.str1.8
	.align 8
.LC45:
	.string	" export DISPLAY=\"$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0\" "
	.section	.rodata.str1.1
.LC46:
	.string	"shotwell graphs/graph.png"
	.text
	.p2align 4
	.globl	_Z5graphP10hash_table
	.type	_Z5graphP10hash_table, @function
_Z5graphP10hash_table:
.LFB105:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 8
	.cfi_def_cfa_offset 64
	test	rdi, rdi
	je	.L165
	cmp	QWORD PTR 8[rdi], 0
	mov	r14, rdi
	je	.L166
	lea	rsi, .LC33[rip]
	lea	rdi, .LC34[rip]
	call	fopen@PLT
	mov	r15, rax
	test	rax, rax
	je	.L167
	mov	rcx, rax
	mov	edx, 18
	mov	esi, 1
	lea	rdi, .LC36[rip]
	call	fwrite@PLT
	mov	rcx, r15
	mov	edx, 38
	mov	esi, 1
	lea	rdi, .LC37[rip]
	call	fwrite@PLT
	cmp	QWORD PTR [r14], 0
	je	.L148
	xor	r12d, r12d
	lea	rbp, .LC39[rip]
	.p2align 4,,10
	.p2align 3
.L153:
	mov	rax, r12
	sal	rax, 5
	add	rax, QWORD PTR 8[r14]
	mov	rbx, QWORD PTR [rax]
	test	rbx, rbx
	je	.L149
	mov	r13, r12
	mov	r8, r12
	lea	rdx, .LC38[rip]
	mov	rdi, r15
	sal	r13, 4
	mov	esi, 1
	xor	eax, eax
	add	r13, r14
	mov	rcx, r13
	call	__fprintf_chk@PLT
	jmp	.L152
	.p2align 4,,10
	.p2align 3
.L164:
	lea	rdx, .LC40[rip]
	mov	esi, 1
	mov	rdi, r15
	xor	eax, eax
	call	__fprintf_chk@PLT
	mov	rbx, QWORD PTR 16[rbx]
	test	rbx, rbx
	je	.L149
.L152:
	mov	r8, QWORD PTR [rbx]
	mov	rcx, rbx
	mov	rdx, rbp
	mov	esi, 1
	mov	rdi, r15
	xor	eax, eax
	call	__fprintf_chk@PLT
	mov	rcx, QWORD PTR 24[rbx]
	mov	r8, rbx
	test	rcx, rcx
	jne	.L164
	mov	rcx, r13
	jmp	.L164
	.p2align 4,,10
	.p2align 3
.L149:
	mov	rcx, r15
	mov	edx, 3
	mov	esi, 1
	add	r12, 1
	lea	rdi, .LC41[rip]
	call	fwrite@PLT
	cmp	QWORD PTR [r14], r12
	ja	.L153
.L148:
	mov	edi, 125
	mov	rsi, r15
	call	fputc@PLT
	mov	rdi, r15
	call	fclose@PLT
	test	eax, eax
	jne	.L168
	lea	rdi, .LC43[rip]
	call	system@PLT
	test	eax, eax
	jne	.L156
	lea	rdi, .LC45[rip]
	call	system@PLT
	test	eax, eax
	jne	.L156
	lea	rdi, .LC46[rip]
	call	system@PLT
	test	eax, eax
	jne	.L156
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L156:
	.cfi_restore_state
	lea	rdi, .LC44[rip]
	call	perror@PLT
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	eax, 7
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L168:
	.cfi_restore_state
	lea	rdi, .LC42[rip]
	call	perror@PLT
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	eax, 4
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L167:
	.cfi_restore_state
	lea	rdi, .LC35[rip]
	call	perror@PLT
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	mov	eax, 2
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L165:
	.cfi_restore_state
	lea	rcx, .LC32[rip]
	mov	edx, 357
	lea	rsi, .LC1[rip]
	lea	rdi, .LC3[rip]
	call	__assert_fail@PLT
.L166:
	lea	rcx, .LC32[rip]
	mov	edx, 358
	lea	rsi, .LC1[rip]
	lea	rdi, .LC4[rip]
	call	__assert_fail@PLT
	.cfi_endproc
.LFE105:
	.size	_Z5graphP10hash_table, .-_Z5graphP10hash_table
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
