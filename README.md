# HASH_TABLE

## TABLE CAPACITY
  > We wanna have max **20 elements** in 1 list, 
  > so in accordance with having a text with **24000 Unique words**
  > We will have approximately **1024 lists**
  > *That is a fixed size used in all the testing* 

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

  * Number of lists
  > 255, used only 1
  * Fast description
  > function is a very bad example of a hash function due to its collisions. 

<img src="/pic/ret1.png" alt="RET1" title="RET1" width="720" height="480"/>
2. 
