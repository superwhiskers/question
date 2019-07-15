.PHONY: build
build: main

.PHONY: clean
clean:
	@rm -f main.o main

main: main.o
	@ld main.o -o main
main.o:
	@nasm -f elf64 main.s -o main.o
