#include "hash_table_func.hpp"


int main (void) {

/////////////////////////////////////////////////
    FILE *in   = fopen ("HAMLET.txt", "rb");
    // FILE *in   = fopen ("mem.txt", "rb");
    if (in == nullptr) {
        perror ("COULDNT OPEN FILE");
        return 1;
    }

    text *buffer = read_from_file (in);
    if (buffer == nullptr) {
        perror ("ERROR READING FORM FILE");
        return 2;
    }
    fclose (in);
/////////////////////////////////////////////////
    hash_table *table = ctor ();
    if (table == nullptr) {
        perror ("MEMMORY ALLOCATION TORUBLE");
        return 3;
    }

    words_arr_fill (buffer);
    
    // hash_table_fill (table, buffer, r_hash);
    hash_table_fill (table, buffer, hash_only_1);
    // hash_table_fill (table, buffer, hash_first_symb);
    // hash_table_fill (table, buffer, hash_len);
    // hash_table_fill (table, buffer, hash_sum_symb);
    
    // hash_table_fill (table, buffer, hash_only_1);

///////////////////////////////////////////////////////////////////////
    // clear (table);
    
    // hash_table_fill (table, buffer, r_hash);
    // hash_table_fill (table, buffer, hash_only_1);
    // hash_table_fill (table, buffer, hash_first_symb);
    // hash_table_fill (table, buffer, hash_len);
    // hash_table_fill (table, buffer, hash_sum_symb);
    
    // hash_table_fill (table, buffer, hash_only_1);
///////////////////////////////////////////////////////////////////////
                //STRESS TEST                
    find_info arr_word_pos [buffer->num_of_words] = {};
    
    if (find_text_in_table (arr_word_pos, table, buffer, r_hash) == 0) {
        perror ("WORD NOT FOUND");
        return 4;
    }

///////////////////////////////////////////////////////////////////////

    // graph (table);

///////////////////////////////////////////////////////////////////////
    // FILE *csv = fopen ("excel.csv", "wb");
    // print_in_file (table, csv);
    // fclose (csv);
///////////////////////////////////////////////////////////////////////
    dtor (&table);
}