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

## Julia Code

```julia
"""Write the first `n` chars of "Hello World!" to a buffer using a C call. """
function hello_c(n::Int)
    
    # Create a compatible buffer with C's native Char array.
    # Cchar is Julia's native alias to C's char datatype.
    buffer = zeros(Cchar, n)  
    
    # Call the C function. `val` takes the value returned from HelloWorld, in
    # this case the number of characters written to the buffer. 
    # Julia passed a pointer to the buffer to HelloWorld, so the buffer will
    # directly be modified from the C function itself.
    val = ccall((:HelloWorld, "./rosetta.so"), Csize_t, (Ptr{Cchar}, Csize_t), 
                buffer, length(buffer))

    # We need to convert the return value to an Int so that Julia can handle it
    # natively.
    val = convert(Int64, val)
    
    # Likewise we specify that the buffer should be treated as a string of 
    # bytes.
    string = bytestring(pointer(buffer))

    val, string
end

@show hello_c(5)  #> (5,"Hello")
@show hello_c(13) #> (13,"Hello World!")
@show hello_c(20) #> (13,"Hello World!")
```
