# MIPS-MersenneScan
## README
Kevin Jun

March 10, 2020

### Background
#### Mersenne Primes
Mersenne primes are special prime numbers of the form:

<p align="center">
   M<sub>p</sub> = 2<sup>p</sup> - 1
</p>

where *M*<sub>p</sub> is the Mersenne prime and *p* is a smaller prime number.

* Utilizes *Lucas-Lehmer Test* to check possible Marsenne prime (M<sub>p</sub>) for primacy given a prime number *p*

### Files
* `mersenne.c` and associated Makefile to implement Mersenne Scan in C
* `mersenne.asm`: MIPS assembly to be run in QtMips 
* `output.txt`: console output from `mersenne.asm`

**Running `mersenne.c`**
Checks primality of Mersenne numbers for 2 &le; p &lt; 550 
```
$ cd ../MIPS-MersenneScan
$ make
$ ./mersenne
```

**Running `mersenne.asm`**
* Load `mersenne.asm` into QtSpim
* Run
    * Test cases will print to console
    * Will use LLT algorithm to check primality of Mersenne numbers for 3 &le; p &le; 128 
