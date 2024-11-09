cmake_minimum_required(VERSION 3.13)

project(Calculadora)

set(PICO_SDK_PATH "/home/joab/pico-sdk") 
include($ENV{PICO_SDK_PATH}/pico_sdk_init.cmake)

add_executable(calculadora
    main.s
    arithmetic.s
    math_functions.s
    trigonometry.s
    keypad_driver.s
    lcd_driver.s
)

pico_sdk_init()

target_link_libraries(calculadora pico_stdlib)

pico_add_extra_outputs(calculadora)
