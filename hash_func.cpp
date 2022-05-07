#include "hash_func.hpp"


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


size_t hash_only_1 (char *word) {
    return 1;
}


size_t hash_first_symb (char *word) {
    return (size_t) (*word % NUM_LISTS);
}


size_t hash_len (char *word) {
    return strlen (word) % NUM_LISTS;
}


size_t hash_sum_symb (char *word) {

    char *ptr = word;
    size_t key = 0;

    while (*ptr != '\0') {
        key += *ptr;
        ++ptr;
    }

    return key % NUM_LISTS;
}

