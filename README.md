HASH_TABLE
==========

## CONTENTS

[1.INTRO](#INTRO)

[2.HASH FUCNTION ANALYSIS](#ANALYSIS)

[3.OPTIMIZATION](#OPTIMIZATION)

[4.CONCLUSION](#CONCLUSION)


# Intro

The task of this project was to: 
1. study the chain method of constructing hash table
2. compare different hash functions
3. optimize the hash function using previously learnt methods.


# ANALYSIS:

In this part wi will be analyzing 6 different hash functions based on:
1. number of collisions.
2. variety of keys.
3. even distribution (whithout maximums and minmums)


## Compile
	all:
		gcc main.cpp hash_table_func.cpp hash_func.cpp -o main ; ./main
	
## HASH FUNCTIONS

### 1.  **RETURN 1**

  * Brief description
  > function is a very bad example of a hash function due to its multiple number of collisions. 

  > **X SCALE = 255**

<img src="/pic/ret1.png" alt="RET1" title="RET1" width="720" height="480"/>

### 2.  **RETURN first ASCII**
  
  * Brief description
  > function is better than *RETURN 1*, as it can give out multiple values (not only 1), but has a small variety of keys (only 255 of desired 1024) and very high percent of collisions, so it cannot be a good hash function. 

  > **X SCALE = 255**
<img src="/pic/first_ASCII.png" alt="first_ASCII" title="first_ASCII" width="720" height="480"/>

### 3.  **Len of word**
  
  * Brief description
  > Like the previous function it has a small variety of keys (only 255 of desired 1024) and very high percent of collisions cause words lengths are rather limited, so it cannot be considered a good hash function. 

  > **X SCALE = 50**

<img src="/pic/len.png" alt="LEN" title="LEN" width="720" height="480"/>

### 4.  **Sum of ASCII**
  
  * Brief description
  > Is a better function than previous ones. Covers all the desired 1024 keys, but has some problems with even distribution (has maximums and minimums which are easily distinguished, so has up to 80 elements in a list (desired 20). Still cannot be a good hash function.

  > **X SCALE = 1024**

<img src="/pic/sum.png" alt="SUM" title="SUM" width="720" height="480"/>

### 5.  **ROL**
  
  * Brief description
  > Better function than previous ones: has a variety of keys and rather low maximum number of elements in a list. But it has some empty spaces (not full covering) -> BAD hash function.  

  > **X SCALE = 1024**
 
<img src="/pic/rol.png" alt="ROL" title="ROL" width="720" height="480"/>

### 6.  **CRC 32**
  
  * Brief description
  > The best of given hash functions: **high variety** of keys, **very low** (desired 20-30) maximum number of elements in a list and **even distribution** of elements in lists.

  > **X SCALE = 1024**
 
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


## Usage

1.  Processor
    > AMD Ryzen 5 4500U
2.  Language
    > C, C++, Assembly (NASM), GAS (inline asm)
3.  Profiler
    > Kcachegrind (WSL)
4.  Compiler
    > GCC
5.  Hash function
    > CRC32
6.  Timer
    > time ./program (WSL)
    > total instruction fetch cost (kcachegrind)

## TESTING
  
  > 1. filling the buffer up with **WORDS** from file
  > 2. filling the char pointer array up with **WORDS**
  > 3. filling up the table with the char pointer array

### STRESS TEST
  >   > 4. finding the position of all the words from the text in the hash table **TWENTY TIMES**
  
  > 5. clearing the table


## Compile

	all:
		nasm -felf64 asm/find_word.asm && gcc -O2 -mavx2 asm/find_word.o main.cpp hash_table_func.cpp hash_func.cpp -o main ; time ./main


## TIME MEASUREMENT
+ Due to Strong variation in time values using **Linux time**. 
	
+ More precise way to measure **Execution time** is to look at **Total instruction fetch cost** in kcachegrind.
	
Have a look at the kcachegrind window. Funcs what we wil be looking at are three at the top of the screenshot. **TOTAL INSTRUCTION FETCH COST: 284 mil**

<img src="/pic/no_opt.png" alt="NOOPT" title="NOOPT" width="786" height="861"/>

## Optimized functions

+ strcmp_avx_2
  * > self 148 mil
  * > called 6,6 mil times
  > Was rewritten in asm. Function self time reduced in 1.5 times (148 mil -> 85 mil). Total instruction fetch reduced form 284 mil -> 214 mil (25%).


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
<img src="/pic/opt_1.png" alt="1OPT" title="1OPT" width="796" height="865"/>

  > Add inline assembly to avoid *calls & rets*. Function self time reduced in 1.5 times (148 mil -> 85 mil). Total instruction fetch reduced form 214 mil -> 202 mil (6%).

```asm

	asm (
	"1:\n\t"                //check_ASCII  
	     "mov ah, [rdi]\n\t"
	     "mov al, [rsi]\n\t"

	 "cmp ah, al\n\t"
	 "ja 2f\n\t"        //n_e_g
	 "jb 3f\n\t"        //n_e_l
	 "inc rdi\n\t"
	 "inc rsi\n\t"
	 "cmp ah, 0\n\t"
	 "je 4f\n\t"
	 "jmp 1b\n\t"

	 "4:\n\t"           //equal:
	 "mov rax, 0\n\t"
	 "jmp 5f\n\t"

	 "2:\n\t"
	 "mov rax, 1\n\t"
	 "jmp 5f\n\t"

	 "3:\n\t"
	 "mov rax, -1\n\t"

	 "5:\n\t"
	: "=a" (out)
	: "D" (first), "S" (second)
);
```
<img src="/pic/opt_2.png" alt="2OPT" title="2OPT" width="792" height="850"/>



+ hash_crc_32
  * > self 36,5 mil
  * > called 515.000 times 

  > Was rewritten in asm using crc32 func. Got decrease from 36,5 mil to 25,7 mil self time. Total fetch instruction 202 mil -> 191 mil (5,4%)

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


<img src="/pic/opt_3.png" alt="3OPT" title="3OPT" width="792" height="850"/>


  > Add inline assembly to avoid *calls & rets*. Total instruction fetch reduced form 191 mil -> 189 mil (1%). Bad optimization, cause not so many calls of hash (unlike strcmp).

```asm

    asm (
        "push rdi\n\t"

        "xor rax, rax\n\t"
        
        "mov eax, 0xFFFFFFFF\n\t"
        
        "1:\n\t"
            "cmp byte ptr [rdi], 0\n\t"
            "je 2f\n\t"

            "movzx r10d, byte ptr [rdi]\n\t"

            "crc32 eax, r10b\n\t"

            "inc rdi\n\t"
        
        "jmp 1b\n\t"

        "2:\n\t"
            "not eax\n\t"
        
        "pop rdi\n\t"

        : "=a" (hash)
        : "D" (ptr)
    );
```
<img src="/pic/opt_4.png" alt="4OPT" title="4OPT" width="790" height="859"/>

+ find_word_in_table
  * > self 72 mil
  * > called 500 thous times
  > Was rewritten in asm. Unfortunately, didnt give any boost, vice versa we've got time increase =(. Apparently O2 is much better than this asm implementation. So we won't be using that asm function.

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
<img src="/pic/opt_4.png" alt="4OPT" title="4OPT" width="790" height="876"/>


## Any other functions can't give more than 3% boost so these were all the optimizations.

# CONCLUSION

|            | no opt   | no opt O2|strcmp asm|strcmp asm (inl)|hash asm|hash asm (inl)|
|:----------:|:--------:|:--------:|:--------:|:--------------:|:------:|:------------:|
|real (secs) |0,197     |0,185     |0,181     |0,18	       |0,177   |0,172         |
|user (secs) |0,195     |0,185     |0,179     |0,18            |0,176   |0,171         |
|sys  (secs) |0,002     |0         |0         |0               |0,002   |0,001         |

## TOTAL INCREASE (TOTAL FETCH INSTRUCTION COST):
### **284 mil -> 191 mil. (33%)**
