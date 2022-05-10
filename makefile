all:
	nasm -felf64 asm/find_word.asm && gcc -O2 -mavx2 asm/find_word.o main.cpp hash_table_func.cpp hash_func.cpp -o main

# add -O2
# -Wall -Wextra -Wpedantic