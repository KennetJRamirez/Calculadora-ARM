.section .text
.global trig_sin
.global trig_cos
.global trig_tan

# Constantes
PI = 3.14159265358979323846   # Aproximación de PI para el cálculo de senos, cosenos y tangentes
PI_OVER_2 = 1.5707963267948966  # PI/2 (90 grados)
PI_OVER_4 = 0.7853981633974483  # PI/4 (45 grados)

trig_sin:
    MOV R2, R0             # Guardar el valor de x en R2
    MOV R3, #0             # R3 será el resultado acumulado (inicia en 0)
    MOV R4, R2             # Inicializar el primer término de la serie (x)
    MOV R5, #1             # R5 será el índice (inicia en 1)
    MOV R6, #1             # Factorial del índice (inicia en 1)
    
sin_loop:
    ADD R3, R3, R4         # Sumar el término a R3
    MUL R4, R4, R2         # Multiplicar el término actual por x (x^i)
    MUL R6, R6, R5         # Calcular el factorial (i!)
    ADD R5, R5, #2         # Incrementar el índice i
    CMP R6, #1000          # Limitar el número de iteraciones
    BLT sin_loop           # Si no se ha alcanzado el límite, continuar

    MOV R0, R3             # Almacenar el resultado en R0
    BX LR

trig_cos:
    MOV R2, R0             # Guardar el valor de x en R2
    MOV R3, #1             # R3 será el resultado acumulado (inicia en 1)
    MOV R4, #1             # Inicializar el primer término de la serie (1)
    MOV R5, #0             # R5 será el índice (inicia en 0)
    MOV R6, #1             # Factorial del índice (inicia en 1)
    
cos_loop:
    ADD R3, R3, R4         # Sumar el término a R3
    MUL R4, R4, R2         # Multiplicar el término actual por x (x^i)
    MUL R6, R6, R5         # Calcular el factorial (i!)
    ADD R5, R5, #2         # Incrementar el índice i
    CMP R6, #1000          # Limitar el número de iteraciones
    BLT cos_loop           # Si no se ha alcanzado el límite, continuar

    MOV R0, R3             # Almacenar el resultado en R0
    BX LR

trig_tan:
    BL trig_sin            # Llamar a la función de seno
    MOV R2, R0             # Guardar el valor de seno en R2
    BL trig_cos            # Llamar a la función de coseno
    CMP R0, #0             # Verificar si el coseno es 0 (evitar división por cero)
    BEQ tan_zero_case      # Si el coseno es 0, retornar error

    DIV R0, R2, R0         # R0 = sen(x) / cos(x)
    BX LR

tan_zero_case:
    MOV R0, #0             # Si cos(x) = 0, retornar 0 (o error según lo desees)
    BX LR
