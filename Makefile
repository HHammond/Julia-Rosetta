rosetta.o: rosetta.c
	gcc -c rosetta.c -o rosetta.o --std=c11 -Wall -fpic

rosetta.dylib: rosetta.o
	gcc -dynamiclib rosetta.o -o rosetta.dylib

rosetta.so: rosetta.o
	gcc -shared -o rosetta.so rosetta.o

build: rosetta.so

clean:
	-rm *.o
	-rm *.dylib
	-rm *.so
