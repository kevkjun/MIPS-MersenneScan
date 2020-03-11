# MIPS-MersenneScan
## README
Kevin Jun

March 10, 2020

### Background
Mersenne primes are special prime numbers of the form:

<p align="center">
   M<sub>p</sub> = 2<sup>p</sup> - 1
</p>

where *M*<sub>p</sub> is the Mersenne prime and *p* is a smaller prime number. 

The *Lucas-Lehmer Test* is a test for primality of an *M*<sub>p</sub> value that runs in *O(p)* time rather than *O(M*<sub>p</sub>*)*. 

```C
// Determine if Mp = 2^p - 1 is prime for p > 2
int Lucas_Lehmer_Test(int p)
{
   int s = 4;
   int Mp = pow(2,p) - 1;
   for (int i = 0; i < p-2; i++)
      s = ((s * s) - 2) % Mp;
   if (s == 0)
      return 1; //prime
   else
      return 0; //not prime
}
```

### Implementation
* Uses *Bigint* struct which stores large numbers as array to circumvent overflow for large *M*<sub>p</sub> values
```C
// Bigint interface
typedef struct
{
	int n;                  // Number of active digits stored
	int digits[MAX_DIGITS]; // Stores the digits in little endian order
} Bigint;
```
* Mersenne scan implementations in C and MIPS Assembly
* MIPS implementation utilizes the stack, heap, and registers

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
