MIPS Mersenne Scan Implementation - Kevin Jun

MIPS code passes all tests in project description. C code is functional and prints Mersenne primality as expected.

C Program:
	- Located in /src/ folder
	- Includes Makefile and mersenne.c implementation
	- Run by navigating to /src/ folder in terminal and input following:
		$ make
		$ ./mersenne

MIPS Program:
	- Contains all functions from project description
	- Four data segment Bigint are placed on heap and utilized for intermediary storage of mult_big, pow_big, sub_big, and mod_big
		- Interfaces have been changed for mult_big, sub_big, and mod_big:
			- Bigint a is passed by reference
			- Answer is written to Bigint on the heap
			- Answer is copied into Bigint a
		- pow_big is stored in data segment big_int2 - address to big_int2 is returned in $v0

	- Running
		- Load and run in QtSpim as normal
		- Test cases written in main function
		- Test case results print to console