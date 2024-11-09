.section .data
accumulator: .word 0  ; Variable para almacenar el número acumulado

.section .text
.global keypad_init
.global keypad_scan
.global keypad_get_key

# Definiciones de los pines del teclado 
ROW1_PIN = 0x01  # Fila 1
ROW2_PIN = 0x02  # Fila 2
ROW3_PIN = 0x04  # Fila 3
ROW4_PIN = 0x08  # Fila 4
COL1_PIN = 0x10  # Columna 1
COL2_PIN = 0x20  # Columna 2
COL3_PIN = 0x40  # Columna 3
COL4_PIN = 0x80  # Columna 4

# Inicialización del teclado matricial
keypad_init:
    MOV R0, #0xFF       # Configurar filas como salida
    STR R0, [GPIO_DIR]  # Almacenar la configuración en el registro GPIO_DIR
    MOV R0, #0x00       # Configurar columnas como entrada
    STR R0, [GPIO_DIR]  # Almacenar la configuración en el registro GPIO_DIR
    BX LR

# Escaneo del teclado
keypad_scan:
    MOV R0, #ROW1_PIN  # Seleccionar la fila 1
    STR R0, [GPIO_OUT] # Activar la fila 1
    MOV R1, #0         # Limpiar el registro de la tecla
    LDR R2, [GPIO_IN]  # Leer las columnas
    TST R2, #COL1_PIN  # Comprobar si la columna 1 está activa
    BEQ key_detected   # Si la columna 1 está activa, detectar tecla
    TST R2, #COL2_PIN  # Comprobar si la columna 2 está activa
    BEQ key_detected   # Si la columna 2 está activa, detectar tecla
    TST R2, #COL3_PIN  # Comprobar si la columna 3 está activa
    BEQ key_detected   # Si la columna 3 está activa, detectar tecla
    TST R2, #COL4_PIN  # Comprobar si la columna 4 está activa
    BEQ key_detected   # Si la columna 4 está activa, detectar tecla

    MOV R0, #ROW2_PIN  # Seleccionar la fila 2
    STR R0, [GPIO_OUT] # Activar la fila 2
    LDR R2, [GPIO_IN]  # Leer las columnas
    TST R2, #COL1_PIN  # Comprobar si la columna 1 está activa
    BEQ key_detected   # Si la columna 1 está activa, detectar tecla
    TST R2, #COL2_PIN  # Comprobar si la columna 2 está activa
    BEQ key_detected   # Si la columna 2 está activa, detectar tecla
    TST R2, #COL3_PIN  # Comprobar si la columna 3 está activa
    BEQ key_detected   # Si la columna 3 está activa, detectar tecla
    TST R2, #COL4_PIN  # Comprobar si la columna 4 está activa
    BEQ key_detected   # Si la columna 4 está activa, detectar tecla

    MOV R0, #ROW3_PIN  # Seleccionar la fila 3
    STR R0, [GPIO_OUT] # Activar la fila 3
    LDR R2, [GPIO_IN]  # Leer las columnas
    TST R2, #COL1_PIN  # Comprobar si la columna 1 está activa
    BEQ key_detected   # Si la columna 1 está activa, detectar tecla
    TST R2, #COL2_PIN  # Comprobar si la columna 2 está activa
    BEQ key_detected   # Si la columna 2 está activa, detectar tecla
    TST R2, #COL3_PIN  # Comprobar si la columna 3 está activa
    BEQ key_detected   # Si la columna 3 está activa, detectar tecla
    TST R2, #COL4_PIN  # Comprobar si la columna 4 está activa
    BEQ key_detected   # Si la columna 4 está activa, detectar tecla

    MOV R0, #ROW4_PIN  # Seleccionar la fila 4
    STR R0, [GPIO_OUT] # Activar la fila 4
    LDR R2, [GPIO_IN]  # Leer las columnas
    TST R2, #COL1_PIN  # Comprobar si la columna 1 está activa
    BEQ key_detected   # Si la columna 1 está activa, detectar tecla
    TST R2, #COL2_PIN  # Comprobar si la columna 2 está activa
    BEQ key_detected   # Si la columna 2 está activa, detectar tecla
    TST R2, #COL3_PIN  # Comprobar si la columna 3 está activa
    BEQ key_detected   # Si la columna 3 está activa, detectar tecla
    TST R2, #COL4_PIN  # Comprobar si la columna 4 está activa
    BEQ key_detected   # Si la columna 4 está activa, detectar tecla

    BX LR              # Regresar si no se detectó ninguna tecla

# Detectar la tecla presionada
key_detected:
    # Dependiendo de la fila y columna activa, asignar el valor de la tecla
    MOV R1, #0         # Limpiar R1

    CMP R0, #ROW1_PIN  # Verificar si la fila es la 1
    BEQ fila_1

    CMP R0, #ROW2_PIN  # Verificar si la fila es la 2
    BEQ fila_2

    CMP R0, #ROW3_PIN  # Verificar si la fila es la 3
    BEQ fila_3

    CMP R0, #ROW4_PIN  # Verificar si la fila es la 4
    BEQ fila_4
    BX LR

fila_1:
    CMP R2, #COL1_PIN  # Comprobar columna 1
    BEQ tecla_1
    CMP R2, #COL2_PIN  # Comprobar columna 2
    BEQ tecla_2
    CMP R2, #COL3_PIN  # Comprobar columna 3
    BEQ tecla_3
    CMP R2, #COL4_PIN  # Comprobar columna 4
    BEQ tecla_A
    BX LR

fila_2:
    CMP R2, #COL1_PIN  # Comprobar columna 1
    BEQ tecla_4
    CMP R2, #COL2_PIN  # Comprobar columna 2
    BEQ tecla_5
    CMP R2, #COL3_PIN  # Comprobar columna 3
    BEQ tecla_6
    CMP R2, #COL4_PIN  # Comprobar columna 4
    BEQ tecla_B
    BX LR

fila_3:
    CMP R2, #COL1_PIN  # Comprobar columna 1
    BEQ tecla_7
    CMP R2, #COL2_PIN  # Comprobar columna 2
    BEQ tecla_8
    CMP R2, #COL3_PIN  # Comprobar columna 3
    BEQ tecla_9
    CMP R2, #COL4_PIN  # Comprobar columna 4
    BEQ tecla_C
    BX LR

fila_4:
    CMP R2, #COL1_PIN  # Comprobar columna 1
    BEQ tecla_E
    CMP R2, #COL2_PIN  # Comprobar columna 2
    BEQ tecla_0
    CMP R2, #COL3_PIN  # Comprobar columna 3
    BEQ tecla_F
    CMP R2, #COL4_PIN  # Comprobar columna 4
    BEQ tecla_D
    BX LR

# Si se presiona una tecla numérica
tecla_1: 
    MOV R1, #'1'
    LDR R0, [accumulator]    # Cargar el número acumulado
    MUL R0, R0, #10          # Multiplicar por 10
    ADD R0, R0, #'1'         # Sumar el valor de la tecla (en número)
    STR R0, [accumulator]    # Almacenar el nuevo valor en el acumulador
    BX LR

tecla_2: 
    MOV R1, #'2'
    LDR R0, [accumulator]
    MUL R0, R0, #10
    ADD R0, R0, #'2'
    STR R0, [accumulator]
    BX LR

tecla_3: 
    MOV R1, #'3'
    LDR R0, [accumulator]
    MUL R0, R0, #10
    ADD R0, R0, #'3'
    STR R0, [accumulator]
    BX LR

tecla_4: 
    MOV R1, #'4'
    LDR R0, [accumulator]
    MUL R0, R0, #10
    ADD R0, R0, #'4'
    STR R0, [accumulator]
    BX LR

tecla_5: 
    MOV R1, #'5'
    LDR R0, [accumulator]
    MUL R0, R0, #10
    ADD R0, R0, #'5'
    STR R0, [accumulator]
    BX LR

tecla_6: 
    MOV R1, #'6'
    LDR R0, [accumulator]
    MUL R0, R0, #10
    ADD R0, R0, #'6'
    STR R0, [accumulator]
    BX LR

tecla_7: 
    MOV R1, #'7'
    LDR R0, [accumulator]
    MUL R0, R0, #10
    ADD R0, R0, #'7'
    STR R0, [accumulator]
    BX LR

tecla_8: 
    MOV R1, #'8'
    LDR R0, [accumulator]
    MUL R0, R0, #10
    ADD R0, R0, #'8'
    STR R0, [accumulator]
    BX LR

tecla_9: 
    MOV R1, #'9'
    LDR R0, [accumulator]
    MUL R0, R0, #10
    ADD R0, R0, #'9'
    STR R0, [accumulator]
    BX LR

tecla_0: 
    MOV R1, #'0'
    LDR R0, [accumulator]
    MUL R0, R0, #10
    ADD R0, R0, #'0'
    STR R0, [accumulator]
    BX LR


