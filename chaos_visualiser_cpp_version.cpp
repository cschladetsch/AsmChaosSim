#include <iostream>
#include <cmath>
#include <thread>
#include <chrono>
#include "rang.hpp"

const int WIDTH = 80;       // Width of the output
const int HEIGHT = 25;      // Height of the output
double r = 3.5;             // Logistic map parameter
double x = 0.6;             // Initial x value
const double increment = 0.01;  // Increment for r

// Function to compute the next state of x using the logistic map formula
void calculate_next_state() {
    x = r * x * (1 - x);
}

// Function to map the value of x to a color and an ASCII character
void map_to_color_and_char(double value) {
    int index = static_cast<int>(value * 7);  // Map value to a range of 0-7

    switch (index) {
        case 0: std::cout << rang::fg::gray; break;
        case 1: std::cout << rang::fg::red; break;
        case 2: std::cout << rang::fg::green; break;
        case 3: std::cout << rang::fg::yellow; break;
        case 4: std::cout << rang::fg::blue; break;
        case 5: std::cout << rang::fg::magenta; break;
        case 6: std::cout << rang::fg::cyan; break;
        default: std::cout << rang::fg::reset; break;
    }

    char symbol = ' ' + index;  // Map to ASCII characters ' ' to '&'
    std::cout << symbol;
}

// Main loop to render the chaos visualizer
int main() {
    while (true) {
        // Clear the screen
        std::cout << "\033[2J\033[1;1H";

        // Print HEIGHT rows of chaotic values
        for (int i = 0; i < HEIGHT; ++i) {
            for (int j = 0; j < WIDTH; ++j) {
                calculate_next_state();
                map_to_color_and_char(x);
            }
            std::cout << '\n';
        }

        // Increment r to introduce some variation in the chaos
        r += increment;
        if (r > 4.0) r = 3.5;  // Reset r if it exceeds 4.0

        // Pause briefly to create a smooth visual effect
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }

    return 0;
}

