.section .text
.global _start

.extern keypad_init
.extern keypad_scan
.extern lcd_init
.extern lcd_clear
.extern lcd_display_char
.extern arithmetic_add
.extern arithmetic_subtract
.extern arithmetic_multiply
.extern arithmetic_divide
.extern trig_sin
.extern trig_cos
.extern trig_tan
.extern math_factorial
.extern math_exponential
.extern math_log

_start:
    # Inicializar LCD y teclado
    BL lcd_init              # Inicializar el LCD
    BL keypad_init           # Inicializar el teclado

    # Variables de almacenamiento para números
    MOV R1, #0              # Primer número
    MOV R2, #0              # Segundo número
    MOV R3, #0              # Operación seleccionada
    MOV R4, #0              # Acumulador para el número actual

main_loop:
    BL keypad_scan           # Escanear teclado y obtener la tecla
    CMP R0, #'0'             # Si la tecla es 0-9, ingresar número
    BGE handle_number        # Si es número, manejar entrada
    CMP R0, #'+'             # Si la tecla es suma
    BEQ handle_addition
    CMP R0, #'-'             # Si la tecla es resta
    BEQ handle_subtraction
    CMP R0, #'*'             # Si la tecla es multiplicación
    BEQ handle_multiplication
    CMP R0, #'/'             # Si la tecla es división
    BEQ handle_division
    CMP R0, #'S'             # Si la tecla es seno
    BEQ handle_sine
    CMP R0, #'C'             # Si la tecla es coseno
    BEQ handle_cosine
    CMP R0, #'T'             # Si la tecla es tangente
    BEQ handle_tangent
    CMP R0, #'F'             # Si la tecla es factorial
    BEQ handle_factorial
    CMP R0, #'E'             # Si la tecla es exponencial
    BEQ handle_exponential
    CMP R0, #'L'             # Si la tecla es logaritmo
    BEQ handle_logarithm
    CMP R0, #'='             # Si la tecla es igual, calcular
    BEQ perform_calculation
    CMP R0, #'C'             # Si la tecla es 'C', limpiar pantalla
    BEQ clear_display

    B main_loop              # Continuar escaneando si no se presiona ninguna tecla válida

handle_number:
    # Aquí vamos a almacenar el número presionado en R4
    SUB R0, R0, #'0'         # Convertir ASCII a número
    MOV R5, R0               # Guardar el número presionado en R5

    # Se puede expandir para manejar secuencias de dígitos
    MUL R4, R4, #10          # Desplazar el número actual a la izquierda
    ADD R4, R4, R5           # Agregar el nuevo dígito al número
    B main_loop

handle_addition:
    MOV R3, #'+'             # Guardar operación como suma
    MOV R1, R4               # Guardar primer número
    MOV R4, #0               # Limpiar acumulador para el segundo número
    B main_loop

handle_subtraction:
    MOV R3, #'-'             # Guardar operación como resta
    MOV R1, R4               # Guardar primer número
    MOV R4, #0               # Limpiar acumulador para el segundo número
    B main_loop

handle_multiplication:
    MOV R3, #'*'             # Guardar operación como multiplicación
    MOV R1, R4               # Guardar primer número
    MOV R4, #0               # Limpiar acumulador para el segundo número
    B main_loop

handle_division:
    MOV R3, #'/'             # Guardar operación como división
    MOV R1, R4               # Guardar primer número
    MOV R4, #0               # Limpiar acumulador para el segundo número
    B main_loop

handle_sine:
    MOV R0, #30              # Valor de ejemplo para el seno
    BL trig_sin              # Llamar a la función seno
    BL display_result        # Mostrar el resultado
    B main_loop

handle_cosine:
    MOV R0, #30              # Valor de ejemplo para el coseno
    BL trig_cos              # Llamar a la función coseno
    BL display_result        # Mostrar el resultado
    B main_loop

handle_tangent:
    MOV R0, #30              # Valor de ejemplo para la tangente
    BL trig_tan              # Llamar a la función tangente
    BL display_result        # Mostrar el resultado
    B main_loop

handle_factorial:
    MOV R0, #5               # Valor de ejemplo para factorial
    BL math_factorial        # Llamar a la función factorial
    BL display_result        # Mostrar el resultado
    B main_loop

handle_exponential:
    MOV R0, #2               # Valor de ejemplo para exponencial
    BL math_exponential      # Llamar a la función exponencial
    BL display_result        # Mostrar el resultado
    B main_loop

handle_logarithm:
    MOV R0, #10              # Valor de ejemplo para logaritmo
    BL math_log              # Llamar a la función logaritmo
    BL display_result        # Mostrar el resultado
    B main_loop

perform_calculation:
    # Realizar la operación basada en R3 (operación seleccionada)
    CMP R3, #'+'             # Si la operación es suma
    BEQ perform_addition_calc
    CMP R3, #'-'             # Si la operación es resta
    BEQ perform_subtraction_calc
    CMP R3, #'*'             # Si la operación es multiplicación
    BEQ perform_multiplication_calc
    CMP R3, #'/'             # Si la operación es división
    BEQ perform_division_calc

    B main_loop

perform_addition_calc:
    MOV R2, R4               # Guardar segundo número
    BL arithmetic_add        # Llamar a la función de suma
    BL display_result        # Mostrar el resultado
    MOV R4, #0               # Limpiar acumulador
    B main_loop

perform_subtraction_calc:
    MOV R2, R4               # Guardar segundo número
    BL arithmetic_subtract   # Llamar a la función de resta
    BL display_result        # Mostrar el resultado
    MOV R4, #0               # Limpiar acumulador
    B main_loop

perform_multiplication_calc:
    MOV R2, R4               # Guardar segundo número
    BL arithmetic_multiply   # Llamar a la función de multiplicación
    BL display_result        # Mostrar el resultado
    MOV R4, #0               # Limpiar acumulador
    B main_loop

perform_division_calc:
    MOV R2, R4               # Guardar segundo número
    BL arithmetic_divide     # Llamar a la función de división
    BL display_result        # Mostrar el resultado
    MOV R4, #0               # Limpiar acumulador
    B main_loop

clear_display:
    BL lcd_clear             # Limpiar la pantalla del LCD
    MOV R4, #0               # Limpiar los números y el estado
    MOV R1, #0
    MOV R2, #0
    MOV R3, #0
    B main_loop

display_result:
    # R0 contiene el resultado a mostrar
    BL lcd_clear             # Limpiar la pantalla del LCD
    BL lcd_display_char      # Mostrar el resultado en el LCD
    BX LR                    # Regresar de la función
