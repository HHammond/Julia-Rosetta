# Julia Rosetta

This repository is an demonstration of how to call a simple C function from
within Julia. This code augments the
[documentation](http://docs.julialang.org/en/release-0.4/manual/calling-c-and-fortran-code/)
with a slightly more natural example. 

This example uses the `HelloWorld` function from the `rosetta.c` file to copy 
the first `n` characters of "Hello World!" into a buffer in Julia. The buffer 
is then converted to a Julia bytestring. 

## Running Code

In order to run this example you need to compile the `rosetta.c` file to a 
shared library. To do this use the `make rosetta.so` or `make build` commands. 
