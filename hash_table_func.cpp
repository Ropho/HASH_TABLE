#include ".h/hash_table_func.hpp"


size_t find_text_in_table (find_info *arr_word_pos, hash_table *table, text *buffer, size_t (*hash_func) (void *, size_t)) {

    for (int index = 0; index < buffer->num_of_words; ++index) {

        size_t key = hash_func ((buffer->words[index]).s, (buffer->words[index]).len);
        // size_t key = hash_crc_32_asm ((buffer->words[index]).s, (buffer->words[index]).len) % NUM_LISTS;

        arr_word_pos[index].key = key;
        // printf ("KEY: %ld\n", key);

#ifndef opt_find_word_asm
        arr_word_pos[index].num = find_word_in_table (buffer->words[index].s, key, table);
#else
        arr_word_pos[index].num = find_word (buffer->words[index].s, key, table);
#endif
        // printf ("word: %s \t key: %ld \t num: %ld\n", (buffer->words[index]).s, arr_word_pos[index].key, arr_word_pos[index].num);

        if (arr_word_pos[index].num == 0)
            return 0;
    }
    return 1;
}

size_t find_word_in_table (char *word, size_t key, hash_table *table) {

    size_t index = 0;
    // (table->arr + key)->head = (node *)calloc (1,sizeof(node));
    // (table->arr + key)->head->next = (node *)calloc (1,sizeof(node));
    node  *ptr = (table->arr + key)->head;
    // (table->arr + key)->head->word.s = "KEKKKKK";
    // char *word1 = "KEKKKKK";

    // printf ("%p\n", ptr->next);
    // size_t ret = find_word (word, key, table);
    // printf ("RET: \t %ld\n", ret);
    // return ret;
    // assert (0);


    while (ptr != nullptr) {

        ++index;

#ifndef opt_strcmp_asm
        if (strcmp (ptr->word.s, word) == 0) // NO_OPT
#else
        if (r_strcmp (ptr->word.s, word) == 0)  // OPT: asm func
#endif

            break;
        ptr = ptr->next;
    }

    if (ptr != nullptr) {
        // printf ("OUTPUT: \t %ld\n", index);
        return index;
    }

    else {
        // printf ("OUTPUT \t 0\n");
        return 0;
    }
}


void print_in_file (hash_table *table, FILE *csv) {

    assert (table != nullptr);
    assert (csv != nullptr);
    
    for (int index = 0; index < table->capacity; ++index) {

        int len = (table->arr[index]).num_of_elem;

        fprintf (csv, " %d;%d\n", index, len);

    }
}


void insert_in_list (hash_table *table,  size_t key, char *word) {
    
    node *ptr = (node*)calloc (1, sizeof (node));
    if (ptr == nullptr) {
        perror ("MEM ALLOC TROUBLE");
        assert (0);
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
}


void hash_table_fill (hash_table *table, text *buffer, size_t (*hash_func) (void *, size_t)) {

    for (int index = 0; index < buffer->num_of_words; ++index) {
        
        int hash = hash_func ((buffer->words + index)->s, (buffer->words + index)->len) % NUM_LISTS;
        // printf ("KEY: %ld\n", hash);

#ifndef opt_find_word_asm
        if (find_word_in_table ((buffer->words + index)->s, hash, table) == 0)
#else 
        if (find_word ((buffer->words + index)->s, hash, table) == 0)
#endif

            insert_in_list (table, hash, (buffer->words + index)->s);
    }
}


void words_arr_fill (text *buffer) {

    assert (buffer != nullptr);

    char *strt_wrd = buffer->buff;
    char *end_wrd  = buffer->buff;

    buffer->num_of_words = 0;
    
    if (strchr (strt_wrd, '\r') != nullptr)
        assert (0);

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
}


text *read_from_file (FILE *in) {

    assert (in != nullptr);

    text *buffer = (text*)calloc(1, sizeof (text));
    if (buffer == nullptr)
        return nullptr;
    
    buffer->buff_size = get_file_size (in) + 1;     // add \0 IN THE END

    buffer->words = (word*)calloc(buffer->buff_size, sizeof (word));
    if (buffer->words == nullptr) {
        perror ("ALLOCATION TROUBLE");
        return nullptr;
    }

    buffer->buff = (char*)calloc(buffer->buff_size, sizeof (char));
    if (fread (buffer->buff, sizeof (char), buffer->buff_size, in) != buffer->buff_size - 1)
        return nullptr;
    else {
        buffer->buff [buffer->buff_size - 1] = '\0';    //add \0 in the end
        return buffer;
    }
}


hash_table* ctor (void) {

    hash_table *new_table = (hash_table*)calloc(1, sizeof (hash_table));
    
    new_table->error    = 0;
    new_table->capacity = NUM_LISTS;

    new_table->arr = (node_ptr*)calloc (new_table->capacity, sizeof (node_ptr));
    if (new_table->arr == nullptr) {
        perror ("MEMMORY ALLOC TRUBLE");
        assert (0);
    }

    return new_table;   
}


void dtor (hash_table **table) {

    assert ( table != nullptr);
    assert (*table != nullptr);

    (*table)->capacity  = 0;
    (*table)->error     = 0;

    clear (*table);         //delete inner nodes

    free ((*table)->arr);
    (*table)->arr = nullptr;

    free (*table);
}


void clear (hash_table *table) {

    assert (table != nullptr);

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

    assert (in != nullptr);

    struct stat buff = {};
    fstat (fileno (in), &buff);

    return buff.st_size;
}


void graph (hash_table *table) {

    assert (table != nullptr);

    FILE *dump = fopen ("graphs/dump.txt", "wb");
    if (dump == nullptr) {
        perror ("COULDNT OPEN FILE");
        assert (0);
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
    fclose (dump);

    if (system ("dot -Tpng graphs/dump.txt -o graphs/graph.png") != 0)
        assert (0);
    if (system (" export DISPLAY=\"$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0\" ") != 0)
        assert (0);
    if (system ("shotwell graphs/graph.png") != 0)
        assert (0);
}
