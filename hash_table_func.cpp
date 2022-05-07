#include "hash_table_func.hpp"


size_t find_text_in_table (find_info *arr_word_pos, hash_table *table, text *buffer, size_t (*hash_func) (char *)) {

    for (int index = 0; index < buffer->num_of_words; ++index) {
        
        size_t key = hash_func (buffer->words[index]);
        arr_word_pos[index].key = key;
        arr_word_pos[index].num = find_word_in_table (buffer->words[index], key, buffer);
        
        if (arr_word_pos[index].num == 0)
            return 0;
        // printf ("key: %ld \t num: %ld\n", arr_word_pos[index].key, arr_word_pos[index].num);
    }

    return 1;
}

size_t find_word_in_table (char *word, size_t key, text *buffer) {

    size_t index = 0;

    for (index = 0; index < buffer->num_of_words; ++index) {
        if (strcmp (buffer->words[index], word) == 0)
            break;
    }

    if (index != buffer->num_of_words)
        return index + 1;
    else
        return 0;
}


void print_in_file (hash_table *table, FILE *csv) {

    assert (table != nullptr);
    assert (csv != nullptr);
    
    for (int index = 0; index < table->capacity; ++index) {

        int len = (table->arr[index]).num_of_elem;

        fprintf (csv, " %d,%d\n", index, len);

    }
}


void insert_in_list (hash_table *table,  size_t key, char *word) {
    
    node *ptr = (node*)calloc (1, sizeof (node));
    if (ptr == nullptr) {
        perror ("MEM ALLOC TROUBLE");
        assert (0);
    }
    ptr->s =  word;
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


void hash_table_fill (hash_table *table, text *buffer, size_t (*hash_func) (char *)) {

    for (int index = 0; index < buffer->num_of_words; ++index) {
        
        int hash = hash_func (*(buffer->words + index));
        insert_in_list (table, hash, (*(buffer->words + index)));
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


        buffer->words[buffer->num_of_words] = strt_wrd;
        ++buffer->num_of_words;
        
        if (*end_wrd == '\0')
            break;

        *end_wrd = '\0';
        end_wrd ++;
        strt_wrd = end_wrd;
        
    }
    
    // for (int index = 0; index < buffer->num_of_words - 1; ++index)
    //     printf ("%s\n", *(buffer->words + index));
    // puts ("\nEND of words\n");
}


text *read_from_file (FILE *in) {

    assert (in != nullptr);

    text *buffer = (text*)calloc(1, sizeof (text));
    if (buffer == nullptr)
        return nullptr;
    
    buffer->buff_size = get_file_size (in) + 1;     // add \0 IN THE END

    buffer->words = (char**)calloc(buffer->buff_size, sizeof (char*));
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
    new_table->capacity = CAPACITY;

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


// GRAPHVIZ IMPLEMENTATION

void graph (hash_table *table) {

    assert (table != nullptr);

    FILE *dump = fopen ("dump.txt", "wb");
    if (dump == nullptr) {
        perror ("COULDNT OPEN FILE");
        assert (0);
    }

    fputs ("digraph structs {\n", dump);
    fputs ("node [style=filled,color=\"hotpink\"];\n\n", dump);

    for (size_t key = 0; key < table->capacity; ++key) {

        node *ptr = (*(table->arr + key)).head;

        // fprintf (dump, "\"%p\" [shape=oval];\n", table + key);
        if (ptr != nullptr)
            fprintf (dump, "\"%p\" [label=\"%ld\"]\n", table + key, key);
        // fprintf (dump, "\"%p\" [style=filled,color=\"hotpink\"];", table + key);

        while (ptr != nullptr) {
            fprintf (dump, "\"%p\" [label = \"%s\" ]\n ", ptr, ptr->s);

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

    system ("dot -Tpng dump.txt -o graph.png");
    system (" export DISPLAY=\"$(grep nameserver /etc/resolv.conf | sed 's/nameserver //'):0\" ");
    system ("shotwell graph.png");
}
