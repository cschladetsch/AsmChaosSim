# Chaos Visualizer

This project implements a chaotic visualizer using both Assembly and C++. The visualizer displays chaotic behavior using the logistic map equation (`x = r * x * (1 - x)`) and represents the output in ASCII characters with colors, thanks to the `rang` library.

## Sample

![image](./resources/Image-0.jpeg)

## Files

- **`chaos_visualiser.asm`**: Assembly implementation for chaotic visualization.
- **`chaos_visualiser.cpp`**: C++ program calling the assembly function.
- **`chaos_visualiser_cpp_version.cpp`**: Pure C++ version using the `rang` library for colors.
- **`.gitignore`**: Ignores compiled binaries and other unnecessary files.

## Building and Running

### Requirements

- `g++` compiler
- `NASM` assembler
- `rang` library (auto-downloaded if not present)

### Steps

1. **Building the Assembly version**:
   ```bash
   ./r
   ```
   This will assemble and run the assembly-based chaotic visualizer.

2. **Building the C++ version**:
   ```bash
   ./rc
   ```
   This will compile and run the pure C++ version (`chaos_visualiser_cpp_version.cpp`).

## Visualization

The visualizer shows 25 rows of 80 characters representing chaotic values. The program continuously updates the screen to reflect the dynamic nature of the logistic map, with different colors corresponding to different states.

