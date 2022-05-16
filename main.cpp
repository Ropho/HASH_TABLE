#include ".h/hash_table_func.hpp"


int main (int argc, char **argv) {

    size_t error = 0;
/////////////////////////////////////////////////
#if defined TEXT
    FILE *in   = fopen ("texts/words.txt", "rb");
#elif defined HAMLET
    FILE *in   = fopen ("texts/HAMLET.txt", "rb");
#elif defined MEM
    FILE *in   = fopen ("texts/mem.txt", "rb");
#endif

    if (!in) {
        perror ("OPEN FILE ERROR");
        return OPEN_FILE_ERROR;
    }

    text *buffer = read_from_file (in, &error);
    if (!buffer) {
        return error;
    }
    
    if (fclose (in)) {
        perror ("CLOSE FILE ERROR");
        return CLOSE_FILE_ERROR;
    }

/////////////////////////////////////////////////
    hash_table *table = ctor ();
    if (!table) {
        perror ("MEMMORY ALLOCATION ERROR");
        return MEM_ALLOC_ERROR;
    }

    error = words_arr_fill (buffer);
    if (error) {
        return error;
    }

#ifdef HASH_RET_1
    error = hash_table_fill (table, buffer, hash_only_1);
#elif defined HASH_FIRST_ASCII
    error = hash_table_fill (table, buffer, hash_first_symb);
#elif defined HASH_LEN
    error = hash_table_fill (table, buffer, hash_len);
#elif defined HASH_SUM
    error = hash_table_fill (table, buffer, hash_sum_symb);
#elif defined HASH_ROL
    error = hash_table_fill (table, buffer, hash_rol);
#else
    #if defined opt_hash_asm || defined opt_hash_asm_inline
        error = hash_table_fill (table, buffer, hash_crc_32_asm);
    #else
        error = hash_table_fill (table, buffer, hash_crc_32);
    #endif
#endif
    if (error)
        return error;
///////////////////////////////////////////////////////////////////////

    find_info arr_word_pos [buffer->num_of_words] = {};

    for (size_t index = 0; index < NUM_TESTS; ++index) {

        #if defined opt_hash_asm || defined opt_hash_asm_inline
            error = find_text_in_table (arr_word_pos, table, buffer, hash_crc_32_asm);
        #else
            error = find_text_in_table (arr_word_pos, table, buffer, hash_crc_32);
        #endif

        if (error)
            return error;
    }

///////////////////////////////////////////////////////////////////////

#ifdef GRAPH
    error = graph (table);
    if (error)
        return error;
#endif

///////////////////////////////////////////////////////////////////////
#ifdef EXCEL 
    FILE *csv = fopen ("graphs/excel.csv", "wb");
    if (!csv) {
        perror ("OPEN FILE ERROR EXCEL");
        return OPEN_FILE_ERROR;
    }
    
    print_in_file (table, csv);
    
    if (fclose (csv)) {
        perror ("CLOSE FILE ERROR EXCEL");
        return CLOSE_FILE_ERROR;
    }
#endif
///////////////////////////////////////////////////////////////////////
    dtor (&table);
    
    puts ("SUCCESSFUL END OF PROG =)");
    return 0;
}