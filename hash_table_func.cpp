#include ".h/hash_table_func.hpp"


inline __attribute__((always_inline)) size_t inl_hash_crc_32_asm (void *ptr, size_t len) {

    size_t hash = 0;
    
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

    return hash;
}


inline __attribute__((always_inline)) size_t inl_r_strcmp (char *first, char *second) {

    size_t out = 0;

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

    return out;
}


size_t find_text_in_table (find_info *arr_word_pos, hash_table *table, text *buffer, size_t (*hash_func) (void *, size_t)) {

    assert (arr_word_pos);
    assert (table);
    assert (buffer);
    assert (hash_func);
    assert (buffer->words);

    // puts ("FIND");

    for (size_t index = 0; index < buffer->num_of_words; ++index) {

        #ifdef opt_hash_asm_inline
            size_t key = inl_hash_crc_32_asm ((buffer->words[index]).s, (buffer->words[index]).len) % NUM_LISTS;
        #else
            size_t key = hash_func ((buffer->words[index]).s, (buffer->words[index]).len) % NUM_LISTS;
        #endif
        // printf ("WORD %s \t KEY %ld\n", (buffer->words[index]).s, key);
        arr_word_pos[index].key = key;

#ifndef opt_find_word_asm
        arr_word_pos[index].num = find_word_in_table (buffer->words[index].s, key, table);
#else
        arr_word_pos[index].num = find_word (buffer->words[index].s, key, table);
#endif

        if (arr_word_pos[index].num == 0) {
            perror ("WORD NOT FOUND TEXT_FIND");
            return HASH_TABLE_NOT_FOUND_WORD;
        }
    }
    return 0;
}


size_t find_word_in_table (char *word, size_t key, hash_table *table) {

    assert (word);
    assert (table);
    assert (table->arr);
    assert (!(key >= NUM_LISTS));

    size_t index = 0;
    node  *ptr = (table->arr + key)->head;
   
    while (ptr != nullptr) {

        ++index;

#ifdef opt_strcmp_asm
        if (r_strcmp (ptr->word.s, word) == 0)  // OPT: asm func
#elif defined opt_strcmp_asm_inline
        if (inl_r_strcmp (ptr->word.s, word) == 0)
#else
        if (strcmp (ptr->word.s, word) == 0)    // NO_OPT
#endif
            break;
      
        ptr = ptr->next;
    }

    if (ptr != nullptr) {
        return index;
    }
    else {
        return 0;
    }
}


void print_in_file (hash_table *table, FILE *csv) {

    assert (table);
    assert (table->arr);
    assert (csv);
    
    for (size_t index = 0; index < table->capacity; ++index) {

        size_t len = (table->arr[index]).num_of_elem;

        fprintf (csv, " %ld;%ld\n", index, len);
    }
}


size_t insert_in_list (hash_table *table,  size_t key, char *word) {
    
    // puts ("INSERT");
    // printf ("WORD: %s \t KEY: %ld LEN: %ld\n", word, key, strlen (word));

    assert (table);
    assert (word);
    assert (!(key >= NUM_LISTS));

    node *ptr = (node*)calloc (1, sizeof (node));
    if (ptr == nullptr) {
        perror ("MEM ALLOC TROUBLE");
        return MEM_ALLOC_ERROR;
    }
    ptr->word.s =  word;
    ptr->prev = nullptr;

    (*(table->arr + key)).num_of_elem++;

    if ((*(table->arr + key)).head == nullptr) {
        (*(table->arr + key)).head = ptr;
        (*(table->arr + key)).tail = ptr;
        ptr->next = nullptr;
    }
    else {
        ptr->next = (*(table->arr + key)).head;
        (*(table->arr + key)).head->prev = ptr;
        (*(table->arr + key)).head = ptr;
    }
    return 0;
}


size_t hash_table_fill (hash_table *table, text *buffer, size_t (*hash_func) (void *, size_t)) {

    assert (table);
    assert (buffer);
    assert (buffer->words);
    assert (hash_func);

    // puts ("FILLIN");

    for (size_t index = 0; index < buffer->num_of_words; ++index) {

        #if defined opt_hash_asm_inline
            size_t key =  inl_hash_crc_32_asm ((buffer->words + index)->s, (buffer->words + index)->len) % NUM_LISTS;
        #else
            size_t key = hash_func ((buffer->words + index)->s, (buffer->words + index)->len) % NUM_LISTS;
        #endif
        // printf ("WORD %s \t KEY %ld\n", (buffer->words[index]).s, key);

#ifndef opt_find_word_asm
        if (find_word_in_table ((buffer->words + index)->s, key, table) == 0)
#else 
        if (find_word ((buffer->words + index)->s, key, table) == 0)
#endif
        {
            size_t error = insert_in_list (table, key, (buffer->words + index)->s);
            if (error != 0)
                return error;
        }
    }
    return 0;
}


size_t words_arr_fill (text *buffer) {

    assert (buffer       != nullptr);
    assert (buffer->buff != nullptr);

    char *strt_wrd = buffer->buff;
    char *end_wrd  = buffer->buff;

    buffer->num_of_words = 0;
    
    if (strchr (strt_wrd, '\r')) {
        perror ("ENCODING ERROR");
        return ENCODING_ERROR;
    }

    while (1) {

        while (!isalnum (*end_wrd))
            ++end_wrd;
        strt_wrd = end_wrd;

        while (isalnum (*end_wrd))
            ++end_wrd;

        buffer->words[buffer->num_of_words].s = strt_wrd;
        buffer->words[buffer->num_of_words].len = end_wrd - strt_wrd;
      ++buffer->num_of_words;
        
        if (*end_wrd == '\0')
            break;

        *end_wrd = '\0';
        end_wrd ++;
        strt_wrd = end_wrd;   
    }

    return 0;
}


text *read_from_file (FILE *in, size_t *error) {

    assert (in);

    text *buffer = (text*)calloc(1, sizeof (text));
    if (buffer == nullptr) {
        perror ("MEMORY ALLOCATION ERROR");
        *error = MEM_ALLOC_ERROR;
        return nullptr;
    }
    buffer->buff_size = get_file_size (in) + 1;     // add \0 IN THE END

    buffer->words = (word*)calloc(buffer->buff_size, sizeof (word));
    if (buffer->words == nullptr) {
        perror ("MEMMORY ALLOCATION ERROR");
        *error = MEM_ALLOC_ERROR;
        return nullptr;
    }

    buffer->buff = (char*)calloc(buffer->buff_size, sizeof (char));
    if (fread (buffer->buff, sizeof (char), buffer->buff_size, in) != buffer->buff_size - 1) {
        perror ("READING FROM FILE ERROR");
        *error = READ_FILE_ERROR;
        return nullptr;
    }
    else {
        buffer->buff [buffer->buff_size - 1] = '\0';    //add \0 in the end
        return buffer;
    }
}


hash_table* ctor (void) {

    hash_table *new_table = (hash_table*)calloc(1, sizeof (hash_table));
    
    new_table->capacity = NUM_LISTS;

    new_table->arr = (node_ptr*)calloc (new_table->capacity, sizeof (node_ptr));
    if (new_table->arr == nullptr) {
        perror ("MEMMORY ALLOC TRUBLE");
        return nullptr;
    }

    return new_table;   
}


void dtor (hash_table **table) {

    assert ( table);
    assert (*table);

    (*table)->capacity  = 0;

    clear (*table);         //delete inner nodes

    free ((*table)->arr);
    (*table)->arr = nullptr;

    free (*table);
}


void clear (hash_table *table) {

    assert (table);

    for (int index = 0; index < table->capacity; ++index) {

        node *ptr = (table->arr + index)->tail;

        while (ptr != (table->arr + index)->head) {
            node *ptr_prev = ptr->prev;
            free (ptr);
            ptr = ptr_prev;
        }
        free (ptr);
        
        (table->arr + index)->head = nullptr;
        (table->arr + index)->tail = nullptr;
        (table->arr + index)->num_of_elem = 0;
    }
}


size_t get_file_size (FILE *in) {

    assert (in);

    struct stat buff = {};
    fstat (fileno (in), &buff);

    return buff.st_size;
}


size_t graph (hash_table *table) {

    assert (table);
    assert (table->arr);

    FILE *dump = fopen ("graphs/dump.txt", "wb");
    if (!dump) {
        perror ("COULDNT OPEN FILE GRAPH");
        return OPEN_FILE_ERROR;
    }

    fputs ("digraph structs {\n", dump);
    fputs ("node [style=filled,color=\"hotpink\"];\n\n", dump);

    for (size_t key = 0; key < table->capacity; ++key) {

        node *ptr = (*(table->arr + key)).head;

        if (ptr != nullptr)
            fprintf (dump, "\"%p\" [label=\"%ld\"]\n", table + key, key);

        while (ptr != nullptr) {
            fprintf (dump, "\"%p\" [label = \"%s\" ]\n ", ptr, ptr->word.s);

            if (ptr->prev != nullptr)
                fprintf (dump, " \"%p\"->\"%p\" \n", ptr->prev, ptr);
            else
                fprintf (dump, " \"%p\"->\"%p\" \n", table + key, ptr);

            ptr = ptr->next;
        }
        fprintf (dump, "\n\n\n");

    }
    fputs ("}", dump);
    
    if (fclose (dump)) {
        perror ("CLOSE FILE ERROR GRAPH");
        return CLOSE_FILE_ERROR;
    }

    if (system ("dot -Tpng graphs/dump.txt -o graphs/graph.png") != 0) {
        perror ("SYSTEM COMM ERROR GRAPH");
        return SYSTEM_COM_ERROR;
    }
    
    if (system (" export DISPLAY=\"$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0\" ") != 0) {
        perror ("SYSTEM COMM ERROR GRAPH");
        return SYSTEM_COM_ERROR;
    }    
    
    if (system ("shotwell graphs/graph.png") != 0) {
        perror ("SYSTEM COMM ERROR GRAPH");
        return SYSTEM_COM_ERROR;
    }
    return 0;
}
