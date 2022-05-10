#ifndef HASH_TABLE_FUNC_H
#define HASH_TABLE_FUNC_H

#include <stdio.h>
#include <malloc.h>
#include <assert.h>
#include <sys/stat.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <ctype.h>

#include "constants.hpp"
#include "hash_func.hpp"

typedef struct word {

    char *s = nullptr;

    size_t len = 0;

}word;


typedef struct node {

    struct word word = {};

    node *next = nullptr;

    node *prev = nullptr;

}node;


typedef struct node_ptr {

    node *head = nullptr;

    node *tail = nullptr;
    
    size_t num_of_elem = 0;

}node_ptr;


typedef struct hash_table {

    size_t capacity = NUM_LISTS;

    size_t error = 0;

    node_ptr *arr = nullptr;

}hash_table;


typedef struct text {

    size_t buff_size = 0;

    char *buff = nullptr;

    word *words = nullptr;

    size_t num_of_words = 0;
}text;


typedef struct find_info {

    int key = 0;

    int num = 0;

}find_info;


hash_table* ctor (void);
void dtor (hash_table **table);
text *read_from_file (FILE *in);
size_t get_file_size (FILE *in);
void words_arr_fill (text *buffer);
void find_pos (hash_table *table,  size_t key);
void graph (hash_table *table);
void print_in_file (hash_table *table, FILE *csv);
void clear (hash_table *table);
void hash_table_fill (hash_table *table, text *buffer, size_t (*hash_func) (void *, size_t));
size_t find_text_in_table (find_info *arr_word_pos, hash_table *table, text *buffer, size_t (*hash_func) (void *, size_t));
size_t find_word_in_table (char *word, size_t key, hash_table *table);

extern "C"  size_t find_word (char *word, size_t key, hash_table *table);
extern "C"  size_t r_strcmp (char *first, char *second);

#endif