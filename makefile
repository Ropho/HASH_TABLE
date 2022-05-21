all:
	nasm -felf64 src/asm/asm_opt.asm && gcc -masm=intel  -O2 -mavx2 src/asm/asm_opt.o src/hash_table/main.cpp src/hash_table/hash_table_func.cpp src/hash_table/hash_func.cpp -no-pie  -o main