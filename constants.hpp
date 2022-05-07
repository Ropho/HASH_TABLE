#ifndef CONSTANTS_HPP
#define CONSTANTS_HPP

#define hash_ret_1
// #define hash_first_ASCII
// #define hash_len
// #define hash_sum
// #define hash_r_hash

#if defined hash_ret_1 || defined hash_first_ASCII || defined hash_len

    #define NUM_LISTS 255
    #define NUM_ELEM_IN_LIST 100
    #define NUM_TESTS 5

#elif defined hash_sum || defined hash_r_hash

    #define NUM_LISTS 2048
    #define NUM_ELEM_IN_LIST 100
    #define NUM_TESTS 5

#else
    
    #define NUM_LISTS 5000
    #define NUM_ELEM_IN_LIST 20
    #define NUM_TESTS 5

#endif
// #define NDEBUG

enum ERRORS {

    MEM_ALLOC_ERROR = 1,
    OPEN_FILE_ERROR = 2,
    READ_FILE_ERROR = 3,
    HASH_TABLE_NOT_FOUND_WORD = 4,
};


#endif