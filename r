#!/bin/bash

# Clean previous builds
echo "Cleaning previous build files..."
rm -f chaos_visualiser.o chaos_visualiser

# Check if rang.hpp already exists
if [ ! -f "rang.hpp" ]; then
    echo "Downloading rang library..."
    curl -O https://raw.githubusercontent.com/agauniyal/rang/master/include/rang.hpp
else
    echo "rang.hpp already exists, skipping download."
fi

# Assemble chaos_visualiser.asm without -fPIC (NASM doesn't use -fPIC)
echo "Assembling chaos_visualiser.asm..."
nasm -f elf64 chaos_visualiser.asm -o chaos_visualiser.o

# Compile and link the C++ code with -fPIE
g++ -fPIE chaos_visualiser.cpp chaos_visualiser.o -o chaos_visualiser -lstdc++

