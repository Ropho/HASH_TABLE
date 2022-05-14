HASH_TABLE
==========

## TABLE CAPACITY
  + > We wanna have max **20 elements** in 1 list with a good hash func, 
  + > so in accordance with having a text with **24000 Unique words**
  + > We will have approximately **1024 lists**
  + > *That is a fixed size used in all the testing* 

## TESTING
  
  > 1. filling the buffer up with Hamlet from file
  > 2. filling the char pointer array up with the words
  > 3. filling the table with the char pointer array

### STRESS TEST
  >   > 4. finding the position of all the words from the text in Hamlet **FIVE TIMES**
  
  > 5. clearing the table


# Before optimizations analysis:


Compile
-------
	all:
		gcc main.cpp hash_table_func.cpp hash_func.cpp -o main ; ./main
	
## HASH FUNCTIONS

### 1.  **Return 1**

  * Fast description
  > function is a very bad example of a hash function due to its collisions. 

<img src="/pic/ret1.png" alt="RET1" title="RET1" width="720" height="480"/>

### 2.  **First ASCII**
  
  * Fast description
  > function is better than *return 1*, as it can give out multiple values but has a small variety of keys (only 255 of desired 1024) and very high percent of collisions, so cannot be a good hash function. 

<img src="/pic/first_ASCII.png" alt="first_ASCII" title="first_ASCII" width="720" height="480"/>

### 3.  **Len of word**
  
  * Fast description
  > like the previous function has a small variety of keys (only 255 of desired 1024) and very high percent of collisions cause words lengths are rather limited, so cannot be a good hash function. 

<img src="/pic/len.png" alt="LEN" title="LEN" width="720" height="480"/>

### 4.  **Sum of ASCII**
  
  * Fast description
  > a better function than previous ones. Covers all the given 1024 keys, but has some roblems with smoothness (has maximums and minimums which are easily distinguished, so has up to 80 elements in list (desired 20). Still cannot be a good hash function.

<img src="/pic/sum.png" alt="SUM" title="SUM" width="720" height="480"/>

### 5.  **ROL**
  
  * Fast description
  > Better than previous ones: has a variety of keys and rather low maximum number of elements in a list. But it has some empty spaces (not full covering) -> BAD.  

<img src="/pic/rol.png" alt="ROL" title="ROL" width="720" height="480"/>

### 6.  **CRC 32**
  
  * Fast description
  > The best of given hash functions: **high variety** of keys, **very low** (desired 20-30) maximum (average) number of elements in a list and **even covering** of lists.

<img src="/pic/crc32.png" alt="CRC32" title="CRC32" width="720" height="480"/>

Dispersion values for different hash functions:

| hash func   | dispersion |
|-------------|------------|
| ret_1       | 589296     |
| first ASCII | 23043      |
| len         | 65230      |
| sum ASCII   | 351        |
| rol         | 711        |
| crc32       | 25         |

### **As expected, the best parametres has a *CRC 32* function**


# Optimization


Usage
-----
1.  Processor
    > AMD Ryzen 5 4500U
2.  Instructions
    > AVX, AVX2
3.  Language
    > C, C++, Assembly (NASM)
4.  Profiler
    > Kcachegrind (WSL)
5.  Compiler
    > GCC
6.  Hash function
    > CRC32
7.  Timer
    > time ./program (WSL)

Compile
-------
	all:
		nasm -felf64 asm/find_word.asm && gcc -O2 -mavx2 asm/find_word.o main.cpp hash_table_func.cpp hash_func.cpp -o main ; time ./main


  > **Average per 10 measurements is taken.**

Have a look at the kcachegrind window. Funcs what we wil be looking at are three at the top of the screenshot.

<img src="/pic/no_opt.png" alt="NOOPT" title="NOOPT" width="785" height="870"/>


+ strcmp_avx_2
  * > self 42 mil
  * > called 1.9 mil
  > Was rewritten in asm. Function self time reduced in 2 times (42.000.000 -> 22.900.000). Got no boost in overall time. Probably, the function wasn't the "bottle neck" in our program. Gonna look through other functions. Total instruction fetch = 65.600.000

```asm
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
```
<img src="/pic/opt_1.png" alt="1OPT" title="1OPT" width="775" height="853"/>


+ find_word_in_table
  * > self 19 mil
  * > called 147 thous times
  > Was rewritten in asm. Unfortunately, didnt give any boost, vice versa we've got 5 mil (self) self time increase =(. O2 is much better than than this asm implementation. So we won't be using that asm function.

```asm
find_word:

    push rcx
    
    xor rcx, rcx         ; index = 0

    mov rdx, [rdx + 8]

    shl rsi, 5          ;rsi = rsi * 32

			;rdx = ptr    
    mov rdx, qword [rdx + rsi]
.not_nullptr:

    cmp rdx, 0d
    je .nullptr

    inc rcx     ;++index

    mov rsi, qword [rdx]        ;rsi = ptr->word.s
				;rdi = word
    push rdi
    push rsi
	call r_strcmp
    pop rsi
    pop rdi

    cmp rax, 0d
    je .out

    mov rdx, qword [rdx + 16]

    jmp .not_nullptr


.out:
    cmp rdx, 0d
    je .nullptr
    jmp .not_null

.nullptr:
    mov rax, 0d
    jmp .to_end

.not_null:
    mov rax, rcx
    jmp .to_end

.to_end:

    pop rcx

    ret
```
<img src="/pic/opt_2.png" alt="2OPT" title="2OPT" width="790" height="876"/>



+ hash_crc_32
  * > self 10.4 mil
  * > called 150.000 times 

  > Was rewritten in asm using avx crc32 func. Got decrease from 10 mil to 7.3 mil self time. Total fetch instruction 62 mil.

```asm
hash_crc_32_asm:

    mov eax, 0FFFFFFFFh

.repeat:
    cmp byte [rdi], 0h  ;rdi = word
    je .output

    movzx r10d, byte [rdi]

    crc32 eax, r10b

    inc rdi
    jmp .repeat

.output:
    not eax
    ret
```


<img src="/pic/opt_3.png" alt="3OPT" title="3OPT" width="796" height="865"/>


|            | no opt   | no opt O2|  opt 1|
|:----------:|:--------:|:--------:|:-----:|
|real (secs) |0,077     |0,06      |0,06   |
|user (secs) |0,073     |0,058     |0,058  |
|sys  (secs) |0,003     |0,002     |0,026  |
