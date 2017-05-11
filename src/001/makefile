001: 001.o 
	gcc -o 001 001.o

001.o: 001.asm
	nasm -f elf64 -g -F dwarf -o 001.o 001.asm

clean:
	rm *.o
