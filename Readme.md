# Chaos Visualizer

This project is an implementation of a chaos visualizer using both Assembly and C++. The visualizer uses the **logistic map equation** (`x = r * x * (1 - x)`) to generate chaotic behavior and display it using ASCII characters with color-coded output via the **rang** library.

## Table of Contents

1. [Overview](#overview)
2. [Logistic Map](#logistic-map)
3. [File Descriptions](#file-descriptions)
4. [Prerequisites](#prerequisites)
5. [Installation and Setup](#installation-and-setup)
6. [Usage](#usage)
7. [Running the Visualizer](#running-the-visualizer)
8. [How it Works](#how-it-works)
9. [Customization](#customization)
10. [Troubleshooting](#troubleshooting)

## Overview

The chaos visualizer provides a dynamic representation of chaotic behavior using two approaches:

1. **Assembly-based Visualization**: Written in assembly language, this version directly handles memory and calculations.
2. **C++ Visualization**: This version integrates assembly calls and a pure C++ implementation with the `rang` library to add color.

The program generates chaotic values based on the logistic map and displays them in a terminal with different ASCII characters representing different levels of chaos.

## Logistic Map

The logistic map is a mathematical function that models chaotic behavior. It is defined by the equation:

\[
x_{n+1} = r \times x_n \times (1 - x_n)
\]

Where:
- **r**: A parameter controlling the chaos level.
- **x**: The current state (0 <= x <= 1).

## File Descriptions

- **`chaos_visualiser.asm`**: Assembly code implementing the logistic map for chaotic visualization, calculating values and printing them as ASCII characters.
  
- **`chaos_visualiser.cpp`**: C++ program that calls the assembly function (`calculate_next_state`) to generate visual output with colored ASCII characters using the `rang` library.

- **`chaos_visualiser_cpp_version.cpp`**: A standalone C++ version that implements the logistic map and visualizer without assembly, using `rang` for colored output.

- **`.gitignore`**: Ignores compiled binaries, object files, and temporary files.

- **`r`**: A build script that assembles and runs the assembly-based visualizer.

- **`rc`**: A build script for compiling and running the pure C++ version.

## Prerequisites

Ensure you have the following installed:
- `g++` compiler for C++ code
- `NASM` assembler for assembly code
- `curl` (optional) for downloading `rang.hpp` if it is not present

## Installation and Setup

1. Clone the repository to your local machine.
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. Ensure the `rang.hpp` file exists or will be downloaded automatically when running the scripts.

3. Build and run the visualizer using one of the provided scripts.

## Usage

### Running the Assembly-based Visualizer

To build and run the assembly-based version of the visualizer:

```bash
./r
```

This script assembles the `chaos_visualiser.asm` file using NASM, compiles the C++ code, and runs the visualizer.

### Running the Pure C++ Visualizer

To build and run the C++ version with no assembly involved:

```bash
./rc
```

This will compile the `chaos_visualiser_cpp_version.cpp` file and run the pure C++ implementation.

## Running the Visualizer

The visualizer will display a grid of chaotic values (80x25) using ASCII characters. Each character represents a state of `x` in the logistic map equation, and the colors indicate different ranges of values, providing a dynamic visual representation of chaos.

### Example Output:
```
 $$$&&%%%###%%%!!!$$$
 &&&   !!!%%%&&&&$$$
 &&%%%&&%%%!!!###$$$
```
Colors will vary based on the `rang` library.

## How it Works

1. **Assembly Version**: The assembly code calculates the logistic map's chaotic values and converts them into ASCII output. It is then integrated with a C++ wrapper that handles screen clearing and display.
   
2. **C++ Version**: The pure C++ implementation computes chaotic values and maps them to both ASCII characters and colors using the `rang` library.

## Customization

You can customize the visualizer by changing parameters in both the assembly and C++ versions:
- **r**: The logistic map parameter. Adjust it between 3.5 and 4.0 for more chaotic output.
- **Initial value of x**: Modify the starting value of `x` to influence the initial state.
- **Colors**: Modify the `map_to_color_and_char()` function in the C++ version to use different colors or ASCII ranges.

## Troubleshooting

- **Black/blank screen**: Ensure your terminal supports ANSI escape sequences for color.
- **Compilation errors**: Make sure `NASM`, `g++`, and `rang.hpp` are correctly installed.
- **Incorrect output**: Try adjusting the values of `r` and `x` or debug the logistic map computation for floating-point precision issues.

## License

This project is released under the MIT License.

