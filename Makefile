all:
	as date.s -o date.o
	gcc -c test.c -o test.o -std=c99
	gcc date.o test.o -o test

