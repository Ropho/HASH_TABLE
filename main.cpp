#include ".h/hash_table_func.hpp"


int main (void) {

/////////////////////////////////////////////////
#ifdef TEXT
    FILE *in   = fopen ("texts/words.txt", "rb");
#elif defined HAMLET
    FILE *in   = fopen ("texts/HAMLET.txt", "rb");
#elif defined MEM
    FILE *in   = fopen ("texts/mem.txt", "rb");
#endif


    if (in == nullptr) {
        perror ("OPEN FILE ERROR");
        return OPEN_FILE_ERROR;
    }

    text *buffer = read_from_file (in);
    if (buffer == nullptr) {
        perror ("READING FORM FILE ERROR");
        return READ_FILE_ERROR;
    }
    fclose (in);
/////////////////////////////////////////////////
    hash_table *table = ctor ();
    if (table == nullptr) {
        perror ("MEMMORY ALLOCATION ERROR");
        return MEM_ALLOC_ERROR;
    }

    words_arr_fill (buffer);
    

#if defined HASH_RET_1
    hash_table_fill (table, buffer, hash_only_1);
#elif defined HASH_FIRST_ASCII
    hash_table_fill (table, buffer, hash_first_symb);
#elif defined HASH_LEN
    hash_table_fill (table, buffer, hash_len);
#elif defined HASH_SUM
    hash_table_fill (table, buffer, hash_sum_symb);
#elif defined HASH_ROL
    hash_table_fill (table, buffer, hash_rol);
#elif defined HASH_CRC_32
    #ifndef opt_hash_asm
        hash_table_fill (table, buffer, hash_crc_32);
    #else
        hash_table_fill (table, buffer, hash_crc_32_asm);
    #endif
#else
    assert (0);
#endif

///////////////////////////////////////////////////////////////////////

    // clear (table);

///////////////////////////////////////////////////////////////////////

    find_info arr_word_pos [buffer->num_of_words] = {};
    
    for (int index = 0; index < NUM_TESTS; ++index) {

        #ifndef opt_hash_asm
            if (find_text_in_table (arr_word_pos, table, buffer, hash_crc_32) == 0) {
        #else
            if (find_text_in_table (arr_word_pos, table, buffer, hash_crc_32_asm) == 0) {
        #endif
            perror ("WORD NOT FOUND");
            return HASH_TABLE_NOT_FOUND_WORD;
        }
    }
///////////////////////////////////////////////////////////////////////

    // graph (table);

///////////////////////////////////////////////////////////////////////
    // FILE *csv = fopen ("graphs/excel.csv", "wb");
    // print_in_file (table, csv);
    // fclose (csv);
///////////////////////////////////////////////////////////////////////
    dtor (&table);
}