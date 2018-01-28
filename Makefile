all:
	as date.s -o date.o -g
	as bucket.s -o bucket.o -g
	gcc -c test.c -o test.o -std=c99 -g
	gcc date.o bucket.o test.o -o test -g

