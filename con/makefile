FLAGS = -g

all: main

util.o: util.c util.h
	gcc $(FLAGS) -c util.h util.c

line_processing.o: line_processing.c line_processing.h
	gcc $(FLAGS) -c line_processing.h line_processing.c


main: main.c util.o line_processing.o
	gcc $(FLAGS) -o con main.c util.o line_processing.o

clear:
	rm *.o *.gch con