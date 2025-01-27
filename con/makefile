FLAGS = -g

all: main

util.o: util.c util.h
	gcc $(FLAGS) -c util.h util.c

compiler.o: compiler.h compiler.c
	gcc $(FLAGS) -c compiler.h compiler.c

main: main.c util.o compiler.o
	gcc $(FLAGS) -o con main.c util.o compiler.o

run: main
	./con input.txt

clear:
	rm *.o *.gch con