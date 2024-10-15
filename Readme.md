# Chaos Visualiser

Chaos Visualiser is an assembly language project that generates an ASCII animation of the logistic map's chaotic behavior. This program demonstrates advanced assembly techniques, including:

- Custom fixed-point arithmetic
- Direct system calls for I/O operations
- Efficient loop structures
- ASCII art generation

## Requirements

- NASM (Netwide Assembler)
- Linux-based operating system (x86 or x86\_64)
- GCC (for linking)

## Installation

1. Clone this repository or download the source files.
2. Ensure you have NASM installed. You can install it on most Linux distributions with:
   ```
   sudo apt-get install nasm
   ```
   (Replace `apt-get` with your system's package manager if different)

## Usage

The project includes a bash script `r` that handles assembly, linking, and running of the program.

To use the script:

```
./r
```

This will assemble the code, link it, and run the resulting executable.

## How It Works

The Chaos Visualiser implements the logistic map, a simple mathematical model that can produce complex, chaotic behavior. The logistic map is defined by the equation:

```
x[n+1] = r * x[n] * (1 - x[n])
```

where x is between 0 and 1, and r is a parameter between 0 and 4.

The program uses this equation to generate a series of values, which are then mapped to ASCII characters to create a dynamic visual pattern. The r parameter is gradually increased over time, causing the system's behavior to evolve from stable to chaotic.

## Output

The program generates an ASCII animation directly in the terminal. Each character represents a value in the chaotic system, with different characters indicating different ranges of values.

## Troubleshooting

If you encounter any issues:

1. Ensure NASM is correctly installed and in your system PATH.
2. Check that you have the necessary permissions to execute files in the project directory.
3. If you see no output, try redirecting the output to a file:
   ```
   ./chaos_visualiser > output.txt
   ```
   Then check the contents of output.txt.
4. For detailed error messages, you can modify the `r` script to run NASM and LD with verbose output flags.

## Contributing

Contributions to improve the program or add new features are welcome. Please feel free to submit pull requests or open issues for any bugs or feature requests.

## License

This project is open source and available under the MIT License.
