## LLT implementation in MIPS
## Caller saves/restores $t0-t8, $a0-a3, $v0-v1
## Callee saves/restores $s0-s7, $ra

    .data
## allocated four Bigint to be reused by mult_big, pow_big, sub_big, mod_big
## first word is the number of digits. other 350 are the possible digits

big_int1: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

big_int2: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

big_int3: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

big_int4: .word 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

## Text for test cases ##

small_prime_msg: .asciiz "Small Prime Tests\n"
compress_msg: .asciiz "Compress Tests\n"
srt_msg: .asciiz "Shift Right Test\n"
slt_msg: .asciiz "Shift Left Test\n"
comp_test_msg: .asciiz "Comparison Tests\n"
mult_msg: .asciiz "Multiply Tests\n"
pow_msg: .asciiz "Power Tests\n"
sub_msg: .asciiz "Subtraction Tests\n"
mod_msg: .asciiz "Modulus Tests\n"
LLT_msg: .asciiz "LLT Tests\n"
mersenne_msg: .asciiz "Mersenne Scan\n"
testing: .asciiz "Testing p = "
found: .asciiz " found prime Mp = "
not_prime: .asciiz " Mp not prime\n"
newline: .asciiz "\n"
    .text

main:           
## test is_small_prime
    la $a0, small_prime_msg     ## load small prime test message
    li $v0, 4                   ## load syscall for print string
    syscall                     ## print small prime test message
    li $a0, 7                   ## test p = 7 if it is prime - expected 1
    jal is_small_prime
    move $a0, $v0               ## prime return int to print
    li $v0, 1                   ## load syscall for print int
    syscall                     ## print returning int
    la $a0, newline             ## load newline
    li $v0, 4                   ## load syscall for print string
    syscall                     ## print newline
    li $a0, 81                  ## test p = 81 if it is prime - expected 0
    jal is_small_prime
    move $a0, $v0               ## prime return int to print
    li $v0, 1                   ## load syscall for print int
    syscall                     ## print returning int
    la $a0, newline             ## load newline
    li $v0, 4                   ## load syscall for print string
    syscall                     ## print newline
    li $a0, 127                 ## test p = 127 if it is prime - expected 1
    jal is_small_prime
    move $a0, $v0               ## prime return int to print
    li $v0, 1                   ## load syscall for print int
    syscall                     ## print returning int
    la $a0, newline             ## load newline
    li $v0, 4                   ## load syscall for print string
    syscall                     ## print newline

## test compress
    la $a0, compress_msg        ## print compress test message
    li $v0, 4
    syscall
    li $a0, 3                   ## load 3 into $a0
    jal digit_to_big            ## create Bigint(3)
    move $a0, $v0               ## move Bigint to $s0
    li $t0, 4                   ## load 4 into $t0
    sw $t0, ($a0)               ## make Bigint(0003)
    jal compress                ## attempt to compress 0003
    jal print_big               ## attempt to print 3
    addi $sp, $sp, 1404         ## deallocate the created Bigint

## test shift_right - initialize Bigint(3), shift right 3 times, print (expected: 3000)
    la $a0, srt_msg             ## load shift_right_test_msg
    li $v0, 4                   ## print the message
    syscall
    li $a0, 3                   ## load 3 into $a0
    jal digit_to_big            ## create Bigint 3
    move $a0, $v0               ## move Bigint 3 to $a0 to call shift_right
    jal shift_right             ## shift right by one place
    jal shift_right
    jal shift_right
    jal print_big               ## print the Bigint
    addi $sp, $sp, 1404         ## deallocate the created Bigint

## test shift_left - initialize BigInt(7000), shift left 2 times, print (expected: 70)
    la $a0, slt_msg             ## load shift_right_test_msg
    li $v0, 4                   ## print the message
    syscall
    li $a0, 7                   ## load 7 into $a0
    jal digit_to_big            ## create Bigint 7
    move $a0, $v0               ## move Bigint 7 to $a0 to call shift_right
    jal shift_right             ## shift right by one place
    jal shift_right
    jal shift_right             ## Bigint is now 7000
    jal shift_left
    jal shift_left              ## Bigint should now be 70
    jal print_big               ## should print 70
    addi $sp, $sp, 1404         ## deallocate Bigint

## test compare_big
    la $a0, comp_test_msg       ## load comparison test msg
    li $v0, 4                   ## print msg
    syscall
    li $a0, 4                   ## load 4 to create Bigint
    jal digit_to_big            ## create Bigint(4)
    move $a0, $v0               ## move from return register to $a0
    jal shift_right             ## multiply by 10 to get 40
    li $s0, 2                   ## load 2 to create 42
    sw $s0, 4($a0)              ## make Bigint 42
    move $s0, $a0               ## move 42 to $s0
    li $a0, 3                   ## load 3 to create Bigint
    jal digit_to_big            ## create Bigint(3)
    move $a0, $v0
    jal shift_right             ## create Bigint(30)
    move $s1, $a0               ## move 30 to $s1
    move $a0, $s0               ## load 42 to $a0
    move $a1, $s1               ## load 30 to $a1
    jal compare_big             ## call compare(42, 30) - should print 1
    move $a0, $v0               ## load answer to print
    li $v0, 1                   ## print int
    syscall
    la $a0, newline             ## print newline
    li $v0, 4
    syscall
    move $a0, $s1               ## load 30 to $a0
    move $a1, $s0               ## load 42 to $a1
    jal compare_big             ## call compare(30, 42) - should print -1
    move $a0, $v0               ## load answer to print
    li $v0, 1                   ## print int
    syscall
    la $a0, newline             ## print newline
    li $v0, 4
    syscall
    move $a0, $s0               ## load 42 to $a0
    move $a1, $s0               ## load 42 to $a1
    jal compare_big             ## call compare(42, 42) - should print 0
    move $a0, $v0               ## load answer to print
    li $v0, 1                   ## print int
    syscall
    la $a0, newline             ## print newline
    li $v0, 4
    syscall
    addi $sp, $sp, 2808         ## deallocate 2 Bigint

## test mult_big
    la $a0, mult_msg            ## load mult test message
    li $v0, 4                   ## print message
    syscall
    li $a0, 7                   ## create Bigint 7
    jal digit_to_big
    move $s0, $v0               ## store pointer to 7 in $s0
    li $a0, 3                   ## create Bigint 3
    jal digit_to_big
    move $a1, $s0               ## load Bigint 7 to $a1
    move $a0, $v0               ## load Bigint 3 to $a0
    jal mult_big                ## call mult_big - should put 21 in $a0
    jal print_big               ## print 21
    addi $sp, $sp, 1404         ## deallocate 21
    li $a0, 6                   ## create Bigint 6
    jal digit_to_big
    move $a0, $s0               ## load Bigint 7 to $a0
    move $a1, $v0               ## load Bigint 6 to $a1
    jal mult_big                ## 7*6 - should put 42 in $a0
    move $s1, $a0               ## store Bigint 42 in $s1
    li $a0, 3                   ## create Bigint 3
    jal digit_to_big
    move $a0, $v0               ## load Bigint 3 to $a0
    jal shift_right             ## create Bigint 30
    move $a1, $s1               ## load Bigint 42 to $a1
    jal mult_big                ## 30 * 42 - Bigint 1260 should be in $a0
    jal print_big
    addi $sp, $sp, 4212         ## deallocate 3 Bigint: 1260, 6, 42
    li $a0, 1                   ## create Bigint 1
    jal digit_to_big
    move $a0, $v0               ## load Bigint 1 to $a0
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    move $s0, $a0               ## Bigint 10,000,000 should be stored in $s0
    li $a0, 9                   ## create Bigint 9
    jal digit_to_big
    move $a0, $v0               ## move Bigint 9 to $a0
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    move $a1, $a0               ## move Bigint 9,000,000 to $a1
    move $a0, $s0               ## move Bigint 10,000,000 to $a0
    jal mult_big                ## 10,000,000 * 9,000,000 should be in $a0
    jal print_big               ## print Bigint 
    addi $sp, $sp, 2808         ## deallocate 2 Bigint: 9,000,000 and 42

## test pow_big
    la $a0, pow_msg             ## load pow test message
    li $v0, 4                   ## print message
    syscall
    li $a0, 3                   ## create Bigint 3
    jal digit_to_big
    move $a0, $v0               ## load Bigint 3 to $a0
    li $a1, 4                   ## load 4 to $a1
    jal pow_big                 ## Bigint(3)^4
    move $a0, $v0               ## print Bigint(3)^4
    jal print_big
    addi $sp, $sp, 1404         ## deallocate Bigint 3
    li $a0, 4                   ## create Bigint 4
    jal digit_to_big
    move $a0, $v0               ## load Bigint 4 to $a0
    jal shift_right             ## create Bigint 40
    li $v0, 2                   ## load 2 in $v0
    sw $v0, 4($a0)              ## create Bigint 42
    li $a1, 42                  ## load 42 to $a1
    jal pow_big                 ## Bigint(42)^42
    move $a0, $v0               ## print Bigint(42)^42
    jal print_big
    addi $sp, $sp, 1404         ## deallocate Bigint(42)^42

## test sub_big
    la $a0, sub_msg             ## load sub test message
    li $v0, 4                   ## print message
    syscall
    li $a0, 7                   ## create Bigint 7
    jal digit_to_big
    move $s0, $v0               ## move Bigint(7) to $s0
    li $a0, 3                   ## create Bigint 3
    jal digit_to_big
    move $a1, $v0               ## move Bigint(3) to $a1
    move $a0, $s0               ## move Bigint(7) to $a0
    jal sub_big                 ## 7 - 3: expect 4
    move $s0, $a0
    jal print_big               ## print Bigint(4)
    move $a0, $s0
    addi $sp, $sp, 1404         ## deallocate Bigint 3
    jal shift_right             ## create Bigint(40)
    li $v0, 2                   ## load 2 in $v0
    sw $v0, 4($a0)              ## create Bigint 42
    move $s0, $a0               ## move Bigint(42) to $s0
    li $a0, 1                   ## create Bigint(1)
    jal digit_to_big
    move $a0, $v0               ## move Bigint(1) to $a0
    jal shift_right             ## create Bigint(10)
    li $v0, 2                   ## load 2 in $v0
    sw $v0, 4($a0)              ## create Bigint 12
    move $a1, $a0               ## load Bigint(12) to $a1
    move $a0, $s0               ## load Bigint(42) to $a0
    jal sub_big                 ## 42 - 12: should be Bigint(30)
    jal print_big               ## print 30
    addi $sp, $sp, 2808         ## deallocate 2 Bigint(12) and Bigint(30)
    li $a0, 9                   ## create Bigint 9
    jal digit_to_big
    move $a0, $v0               ## move Bigint(9) to $s0
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right             ## Bigint 9,000,000,000 should be in $a0
    move $s0, $a0               ## move to $s0
    li $a0, 7                   ## create Bigint 7
    jal digit_to_big
    move $a0, $v0               ## move Bigint(7) to $a0
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right             ## Bigint 7,000,000 sbould be in $a0
    li $t0, 1                   ## load 1 in $t0
    sw $t0, 4($a0)              ## put 1 in Bigint
    li $t0, 2                   ## load 2
    sw $t0, 8($a0)              ## load 2 in $t0
    li $t0, 3                   ## load 3
    sw $t0, 12($a0)             ## load 3 in $t0
    li $t0, 4                   ## load 4
    sw $t0, 16($a0)             ## load 4 in $t0
    li $t0, 5                   ## load 5
    sw $t0, 20($a0)             ## load 5 in $t0
    li $t0, 6                   ## load 6
    sw $t0, 24($a0)             ## load 6 in $t0
    move $a1, $a0               ## move Bigint(7,654,321) to $a1
    move $a0, $s0               ## move 9,000,000,000 to $a0
    jal sub_big
    jal print_big
    addi $sp, $sp, 2808         ## deallocate 2 Bigint

## test mod_big
    la $a0, mod_msg             ## load mod test message
    li $v0, 4                   ## print message
    syscall
    li $a0, 7                   ## create Bigint 7
    jal digit_to_big
    move $s0, $v0               ## move Bigint(7) to $s0
    li $a0, 3                   ## create Bigint 3
    jal digit_to_big
    move $a1, $v0               ## move Bigint(3) to $a1
    move $a0, $s0               ## move Bigint(7) to $a0
    jal mod_big                 ## 7 % 3 - should place 1 in $a0
    jal print_big               ## should print 1
    addi $sp, $sp, 2808         ## deallocate 2 Bigint
    li $a0, 4                   ## create Bigint 4
    jal digit_to_big
    move $a0, $v0               ## move Bigint(4) to $a0
    jal shift_right             ## make Bigint(40)
    li $t0, 8                   ## load 8
    sw $t0, 4($a0)              ## make Bigint(48)
    move $s0, $a0               ## move Bigint(48) to $s0
    li $a0, 1                   ## create Bigint 1
    jal digit_to_big
    move $a0, $v0               ## move Bigint(1) to $a0
    jal shift_right             ## make Bigint(10)
    li $t0, 2                   ## load 2
    sw $t0, 4($a0)              ## make Bigint(12)
    move $a1, $a0               ## move Bigint(12) to $a1
    move $a0, $s0               ## move Bigint(48) to $a0
    jal mod_big                 ## 48 % 12
    jal print_big               ## should print 0
    addi $sp, $sp, 2808         ## deallocate 2 Bigint
    li $a0, 9                   ## create Bigint 9
    jal digit_to_big
    move $a0, $v0               ## move Bigint(9) to $s0
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right             ## Bigint 9,000,000,000 should be in $a0
    move $s0, $a0               ## move to $s0
    li $a0, 7                   ## create Bigint 7
    jal digit_to_big
    move $a0, $v0               ## move Bigint(7) to $a0
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right
    jal shift_right             ## Bigint 7,000,000 sbould be in $a0
    li $t0, 1                   ## load 1 in $t0
    sw $t0, 4($a0)              ## put 1 in Bigint
    li $t0, 2                   ## load 2
    sw $t0, 8($a0)              ## load 2 in $t0
    li $t0, 3                   ## load 3
    sw $t0, 12($a0)             ## load 3 in $t0
    li $t0, 4                   ## load 4
    sw $t0, 16($a0)             ## load 4 in $t0
    li $t0, 5                   ## load 5
    sw $t0, 20($a0)             ## load 5 in $t0
    li $t0, 6                   ## load 6
    sw $t0, 24($a0)             ## load 6 in $t0
    move $a1, $a0               ## move Bigint(7,654,321) to $a1
    move $a0, $s0               ## move 9,000,000,000 to $a0
    jal mod_big                 ## 9,000,000,000 % 7,654,321
    jal print_big               ## should print 6,172,825
    addi $sp, $sp, 2808         ## deallocate 2 Bigint

## test LLT
    la $a0, LLT_msg             ## print LLT test message
    li $v0, 4
    syscall
    li $a0, 11                  ## load p = 11 to $a0
    jal LLT
    move $a0, $v0               ## move prime flag to $a0
    li $v0, 1                   ## print int
    syscall
    la $a0, newline             ## print newline
    li $v0, 4
    syscall
    li $a0, 61                  ## load p = 61 to $a0
    jal LLT
    move $a0, $v0               ## move prime flag to $a0
    li $v0, 1                   ## print int
    syscall
    la $a0, newline             ## print newline
    li $v0, 4
    syscall

## mersenne scan
    la $a0, mersenne_msg        ## print mersenne message
    li $v0, 4
    syscall
    jal mersenne_scan           ## mersenne scan

## exit
    li $v0, 10
    syscall

######################################################
## BEGIN CLEAR_BIG ##
# return: clears big_int stored in $a0
# $a0: caller-provided pointer to base of big_int
# $t0: counter
# $t1: big_int # of digits
######################################################
clear_big:                 
    li $t0, 0                   ## init counter
    lw $t1, ($a0)               ## set upper bound ($t1) for loop (# of digits in big_int)
clear_loop:                     ## loop to clear all values in big_int
    bgt $t0, $t1, clear_exit    ## check if counter <= c.n - needs to be <= because need to copy over c.n
    sw $0, ($a0)                ## clear big_int1
    addi $a0, $a0, 4            ## increment to next element in big_int1
    addi $t0, $t0, 1            ## increment counter
    j clear_loop                ## jump to beginning of loop
clear_exit:
    jr $ra                      ## return

######################################################
## BEGIN COMPRESS ##
# return: changes caller-provided Bigint a
# $a0: caller-provided pointer to base of Bigint a
# $t0: a.n
# $t1: counter
# $t2: address of a.digits[i]
# $t3: digits of Bigint
######################################################
compress:       
    lw $t0, 0($a0)              ## load the # of digits of Bigint a
    sub $t1, $t0, 1             ## subtract one from the # of digits to get the counter
    li $t2, 4                   ## load 4 to $t2 to multiply
    mul $t2, $t2, $t0           ## find 4 * number of digits (number of bytes to move pointer)
    add $t2, $t2, $a0           ## go to biggest digit in Bigint
compress_loop:  
    blt $t1, $0, compress_exit  ## exit for loop if counter is less than 0
    lw $t3, ($t2)               ## $t3 = a.digits[i]
    bne $t3, $0, compress_exit  ## short-circuit to end if a.digits[i] != 0
    beq $t1, $0, compress_exit  ## jump to end if i == 0
    sub $t0, $t0, 1             ## a.n -= 1
    sw $t0, 0($a0)              ## a.n -= 1
    sub $t1, $t1, 1             ## decrement the counter
    sub $t2, $t2, 4             ## increment towards front of a.digits
    j compress_loop             ## jump to beginning of loop
compress_exit:  
    jr $ra                      ## return to jump-from address

######################################################
## BEGIN DIGIT_TO_BIG ## 
# return: pointer to Bigint b ($v0)
# $a0: caller-provided int a
# $t0: tmp register to store values
# $t1: counter
# $t2: store 1404 (3 1 * 4) = size of Bigint
######################################################
digit_to_big:
    li $t2, 1404                ## load 1404 (size of Bigint) to $t2
    li $t1, 0                   ## init counter
    li $t0, 0
digit_loop:
    bge $t1, $t2, digit_end     ## check if counter is above 1404 (size of Bigint on stack)               
    sub $sp, $sp, 4             ## move stack pointer down
    sw $t0, ($sp)               ## load 0 onto stack
    addi $t1, 4                 ## increment counter
    j digit_loop                ## loop
digit_end:
    move $v0, $sp               ## store address of stack pointer in $v0
    li $t0, 1                   ## $t0 = 1
    sw $t0, 0($sp)              ## b.n = 1
    move $t0, $a0               ## $t0 = $a0 (int a)
    sw $t0, 4($sp)              ## b.digits[0] = a
    jr $ra                      ## return to jump-from address

######################################################
## BEGIN PRINT_BIG ##
## REUSES $A0 - MUST SAVE $A0 BEFORE CALLING PRINT_BIG ##
# return: print to console
# $a0: caller-provided pointer to Bigint b
# $t0: counter
# $t1: address to b.digits[counter]
######################################################
print_big:   
    lw $t0, ($a0)               ## load number of digits of b into $t0
    li $t1, 4                   ## load 4 to $t1 to multiply by b.n
    mul $t1, $t1, $t0           ## multiply 4 by number of items in b.digits
    add $t1, $t1, $a0           ## set $t1 to a.digits[i]
    sub $t0, $t0, 1             ## init counter to b.n - 1
print_loop:     
    blt $t0, $0, print_exit     ## check if c >= 0
    lw $a0, ($t1)               ## load digit to $a0
    li $v0, 1                   ## print int to console
    syscall
    sub $t0, $t0, 1             ## decrement counter
    sub $t1, $t1, 4             ## move inwards towards a.digits[0] by one number
    j print_loop
print_exit:     
    la $a0, newline             ## move newline to sysout register
    li $v0, 4                   ## load syscall code to print string
    syscall
    jr $ra                      ## return to jump-from address

######################################################
## BEGIN IS_SMALL_PRIME ##
# return: 1 if prime and 0 otherwise in $v0
# $a0: caller-provided pointer to int p
# $t0: for loop limit
# $t1: counter
# $t2: holder for p % i
######################################################
is_small_prime:
    move $t0, $a0               ## move p to $t0
    sub $t0, $t0, 1             ## init limit for i
    li $t1, 2                   ## init counter to 2
s_p_loop:
    bge $t1, $t0, s_p_exit      ## check if i < p-1 ($t1 < $t0)
    div $a0, $t1                ## p % i
    mfhi $t2                    ## store p % i
    addi $t1, $t1, 1            ## i++
    bne $t2, $0, s_p_loop       ## jump to beginning of loop if (p % i != 0)
    li $v0, 0                   ## return 0 if (p % i == 0)
    jr $ra                      ## return to jump-from address
s_p_exit:
    li $v0, 1                   ## load 1 to return address
    jr $ra                      ## return to jump-from address

######################################################
## BEGIN SHIFT_RIGHT ##
# starts pointers at a.digits[i] and a.digits[i-1] and moves them inwards until counter == 0
# return: Bigint shifted right by one place (multiplied by 10) - Bigint remains in $a0 register
# $a0: caller-provided pointer to Bigint a
# $t0: counter and tmp register for a.n to increment at end
# $t1: address of a.digits[i-1]
# $t2: tmp register for a.digits[i-1]
######################################################
shift_right:
    lw $t0, ($a0)               ## init counter to a.n
    li $t1, 4                   ## load 4 to $t1 to multiply by a.n
    mul $t1, $t1, $t0           ## multiply 4 by number of items in a.digits
    add $t1, $t1, $a0           ## set $t1 to a.digits[i-1]
sr_loop:
    ble $t0, $0, sr_exit        ## check if i > 0
    lw $t2, ($t1)               ## load a.digits[i-1]
    sw $t2, 4($t1)              ## a.digits[i] = a.digits[i-1]
    sub $t1, $t1, 4             ## move pointer to a.digits[i-2]
    sub $t0, $t0, 1             ## decrement counter
    j sr_loop                   ## jump to beginning of loop
sr_exit:
    sw $0, 4($a0)               ## a.digits[0] = 0
    lw $t0, ($a0)               ## load a.n
    addi $t0, $t0, 1            ## increment a.n
    sw $t0, ($a0)               ## a.n += 1
    jr $ra                      ## return to jump-from address

######################################################
## BEGIN SHIFT_LEFT ##
# return: Bigint shifted left by one place (divided by 10) - Bigint remains in $a0 register
# $a0: caller-provided pointer to Bigint a
# $t0: counter
# $t1: a.n
# $t2: address of a.digits[i]
# $t3: tmp register for a.digits[i]
######################################################
shift_left:
    lw $t1, ($a0)               ## init $t1 to a.n
    beq $t1, $0, sl_if          ## jump to loop if a.n != 0
    li $t0, 0                   ## init counter to 0
    addi $t2, $a0, 4            ## move $t2 pointer to a.digits[0]
sl_loop:
    bge $t0, $t1, sl_exit       ## check if i < a.n
    lw $t3, 4($t2)              ## load a.digits[i+1]
    sw $t3, ($t2)               ## a.digits[i] = a.digits[i+1]
    addi $t2, $t2, 4            ## move to next digit
    addi $t0, $t0, 1            ## increment the counter
    j sl_loop                   ## jump to beginning of loop
sl_exit:
    sub $t1, $t1, 1             ## decrement a.n
    sw $t1, ($a0)               ## a.n -= 1
    jr $ra                      ## return to jump-from address
sl_if:
    jr $ra                      ## return to jump-from address if a.n == 0

######################################################
## BEGIN COMPARE_BIG ##
# return: in $v0: -1 if a < b | 0 if a == b | 1 if a > b
# $a0: caller-provided pointer to Bigint a
# $a1: caller-provided pointer to Bigint b
# $t0: a.n
# $t1: b.n
# $t2: counter
# $t3: pointer to a.digits[i]
# $t4: a.digits[i]
# $t5: pointer to b.digits[i]
# $t6: b.digits[i]
######################################################
compare_big:
    lw $t0, ($a0)               ## $t0 = a.n
    lw $t1, ($a1)               ## $t1 = b.n
    blt $t0, $t1, comp_less     ## jump if a.n < b.n
    bgt $t0, $t1, comp_greater  ## jump if a.n > b.n
    lw $t2, ($a0)               ## $t2 = a.n for the counter
    li $t3, 4                   ## load 4 to get a.digits[i]
    mul $t3, $t3, $t0           ## 4 * (a.n - 1)
    add $t3, $t3, $a0           ## a.digits[i]
    sub $t2, $t2, 1             ## init counter
    li $t5, 4                   ## load 4 to get b.digits[i]
    mul $t5, $t5, $t1           ## 4 * b.n
    add $t5, $t5, $a1           ## b.digits[i]
comp_for:
    blt $t2, $0, comp_equal     ## check if i >= 0
    lw $t4, ($t3)               ## load a.digits[i]
    lw $t6, ($t5)               ## load b.digits[i]
    bgt $t4, $t6, comp_greater  ## if a.digits[i] > b.digits[i]
    blt $t4, $t6, comp_less     ## if a.digits[i] < b.digits[i]
    sub $t2, $t2, 1             ## decrement counter
    sub $t3, $t3, 4             ## decrement a.digits index
    sub $t5, $t5, 4             ## decrement b.digits index
    j comp_for                  ## jump to beginning of loop
comp_less:
    li $v0 , -1                 ## return -1
    jr $ra
comp_greater:
    li $v0, 1                   ## return 1
    jr $ra
comp_equal:
    li $v0, 0                   ## return 0
    jr $ra

######################################################
## BEGIN MULT_BIG ##
## uses big_int1 to store result Bigint object then copies it over to Bigint a
# return: overwrites Bigint a to store a*b - return is not stored in $v0
# $a0: caller stored address to a.n
# $a1: caller stored address to b.n
# $a2: c.digits[j]
# $a3: b.digits[i]
# $v0: a.digits[j-i]
# $v1: temp store a.digits[j-i] and c.digits[j]
# $t0: a.n
# $t1: b.n
# $t2: c.n
# $t3: address of big_int1, temp store b.digits[i]
# $t4: counter
# $t5: carry
# $t6: j
# $t7: a.n + i
# $t8: val
# $t9: holder for 10 and (b.digits[i]*a.digits[j-i])
######################################################
mult_big:
    sub $sp, $sp, 4             ## move stack pointer to store $ra   
    sw $ra, ($sp)               ## re-load $ra (from beginning) from stack    
    lw $t0, ($a0)               ## store a.n in $t0
    lw $t1, ($a1)               ## store b.n in $t1
    add $t2, $t1, $t0           ## add number of digits in a and b together
    la $t3, big_int1            ## load address of holder big_int1 defined in data segment
    sw $t2, ($t3)               ## c.n = a.n + b.n
    li $t4, 0                   ## initialize the counter
## loop to perform multiplication
mult_loop2:     
    bge $t4, $t1, mult_copy     ## jump to copy if counter >= b.n
    li $t5, 0                   ## set carry to 0
    move $t6, $t4               ## set j ($t6) equal to counter ($t4)
    li $a2, 4                   ## init pointers a2, a3, v0 to 4 to multiply by index for byte address
    li $a3, 4
    li $v0, 4
    mul $a2, $a2, $t6           ## 4*j: get to correct array offset
    addi $a2, $a2, 4            ## 4 + 4*j: add by 4 to increment past c.n
    add $a2, $a2, $t3           ## &c.digits[j]: add base pointer address to get to correct byte address
    mul $a3, $a3, $t4           ## 4*i
    addi $a3, $a3, 4            ## 4 + 4*i
    add $a3, $a3, $a1           ## &b.digits[i]
    sub $t3, $t6, $t4           ## temporary use $t3 register to calculate j-i
    mul $v0, $v0, $t3           ## 4 * (j-i)
    la $t3, big_int1            ## reload $t3 to be address of big_int1
    addi $v0, $v0, 4            ## 4 + 4*(j-i)
    add $v0, $v0, $a0           ## &a.digits[j-i]
    add $t7, $t0, $t4           ## calculate a.n + i to be used for inner for loop
## inner for loop for mult_loop2
m_loop2_inner:
    bge $t6, $t7, m_loop_if     ## jump to if statement if j >= a.n + i
    ##### calculating val
    lw $v1, ($a2)               ## load c.digits[j]
    add $t8, $v1, $t5           ## val = c.digits[j] + carry
    ## b.digits[i] * a.digit[j-1]
    lw $v1, ($v0)               ## load a.digits[j-i]
    lw $t3, ($a3)               ## load b.digits[i]
    mul $t9, $v1, $t3           ## $t9 = b.digits[i] * a.digits[j-i]
    la $t3, big_int1            ## reload $t3 to be address of big_int1
    add $t8, $t8, $t9           ## val = c.digits[j] + carry + b.digits[i]*a.digits[j-i]
    li $t9, 10                  ## load 10 into $t9
    div $t8, $t9                ## val / 10
    mflo $t5                    ## carry = val / 10
    mfhi $t9                    ## temp store val % 10 in $t9
    sw $t9, 0($a2)              ## c.digits[j] = val % 10
    addi $t6, $t6, 1            ## increment j
    addi $a2, $a2, 4            ## move to next index in c.digits (c.digits[j+1])
    addi $v0, $v0, 4            ## move to next index in a.digits (a.digits[j+1-i])
    j m_loop2_inner
## if statement for inner for loop
m_loop_if:
    addi $t4, $t4, 1            ## increment counter
    ble $t5, $0, mult_loop2     ## jump to beginning of for loop - check if carry > 0
    lw $v1, ($a2)               ## load c.digits[j]   
    add $t8, $v1, $t5           ## val = c.digits[j] + carry
    li $t9, 10                  ## temp store 10
    div $t8, $t9                ## val / 10
    mflo $t5                    ## carry = val / 10
    mfhi $t9                    ## temp store val % 10 in $t9
    sw $t9, ($a2)               ## c.digits[j] = val % 10
    j mult_loop2                ## unconditional jump back to starting for loop
mult_copy:                      ## copies big_int1 to Bigint a by looping through all values in big_int1
    li $t4, 0                   ## init counter
    la $t3, big_int1            ## might be unnecessary but just in case
    move $v0, $a0               ## re-init $v0 to base of Bigint a 
m_copy_loop:                    ## loop to iterate through all values in big_int1 and copy to Bigint a
    bgt $t4, $t2, mult_exit     ## check if counter <= c.n - needs to be <= because need to copy over c.n
    lw $v1, ($t3)               ## load element from big_int1
    sw $v1, ($a0)               ## overwrite element in Bigint a
    sw $0, ($t3)                ## clear big_int1
    addi $t3, $t3, 4            ## increment to next element in big_int1
    addi $a0, $a0, 4            ## increment to next element in Bigint a
    addi $t4, $t4, 1            ## increment counter
    j m_copy_loop               ## jump to beginning of loop
mult_exit:
    move $a0, $v0               ## move $a0 pointer back to base of Bigint a
    sub $sp, $sp, 4             ## move stack pointer down to store $ra
    sw $ra, ($sp)               ## store $ra in stack
    jal compress                ## compress Bigint a
    lw $ra, ($sp)               ## re-load $ra from stack
    addi $sp, $sp, 4            ## move stack pointer back
    lw $ra, ($sp)               ## re-load $ra (from beginning) from stack
    addi $sp, $sp, 4            ## move stack pointer back
    jr $ra                      ## return

######################################################
## BEGIN POW_BIG ##
## first copy Bigint a to Bigint b (big_int2) then multiply Bigint b by itself p-1 times and return in $v0
# return: Bigint b (Bigint a ^ p) stored in big_int2 and address returned in $v0 
# $a0: caller-stored address to Bigint a
# $a1: caller-stored integer p (power to raise)
# $t0: counter
# $t1: a.n
# $t2: address for big_int2 (Bigint b)
# $t3: element in Bigint a to be copied
######################################################
pow_big:
    sub $sp, $sp, 4             ## move stack pointer down to store $a0
    sw $ra, ($sp)               ## store $ra in stack
    sub $sp, $sp, 4             ## move stack pointer down to store $a0
    sw $a0, ($sp)               ## store $a0 on stack
    la $a0, big_int2            ## load big_int2 to $a0
    jal clear_big               ## clear big_int2
    lw $a0, ($sp)               ## restore $a0 from stack
    addi $sp, $sp, 4            ## move stack pointer back
    li $t0, 0                   ## init counter
    lw $t1, ($a0)               ## set upper bound ($t1) for loop (a.n)
    la $t2, big_int2            ## load base address of big_int2 to $t2
    sub $sp, $sp, 4             ## move stack pointer down to store $a0
    sw $a0, ($sp)               ## store $a0 on stack
pow_copy_loop:                  ## loop to iterate through all values in Bigint a and copy to big_int2
    bgt $t0, $t1, pow_body      ## check if counter <= a.n - needs to be <= because need to copy over a.n and digits
    lw $t3, ($a0)               ## load element from Bigint a
    sw $t3, ($t2)               ## write in big_int2
    addi $t2, $t2, 4            ## increment to next element in big_int2
    addi $a0, $a0, 4            ## increment to next element in Bigint a
    addi $t0, $t0, 1            ## increment counter
    j pow_copy_loop             ## jump to beginning of loop
pow_body:
    lw $a0, ($sp)               ## restore Bigint a to $a0
    li $t0, 1                   ## init counter to 1
pow_loop:                       ## need to store $t0, $a0, $a1
    bge $t0, $a1, pow_exit      ## check if i < p
    sub $sp, $sp, 4             ## move stack pointer to store $t0 (counter)
    sw $t0, ($sp)               ## store counter
    sub $sp, $sp, 4             ## move stack pointer to store $a0 (Bigint a)
    sw $a0, ($sp)               ## store Bigint a
    sub $sp, $sp, 4             ## move stack pointer to store $a1 (p)
    sw $a1, ($sp)               ## store int p
    move $a1, $a0               ## load Bigint a to $a1
    la $a0, big_int2            ## load big_int2 to $a0
    jal mult_big                ## big_int2 *= Bigint a
    lw $a1, ($sp)               ## restore int p from $sp
    addi $sp, $sp, 4            ## move stack pointer back
    lw $a0, ($sp)               ## restore Bigint a base address from $sp
    addi $sp, $sp, 4            ## move stack pointer back
    lw $t0, ($sp)               ## restore counter from $sp
    addi $sp, $sp, 4            ## move stack pointer back
    addi $t0, $t0, 1            ## increment counter
    j pow_loop                  ## jump to beginning of for loop
pow_exit:
    lw $a0, ($sp)               ## restore Bigint a to $a0
    addi $sp, $sp, 4            ## move stack pointer back
    la $v0, big_int2            ## load big_int2 base address to $v0
    lw $ra, ($sp)               ## restore $ra from stack
    addi $sp, $sp, 4            ## move stack pointer back
    jr $ra                      ## return

######################################################
## BEGIN SUB_BIG ##
## initially stored in big_int3 and copied to Bigint a
# return: Bigint a - Bigint b stored in $a0 (replaces Bigint a)
# $a0: caller-provided base address to Bigint a
# $a1: caller-provided base address to Bigint b
# $t0: a.n
# $t1: a.digits[j+1]
# $t2: base address to big_int3
# $t3: aDigit
# $t4: *a.digits[j]
# $t5: counter (j)
# $t6: *b.digits[j]
# $t7: b.digits[j]
# $t8: *big_int3[j]
# $t9: aDigit - b.digits[j]
######################################################
sub_big:
    sub $sp, $sp, 4             ## move stack pointer to store $ra
    sw $ra, ($sp)               ## store $ra on stack
    la $t2, big_int3            ## load base address of big_int3 to $t2
    lw $t0, ($a0)               ## $t0 = a.n
    sw $t0, ($t2)               ## set big_int3 # of digits to a.n
    li $t5, 0                   ## init counter to 0
    addi $t4, $a0, 4            ## $t4 = &a.digits[0]
    addi $t6, $a1, 4            ## $t6 = &b.digits[0]
    addi $t8, $t2, 4            ## $t8 = &big_int3[0]       
sub_for:
    bge $t5, $t0, sub_copy      ## check if j < a.n
    lw $t3, ($t4)               ## aDigit = a.digits[j] 
    lw $t7, ($t6)               ## $t7 = b.digits[0]
    bgt $t7, $t3, sub_if        ## check if b.digits[j] > aDigit
    j sub_for_bot               ## jump to bottom of for loop
sub_if:
    addi $t3, $t3, 10           ## aDigit += 10
    lw $t1, 4($t4)              ## $t1 = a.digits[j+1]
    sub $t1, $t1, 1             ## a.digits[j+1]--
    sw $t1, 4($t4)              ## a.digits[j+1]--
sub_for_bot:
    sub $t9, $t3, $t7           ## $t9 = aDigit - b.digits[j]
    sw $t9, ($t8)               ## c.digits[j] = aDigit - b.digits[j]
    addi $t5, $t5, 1            ## increment counter
    addi $t4, $t4, 4            ## move to &a.digits[j+1]
    addi $t6, $t6, 4            ## move to &b.digits[j+1]
    addi $t8, $t8, 4            ## move to &big_int3[j+1]
    j sub_for                   ## jump to beginning of loop
sub_copy:                       ## copies big_int3 to Bigint a by looping through all values in big_int3
    li $t5, 0                   ## init counter
    la $t8, big_int3            ## restore $t7 to base address of big_int3
    move $t4, $a0               ## $t4 = &Bigint a
s_copy_loop:                    ## loop to iterate through all values in big_int3 and copy to Bigint a
    bgt $t5, $t0, sub_exit      ## check if counter <= c.n - needs to be <= because need to copy over c.n
    lw $t9, ($t8)               ## load element from big_int3
    sw $t9, ($t4)               ## overwrite element in Bigint a
    sw $0, ($t8)                ## clear big_int3
    addi $t8, $t8, 4            ## increment to next element in big_int1
    addi $t4, $t4, 4            ## increment to next element in Bigint a
    addi $t5, $t5, 1            ## increment counter
    j s_copy_loop               ## jump to beginning of loop
sub_exit:
    jal compress                ## compress Bigint a
    lw $ra, ($sp)               ## restore $ra from stack
    addi $sp, $sp, 4            ## move stack pointer back
    jr $ra                      ## returns

######################################################
## BEGIN MOD_BIG ##
## original_b stored in big_int4 then cleared at the end
# return: Bigint a % Bigint b - writes over Bigint a ($a0)
# $a0: caller-provided address to Bigint a
# $a1: caller-provided address to Bigint b
# $t0: address to big_int4
# $t1: result of compare_big() | counter for copy loop
# $t2: counter for copying Bigint b to big_int4 | a.n
# $t3: elements of b | element of big_int4
# $t4: b.n
######################################################
mod_big:
    sub $sp, $sp, 4             ## move stack pointer to store $ra
    sw $ra, ($sp)               ## store $ra on stack
    sub $sp, $sp, 4             ## move stack pointer to store $a0
    sw $a0, ($sp)               ## store base address to $a0 on stack
    sub $sp, $sp, 4             ## move stack pointer to store $a1
    sw $a1, ($sp)               ## store base address to $a1 on stack
    li $t2, 0                   ## init counter
    la $t0, big_int4            ## load base address of big_int4 to $t0
    lw $t4, ($a1)               ## $t4 = b.n
mod_loop:                       ## loop to iterate through all values in Bigint b and copy to big_int4
    bgt $t2, $t4, mod_while1
    lw $t3, ($a1)               ## load element from Bigint b
    sw $t3, ($t0)               ## write to big_int4
    addi $a1, $a1, 4            ## increment to next element in Bigint b
    addi $t0, $t0, 4            ## increment to next element in big_int4
    addi $t2, $t2, 1            ## increment counter
    j mod_loop
mod_while1:                     ## first while loop
    lw $a1, ($sp)               ## restore base address to Bigint b
    lw $a0, 4($sp)              ## restore base address to Bigint a
    jal compare_big             ## don't need to store anything - compare_big(a, b) in $v0
    bne $v0, 1, mod_body        ## check if compare_big(a,b) == 1
    lw $a0, ($sp)               ## load Bigint b to $a0
    jal shift_right             ## shift Bigint b to right
    j mod_while1                ## jump to beginning of while loop
mod_body:
    lw $a0, ($sp)               ## load Bigint b to $a0
    jal shift_left              ## shift Bigint b to left
mod_while2:                     ## second while loop
    lw $a0, ($sp)               ## load Bigint b to $a0
    la $a1, big_int4            ## load base address of big_int4 to $a1
    jal compare_big             ## compare_big(b,original_b) in $v0
    beq $v0, -1, mod_restore    ## check if compare_big(b,original_b) != -1
mod_inner_while:                ## inner while loop of second while loop
    lw $a0, 4($sp)              ## load base address of Bigint a to $a0
    lw $a1, ($sp)               ## load base address of Bigint b to $a1
    jal compare_big             ## compare_big(a,b) in $v0
    beq $v0, -1, mod_while_body ## check if compare_big(a,b) != -1; jump to end of outer while loop
    jal sub_big                 ## a = Bigint(a) - Bigint(b)
    j mod_inner_while           ## jump to beginning of inner while loop
mod_while_body:
    lw $a0, ($sp)               ## load base address of Bigint b to $a0
    jal shift_left              ## shift Bigint b left
    j mod_while2                ## jump to beginning of second while loop
mod_restore:                    ## restore original Bigint b
    li $t2, 0                   ## init counter
    lw $a0, ($sp)               ## clear the current Bigint b
    jal clear_big
    lw $t0, ($sp)               ## restore Bigint b from stack
    la $t3, big_int4            ## load base address of big_int4
    lw $t4, ($t3)               ## $t4 = big_int4.n
m_restore_loop:
    bgt $t2, $t4, mod_exit
    lw $t5, ($t3)               ## load element from big_int4
    sw $t5, ($t0)               ## write to Bigint b
    addi $t0, $t0, 4            ## increment to next element in Bigint b
    addi $t3, $t3, 4            ## increment to next element in big_int4
    addi $t2, $t2, 1            ## increment counter
    j m_restore_loop
mod_exit:
    la $a0, big_int4            ## clear big_int4
    jal clear_big
    lw $a0, 4($sp)              ## restore Bigint a from stack
    jal compress                ## compress Bigint a
    lw $a1, ($sp)               ## restore Bigint b from stack
    addi $sp, $sp, 4            ## move stack pointer back   
    addi $sp, $sp, 4            ## move stack pointer back
    lw $ra, ($sp)               ## restore $ra from stack
    addi $sp, $sp, 4            ## move stack pointer back   
    jr $ra                      ## return

######################################################
## BEGIN LLT ##
## tests if Mp = 2^p - 1 is a prime number
# return: 1 if Mp is prime, 0 otherwise
# $a0: caller-provided int p
# $t0: counter
# $t1: p - 2
# $s2: Bigint(0)
# $s3: Bigint(1)
# $s4: Bigint(2)
# $s5: Bigint(4) (s)
# $s6: store int p
######################################################
LLT:
    sub $sp, $sp, 4             ## move stack pointer to store $ra
    sw $ra, ($sp)               ## store $ra on stack
    move $s6, $a0               ## move int p to $s6
    li $a0, 0                   ## create Bigint(0)
    jal digit_to_big
    move $s2, $v0               ## move Bigint(0) to $s2
    li $a0, 1                   ## create Bigint(1)
    jal digit_to_big
    move $s3, $v0               ## move Bigint(1) to $s3
    li $a0, 2                   ## create Bigint(2)
    jal digit_to_big
    move $s4, $v0               ## move Bigint(2) to $s4
## create Bigint Mp
    move $a0, $s4               ## move Bigint(2) to $a0
    move $a1, $s6               ## move int p to $a1
    jal pow_big                 ## 2^p
    move $a0, $v0               ## move Bigint(2^p) to $a0
    move $a1, $s3               ## move Bigint(1) to $a1
    jal sub_big                 ## Mp -= 1
## create Bigint(4)
    li $a0, 4                   ## create Bigint(4)
    jal digit_to_big
    move $s5, $v0               ## move Bigint(4) to $s5
    li $t0, 0                   ## init counter
    sub $sp, $sp, 4             ## move stack pointer to store counter
    sw $t0, ($sp)               ## push counter on stack
LLT_loop:
    sub $t1, $s6, 2             ## $t1 = p - 2 (loop condition)
    lw $t0, ($sp)               ## restore counter from stack
    bge $t0, $t1, LLT_if        ## check if i < p - 2
    move $a0, $s5               ## move s to $a0
    move $a1, $s5               ## move s to $a1
    jal mult_big                ## s = s*s
    move $a1, $s4               ## move Bigint(2) to $a1
    jal sub_big                 ## s = s^2 - 2
    la $a1, big_int2            ## move Bigint(Mp) to $a1
    jal mod_big                 ## s = (s^2 - 2) % (2^p - 1)
    lw $t0, ($sp)               ## restore counter from stack
    addi $t0, $t0, 1            ## increment counter
    sw $t0, ($sp)               ## push counter on stack
    j LLT_loop                  ## jump to top of loop
LLT_if:
    move $a0, $s5               ## move Bigint(s) to $a0
    move $a1, $s2               ## move Bigint(0) to $a1
    jal compare_big             ## compare_big(s, 0)
    bne $v0, 0, LLT_else        ## check if compare_big(s,0) == 0
    li $v0, 1                   ## load 1 in return spot (prime)
    j LLT_exit                  ## jump to exit
LLT_else:
    li $v0, 0                   ## load 0 in return spot (not prime)
LLT_exit:
    addi $sp, $sp, 4            ## deallocate counter
    addi $sp, $sp, 5616         ## deallocate 4Bigint
    la $a0, big_int2            ## load big_int2 to $a0
    jal clear_big               ## clear big_int2
    lw $ra, ($sp)               ## restore $ra from stack
    addi $sp, $sp, 4            ## move stack pointer back
    jr $ra                      ## return

######################################################
## BEGIN MERSENNE_SCAN ##
## no caller-provided arguments - lower bound 3 and upper bound 128 for p are hardcoded
# return: scans through prime values p from 3 to 128 for Mp primacy and outputs results to console
# $a0: counter which starts at 3
# $a1: 128
######################################################
mersenne_scan:
    sub $sp, $sp, 4             ## move stack pointer to store $ra
    sw $ra, ($sp)               ## store $ra on stack
    li $a0, 3                   ## set counter to lower bound 3
    li $a1, 128                 ## set $a1 to upper bound 128
    sub $sp, $sp, 4             ## move stack pointer to store $a0
    sw $a0, ($sp)               ## push $a0 on stack
    sub $sp, $sp, 4             ## move stack pointer to store $a1
    sw $a1, ($sp)               ## push $a1 on stack
mersenne_loop:                  ## outer for loop going from p = 3 to 128
    bgt $a0, $a1, mer_exit      ## check if p <= 128
    jal is_small_prime          ## check if p is prime
    beq $v0, 1, mer_if_prime
    j mer_bott_loop             ## jump to bottom of for loop
mer_if_prime:                   ## branch if p is prime
    la $a0, testing             ## print "Testing p = "
    li $v0, 4
    syscall
    lw $a0, 4($sp)              ## print p after loading from stack
    li $v0, 1
    syscall
    jal LLT                     ## check if (Mp = 2^p - 1) is prime
    beq $v0, 1, mer_mp_prime    ## jump to branch if Mp is prime
    la $a0, not_prime           ## print "Mp not prime"
    li $v0, 4
    syscall
    j mer_bott_loop             ## jump to bottom of for loop to increment
mer_mp_prime:                   ## branch if Mp is prime
    la $a0, found               ## print "found prime Mp = "
    li $v0, 4
    syscall
    lw $s0, 4($sp)              ## restore p from stack
    li $a0, 1                   ## create Bigint(1)
    jal digit_to_big
    sub $sp, $sp, 4             ## move stack pointer to store base address of Bigint(1)
    sw $v0, ($sp)               ## push &Bigint(1) on stack
    li $a0, 2                   ## create Bigint(2)
    jal digit_to_big
    move $a0, $v0               ## immediately load Bigint(2) to $a0
    move $a1, $s0               ## move p to $a1
    jal pow_big                 ## Bigint Mp = pow_big(2, p)
    move $a0, $v0               ## load Mp to $a0
    lw $a1, 1404($sp)           ## load Bigint(1) from stack 
    jal sub_big                 ## Mp = sub_big(Mp, 1)
    jal print_big               ## print Mp
    addi $sp, $sp, 1404         ## deallocate Bigint(2)
    addi $sp, $sp, 4            ## deallocate &Bigint(1)
    addi $sp, $sp, 1404         ## deallocate Bigint(1)
mer_bott_loop:                  ## increment counter and reload $a0 and $a1 from stack
    lw $a1, ($sp)               ## restore $a1 from stack
    lw $a0, 4($sp)              ## restore $a0 from stack
    addi $a0, $a0, 1            ## increment p
    sw $a0, 4($sp)              ## store incremented p on stack
    j mersenne_loop             ## jump to top of for loop
mer_exit:
    addi $sp, $sp, 8            ## deallocate $a1 and $a0
    lw $ra, ($sp)               ## restore $ra from stack
    addi $sp, $sp, 4            ## move stack pointer back
    jr $ra                      ## return
