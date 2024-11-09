.section .text
.global math_factorial
.global math_exponential
.global math_log

math_factorial:
    CMP R0, #1            # Si n <= 1, retornar 1
    BLE factorial_end
    PUSH {R0}             # Guardar el valor de R0
    SUB R0, R0, #1        # R0 = n - 1
    BL math_factorial     # Llamada recursiva
    POP {R1}              # Recuperar el valor de R0 anterior
    MUL R0, R0, R1        # R0 = n * factorial(n-1)
factorial_end:
    BX LR

math_exponential:
    MOV R2, #1            # R2 será el resultado acumulado (inicia en 1)
    MOV R3, #1            # R3 será el término actual (x^i / i!)
    MOV R4, #1            # R4 será el factorial de i (inicia en 1)

exponential_loop:
    ADD R2, R2, R3        # Sumar el término actual a R2
    ADD R4, R4, #1        # Incrementar el valor de i
    MUL R3, R3, R0        # R3 = R3 * x (x^i)
    MUL R4, R4, R4        # R4 = R4 * i 
    CMP R4, #1000         # Limitar el número de iteraciones
    BLT exponential_loop   # Si no se ha alcanzado el límite, continuar

    MOV R0, R2            # Almacenar el resultado en R0
    BX LR

math_log:
    CMP R0, #1            # Si x = 1, log(1) = 0
    BEQ log_zero_case
    MOV R2, #0            # Inicializamos el resultado a 0
    MOV R3, R0            # R3 es la entrada (x)
    SUB R3, R3, #1        # x - 1
    MOV R4, #1            # Inicializar el término de la serie

log_loop:
    ADD R2, R2, R4        # Sumar el término a R2
    MOV R4, R4, LSR #1    # Desplazar el valor de la serie
    CMP R4, #0            # Verificar si el término es suficientemente pequeño
    BEQ log_end

    BX LR

log_zero_case:
    MOV R0, #0            # log(1) = 0
    BX LR

log_end:
    MOV R0, R2            # Almacenar el resultado en R0
    BX LR
