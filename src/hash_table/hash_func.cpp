#include "../.h/hash_func.hpp"
#include "../.h/crctable.hpp"


size_t hash_crc_32 (void* ptr, size_t len) {

    assert (ptr != nullptr);
    
    char *str = (char*)ptr;

    size_t key = 0xFFFFFFFFUL;

    while (*str != '\0') {

        key = CRCTable[(key ^ *(str)) & 0xFF] ^ (key >> 8);
        str++;
    }

    return key;
}



size_t hash_rol (void *ptr, size_t len) {
    
    assert (ptr != nullptr);

    char *word = (char *)ptr;

    size_t hash = *word;
    word++;

    for (int index = 0; index < len; ++index) {
        hash = ((hash << 1) | (hash >> 31)) ^ *word;

        ++word;
    }

    return hash % NUM_LISTS;
}


size_t hash_only_1 (void *ptr, size_t len) {
    return 1;
}


size_t hash_first_symb (void *ptr, size_t len) {
    return (size_t) ((*((char *)(ptr))) % NUM_LISTS);
}


size_t hash_len (void *ptr, size_t len) {
    return len % NUM_LISTS;
}


size_t hash_sum_symb (void *ptr, size_t len) {

    assert (ptr != nullptr);

    char *symb = (char *)ptr;
    size_t key = 0;

    while (*symb != '\0') {
        key += *symb;
        ++symb;
    }

    return key % NUM_LISTS;
}

