# MASMx86-architecture
This repository is the assignments and work I have done for Computer Architectures and Assembly Language course at Oregon State University in CS 271, Computer Acrhitecture and Assembly Language taken in Winter term of 2019

All of these assignments utilize the Irvine.32 library and the  Kip Irvine "Assembly Language for x86 Processors" textbook
All assignment prompts are not designed by me, and are credited to Oregon State University

------------------------------------------------------------
ASSIGNMENT1:      ///two_numbers.asm///             1/12/19

This program takes in a users input of two integers, stores them, then calculates and prints the sum, difference, product, and quotient & remainder of these two numbers. 
This first assingment served as a starting point for writing is MASM, where the goal of the assignment was to practice basic syntax, and understand the gathering, manipulating, and returning of data from a user. 
This assignment did not utilize modularization, nor did it use multiple procedures. 

------------------------------------------------------------
ASSIGNMENT2:      ///fibonacci_numbers.asm///        1/16/19

This program takes in user input, an integer value between 1 and 46, then generates that many digits of the fibonacci sequence
We kept this number between 1 and 46 to keep the bit length of the integers to be calculated within a DWORD. 
This program utilizes error handling, where the user inputted value is validated, and reprompted if an incorrect number is entered
This program was designed to introduce us to loops, and error handling in MASM. 

------------------------------------------------------------
ASSIGNMENT3:  ///negative_integer_averages.asm///   1/27/19

This program takes in negative integer values from the user, between -100 and -1, stores the value, then repeats the process until an invalid integer is entered.
When a number outside of this range is entered, the average of the previously returned numbers is returned and the program exits.
This assignment served as more practice for loops, reading user input, validating user input, and using mathamatical operations in MASM.

------------------------------------------------------------
ASSIGNMENT4:  ///composite_numbers.asm///           2/17/19

This program will take in a user inputted value from 1 to 400, validate this number, and then produce this many composite numbers, beginning at the first composite number: 4.
This program was the first to implement multiple procedures, in a modular fashion, yet it still used globally accessed variables rather than using parameters. 

------------------------------------------------------------
ASSIGNMENT5:   ///random_number_sorter.asm///       2/23/19

This program will take in a user input to create an array of random integers of specified length, and then manipulate this array.
The program will accept a number between 10 and 200, and create an array of this length, and populate it with random integers between 199 and 999. 
We were then instructed to display this array with a universal display procedure that would print adescription prior to the array.
The array is then sorted, utilizing bubble sort, this version deriving from Kip Irvine's textbook, in descending order. 
The program last displays the array again, this time sorted.
This program was designed to practice our skills with using arrays, implenting complicated nested loops, sorting algorithms, data validation, and the system stack. 
This program required us to pass parameters for each of the procedures,using the system stack, and not call global variables from outside of the main procedure. 

------------------------------------------------------------


