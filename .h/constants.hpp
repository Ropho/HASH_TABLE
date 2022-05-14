#ifndef CONSTANTS_HPP
#define CONSTANTS_HPP

// #define HASH_RET_1
// #define HASH_FIRST_ASCII
// #define HASH_LEN
// #define HASH_SUM
// #define HASH_ROL
#define HASH_CRC_32


#define opt_strcmp_asm
// #define opt_find_word_asm
#define opt_hash_asm


#define TEXT
// #define MEM
// #define HAMLET

#define NUM_LISTS 1024
#define NUM_ELEM_IN_LIST 20
#define NUM_TESTS 5


// #define NDEBUG

enum ERRORS {

    MEM_ALLOC_ERROR = 1,
    OPEN_FILE_ERROR = 2,
    READ_FILE_ERROR = 3,
    HASH_TABLE_NOT_FOUND_WORD = 4,
};


#endif