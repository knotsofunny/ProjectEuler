030: 030.o 
	gcc -o 030 030.o

030.o: 030.s
	nasm -f elf64 -g -F dwarf -o 030.o 030.s

clean:
	rm *.o
