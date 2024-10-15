
#!/bin/bash

# Assemble the code
nasm -f elf32 chaos_visualiser.asm -o chaos_visualiser.o

# Check if assembly was successful
if [ $? -ne 0 ]; then
    echo "Assembly failed. Please check for errors."
    exit 1
fi

# Link the object file
ld -m elf_i386 chaos_visualiser.o -o chaos_visualiser

# Check if linking was successful
if [ $? -ne 0 ]; then
    echo "Linking failed. Please check for errors."
    exit 1
fi

echo "Build successful. Running Chaos Visualiser..."

# Run the program
./chaos_visualiser

echo "Program finished. Check the output in 'output.txt'."
echo "Contents of output.txt:"
cat output.txt
