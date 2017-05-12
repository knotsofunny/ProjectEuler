003: 003.o 
	gcc -o 003 003.o

003.o: 003.s
	nasm -f elf64 -g -F dwarf -o 003.o 003.s

clean:
	rm *.o
