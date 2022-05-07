#ifndef HASH_FUNC_HPP
#define HASH_FUNC_HPP


#include <stdio.h>
#include <string.h>
#include <assert.h>
#include "constants.hpp"


size_t hash_only_1     (char *word);
size_t hash_first_symb (char *word);
size_t hash_len        (char *word);
size_t hash_sum_symb   (char *word);
size_t r_hash          (char *word);

#endif