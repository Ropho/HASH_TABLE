	.file	"main.cpp"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"rb"
.LC1:
	.string	"texts/mem.txt"
.LC2:
	.string	"OPEN FILE ERROR"
.LC3:
	.string	"CLOSE FILE ERROR"
.LC4:
	.string	"MEMMORY ALLOCATION ERROR"
.LC5:
	.string	"SUCCESSFUL END OF PROG =)"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB92:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	lea	rsi, .LC0[rip]
	lea	rdi, .LC1[rip]
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbx
	sub	rsp, 40
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -56[rbp], rax
	xor	eax, eax
	mov	QWORD PTR -72[rbp], 0
	call	fopen@PLT
	test	rax, rax
	je	.L26
	lea	rsi, -72[rbp]
	mov	rdi, rax
	mov	r12, rax
	call	_Z14read_from_fileP8_IO_FILEPm@PLT
	mov	rbx, rax
	test	rax, rax
	je	.L27
	mov	rdi, r12
	call	fclose@PLT
	mov	r12d, eax
	test	eax, eax
	jne	.L28
	call	_Z4ctorv@PLT
	mov	QWORD PTR -64[rbp], rax
	test	rax, rax
	je	.L29
	mov	rdi, rbx
	call	_Z14words_arr_fillP4text@PLT
	mov	QWORD PTR -72[rbp], rax
	test	rax, rax
	je	.L7
.L24:
	mov	r12d, eax
.L1:
	mov	rax, QWORD PTR -56[rbp]
	xor	rax, QWORD PTR fs:40
	jne	.L30
	lea	rsp, -40[rbp]
	mov	eax, r12d
	pop	rbx
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L27:
	.cfi_restore_state
	mov	r12d, DWORD PTR -72[rbp]
	jmp	.L1
.L28:
	lea	rdi, .LC3[rip]
	mov	r12d, 4
	call	perror@PLT
	jmp	.L1
.L7:
	mov	r13, QWORD PTR hash_crc_32_asm@GOTPCREL[rip]
	mov	rdi, QWORD PTR -64[rbp]
	mov	rsi, rbx
	mov	rdx, r13
	call	_Z15hash_table_fillP10hash_tableP4textPFmPvmE@PLT
	mov	QWORD PTR -72[rbp], rax
	test	rax, rax
	jne	.L24
	mov	rdx, QWORD PTR 24[rbx]
	mov	rdi, rsp
	lea	rcx, 15[0+rdx*8]
	mov	rsi, rcx
	and	rcx, -4096
	sub	rdi, rcx
	and	rsi, -16
	mov	rcx, rdi
.L9:
	cmp	rsp, rcx
	je	.L10
	sub	rsp, 4096
	or	QWORD PTR 4088[rsp], 0
	jmp	.L9
.L26:
	lea	rdi, .LC2[rip]
	mov	r12d, 2
	call	perror@PLT
	jmp	.L1
.L29:
	lea	rdi, .LC4[rip]
	mov	r12d, 1
	call	perror@PLT
	jmp	.L1
.L10:
	and	esi, 4095
	sub	rsp, rsi
	test	rsi, rsi
	je	.L11
	or	QWORD PTR -8[rsp+rsi], 0
.L11:
	mov	r15, rsp
	test	rdx, rdx
	jle	.L12
	.p2align 4,,10
	.p2align 3
.L13:
	mov	DWORD PTR [r15+rax*8], 0
	mov	DWORD PTR 4[r15+rax*8], 0
	add	rax, 1
	cmp	rax, rdx
	jne	.L13
.L12:
	mov	r14d, 20
	.p2align 4,,10
	.p2align 3
.L15:
	mov	rsi, QWORD PTR -64[rbp]
	mov	rcx, r13
	mov	rdx, rbx
	mov	rdi, r15
	call	_Z18find_text_in_tableP9find_infoP10hash_tableP4textPFmPvmE@PLT
	mov	QWORD PTR -72[rbp], rax
	test	rax, rax
	jne	.L24
	sub	r14, 1
	jne	.L15
	mov	rdi, QWORD PTR -64[rbp]
	call	_Z5graphP10hash_table@PLT
	mov	QWORD PTR -72[rbp], rax
	test	rax, rax
	jne	.L24
	lea	rdi, -64[rbp]
	call	_Z4dtorPP10hash_table@PLT
	lea	rdi, .LC5[rip]
	call	puts@PLT
	jmp	.L1
.L30:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE92:
	.size	main, .-main
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
