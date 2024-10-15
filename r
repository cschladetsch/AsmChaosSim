#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.

echo "Downloading rang library..."
curl -O https://raw.githubusercontent.com/agauniyal/rang/master/include/rang.hpp

echo "Assembling chaos_visualiser.asm..."
nasm -f elf64 chaos_visualiser.asm -o chaos_visualiser_asm.o

echo "Compiling C++ wrapper..."
g++ -c -no-pie chaos_visualiser.cpp -o chaos_visualiser.o

echo "Linking object files..."
g++ -no-pie chaos_visualiser.o chaos_visualiser_asm.o -o vis

echo "Running Chaos Visualiser..."
./vis
