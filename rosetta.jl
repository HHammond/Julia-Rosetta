
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
