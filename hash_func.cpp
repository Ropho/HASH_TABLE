#include "hash_func.hpp"
#include "crctable.hpp"

size_t hash_crc_32 (void *ptr, size_t len) {
    
    assert (ptr != nullptr);

    char *word = (char *)ptr;

    unsigned int crc = 0xFFFFFFFFUL;

    for (int symb = 0; symb < len; symb++)
        crc = CRCTable [(crc ^ *(word + symb)) & 0xFF] ^ (crc >> 8);
 
    return crc % NUM_LISTS; 
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


static size_t rotl (size_t n) {

        size_t d = 13;
        n *= d;
        return (n << d)|(n >> (32 - d));
    }


size_t r_hash (char *word) {

        assert (word != nullptr);
        
        size_t hash = 0x1337;

        int len = strlen (word);
        for (int index = 0; index < len; ++index) {
            hash ^= rotl (*(word + index));
        }

        //avalanche
        hash ^= (hash >> 16);
        hash *= 0x85ebca6b;
        hash ^= (hash >> 13);
        hash *= 0xc2b2ae35;
        hash ^= (hash >> 16);
        
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

