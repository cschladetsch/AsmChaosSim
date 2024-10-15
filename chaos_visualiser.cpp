#include <iostream>
#include <chrono>
#include <thread>
#include <array>
#include "rang.hpp"

extern "C" void calculate_next_state(char* buffer);

const int BUFFER_SIZE = 2001;  // 25 lines * 80 characters + 25 newlines

void clear_screen() {
    std::cout << "\033[2J\033[1;1H";
}

int main() {
    std::array<char, BUFFER_SIZE> buffer;
    
    while (true) {
        calculate_next_state(buffer.data());
        
        clear_screen();
        
        for (int i = 0; i < BUFFER_SIZE; ++i) {
            switch (buffer[i]) {
                case ' ': std::cout << rang::fg::gray; break;
                case '!': std::cout << rang::fg::red; break;
                case '"': std::cout << rang::fg::green; break;
                case '#': std::cout << rang::fg::yellow; break;
                case '$': std::cout << rang::fg::blue; break;
                case '%': std::cout << rang::fg::magenta; break;
                case '&': std::cout << rang::fg::cyan; break;
                default: std::cout << rang::fg::reset;
            }
            std::cout << buffer[i];
        }
        
        std::cout << rang::fg::reset << std::flush;
        
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }
    
    return 0;
}
