global find_word
global r_strcmp


section .data

mem db "ABCD", 0Ah
mem_len equ $ - mem

kek db "ZXC", 0Ah
kek_len equ $ - kek



section .text

find_word:


    ; mov rdx, mem
    ; mov rdx, kek
    ;     call strcmp

    ; ret

    mov rbp, rsp      ; rbp points on "ret"

    push rdi        ; first param  rbp - 8
    push rsi        ; second param rbp - 16
    push rdx        ; third param  rbp - 24

    
    mov rcx, 0d     ; index = 0

    mov rbx, [rbp - 24] ;table
    
    add rbx, 16d        ;table->arr


    mov rax, [rbp - 16] ;rax = key
    mov rdx, 24d 
    mul rdx             ;rax = key * 24
    
    mov rbx, qword [rbx]
    add rbx, rax   ;rbx = table->arr + key

    mov rbx, qword [rbx] ;(table->arr + key)->head


.not_nullptr:

    inc rcx     ;++index

    call r_strcmp


    ; mov rax, 
    ret

    cmp rax, 0d
    ; jne not_nullptr




	; push r14
	; push rbx
 	; 	call strlen
	; pop rbx
	; pop r14


;     cmp rbx, 0d
;     je null
;     jmp not_null

; null:
;     mov rax, 0d
;     jmp to_end
    
; not_null:
;     mov rax, rcx
;     jmp to_end

to_end:
    pop rsi
    pop rsi
    pop rsi

    ret

    ; mov rbx, rsi + 16d  ; hash_table->arr 
    ; mov r8, rdi * 24      ;    hash_table->arr + key


ret




;----------------------------------------------------------------
;ENTRY: rdi = offset string1, rsi = offset string2
;OUT: 
;DESTR: 

r_strcmp:


.check_ASCII:

	mov ah, byte [rdi]
	
	mov al, byte [rsi]

	cmp ah, al

	ja .not_equal_greater
	jb .not_equal_less

	inc rdi
	inc rsi

	cmp ah, 0d
	je .equal
	
	jmp .check_ASCII

.equal:
	mov rax, 0
    ret
		
.not_equal_greater:
	mov rax, 1	
	ret

.not_equal_less:
	mov rax, -1
	ret


;------------------------------------------------------------------------------
;ENTRY: rbx = offset string
;OUT: rcx = strlen
;DESTR: rbx, rdx

r_strlen:

	mov rcx, 0
	
.increment:

	mov dh, byte [rbx]
	
	cmp dh, 0h
	je .end_of_increment
	inc rcx
	inc rbx
	jmp .increment


.end_of_increment:		
	ret	
