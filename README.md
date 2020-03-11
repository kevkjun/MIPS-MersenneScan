# MIPS-MersenneScan
## README
Kevin Jun

March 10, 2020

### Files
* `mersenne.c` and associated Makefile to implement Mersenne Scan in C
* `mersenne.asm`: MIPS assembly to be run in QtMips
* `output.txt`: console output from `mersenne.asm`

**Running `mersenne.c`**
```
$ cd ../MIPS-MersenneScan
$ make
$ ./mersenne
```

**Running `mersenne.asm`**
* Load `mersenne.asm` into QtSpim
* Run
    * Test cases will print to console
    * Will use LLT algorithm to scan through Mersenne numbers for $3 \leq p \leq 128$
