002: 002.o 
	gcc -o 002 002.o

002.o: 002.s
	nasm -f elf64 -g -F dwarf -o 002.o 002.s

clean:
	rm *.o
