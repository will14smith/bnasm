all:
	as date.s -o date.o
	as bucket.s -o bucket.o
	gcc -c test.c -o test.o -std=c99
	gcc date.o bucket.o test.o -o test

