#ifndef HASH_FUNC_HPP
#define HASH_FUNC_HPP


#include <stdio.h>
#include <string.h>
#include <assert.h>
#include "constants.hpp"


size_t hash_only_1     (void *ptr, size_t len);
size_t hash_first_symb (void *ptr, size_t len);
size_t hash_len        (void *ptr, size_t len);
size_t hash_sum_symb   (void *ptr, size_t len);
size_t hash_rol        (void *ptr, size_t len);
size_t hash_crc_32     (void *ptr, size_t len);

#endif