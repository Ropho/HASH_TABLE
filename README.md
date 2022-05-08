# HASH_TABLE

## TABLE CAPACITY
  + > We wanna have max **20 elements** in 1 list with a good hash func, 
  + > so in accordance with having a text with **24000 Unique words**
  + > We will have approximately **1024 lists**
  + > *That is a fixed size used in all the testing* 

## USING
1. Time counter
  > time "linux"

## TESTING
  
  > 1. filling the buffer up with Hamlet from file
  > 2. filling the char pointer array up with the words
  > 3. filling the table with the char pointer array

## STRESS TEST
  >   > 4. finding the position of all the words from the text in Hamlet **FIVE TIMES**
  
  > 5. clearing the table

Before optimizations analysis:
------------------------------

## HASH FUNCTIONS

### 1.  **Return 1**

  * Fast description
  > function is a very bad example of a hash function due to its collisions. 

<img src="/pic/ret1.png" alt="RET1" title="RET1" width="720" height="480"/>

### 2.  **First ASCII**
  
  * Fast description
  > function is better than *return 1*, as it can give out multiple values but has a small variety of keys (only 255 of desired 1024) and very high percent of collisions, so cannot be a good hash function. 

### 3.  **Len of word**
  
  * Fast description
  > like the previous function has a small variety of keys (only 255 of desired 1024) and very high percent of collisions cause words lengths are rather limited, so cannot be a good hash function. 

### 4.  **Sum of ASCII**
  
  * Fast description
  > a better function than previous ones. Covers all the given 1024 keys, but has some roblems with smoothness (has maximums and minimums which are easily distinguished, so has up to 80 elements in list (desired 20). Still cannot be a good hash function.

### 5.  **ROL**
  
  * Fast description
  > like the previous function has a small variety of keys (only 255 of desired 1024) and very high percent of collisions cause words lengths are rather limited, so cannot be a good hash function. 


### 6.  **CRC 32**
  
  * Fast description
  > like the previous function has a small variety of keys (only 255 of desired 1024) and very high percent of collisions cause words lengths are rather limited, so cannot be a good hash function. 

Dispersion values for different hash functions:

|-------------|------------|
| hash func   | dispersion |
|-------------|------------|
| ret_1       | 589296     |
|-------------|------------|
| first ASCII | 23043      |
|-------------|------------|
| len         | 65230      |
|-------------|------------|
| sum ASCII   | 351        |
|-------------|------------|
| rol         | 87         |
|-------------|------------|
| crc32       | 17         |
|-------------|------------|

### **As expected, the best parametres has a *CRS 32* function**

|---------------------------------------------------------------|

## Optimization

