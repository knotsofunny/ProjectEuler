006: 006.o 
	gcc -o 006 006.o

006.o: 006.s
	nasm -f elf64 -g -F dwarf -o 006.o 006.s

clean:
	rm *.o
