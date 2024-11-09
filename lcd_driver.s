    .section .text
    .global lcd_init
    .global lcd_send_command
    .global lcd_send_data
    .global lcd_clear
    .global lcd_display_char

# Dirección I2C del LCD 
LCD_I2C_ADDR = 0x27

# Registros I2C 
I2C0_BASE = 0x40054000          # Dirección base de los registros I2C0
I2C0_CTRL = I2C0_BASE + 0x00     # Control de I2C
I2C0_STATUS = I2C0_BASE + 0x04   # Estado de I2C
I2C0_DATA = I2C0_BASE + 0x10     # Registro de datos de I2C

# Comandos de inicialización LCD 16x2
LCD_INIT_CMD_1 = 0x38           # Función set: 8 bits, 2 líneas, 5x8 píxeles
LCD_INIT_CMD_2 = 0x0C           # Encender LCD sin cursor
LCD_INIT_CMD_3 = 0x06           # Incrementar el cursor después de escribir
LCD_INIT_CMD_4 = 0x01           # Limpiar pantalla

# Función de inicialización del LCD
lcd_init:
    # Habilitar el bus I2C 
    MOV R0, #0x01               # Habilitar el bus I2C
    STR R0, [I2C0_CTRL]         # Almacenar la configuración en el registro I2C0_CTRL
    
    # Enviar comandos de inicialización al LCD
    MOV R0, LCD_INIT_CMD_1      # Comando de inicialización 8 bits
    BL lcd_send_command         # Enviar comando
    MOV R0, LCD_INIT_CMD_2      # Encender LCD sin cursor
    BL lcd_send_command         # Enviar comando
    MOV R0, LCD_INIT_CMD_3      # Configurar incremento del cursor
    BL lcd_send_command         # Enviar comando
    MOV R0, LCD_INIT_CMD_4      # Limpiar pantalla
    BL lcd_send_command         # Enviar comando
    
    BX LR                       # Retornar de la función

# Función para enviar un comando al LCD
lcd_send_command:
    MOV R1, #0x00               # 0x00: Indicar que es un comando
    STR R1, [I2C0_DATA]         # Almacenar el comando en el registro de datos
    BL i2c_wait                 # Esperar que el comando se haya enviado
    BX LR

# Función para enviar un dato al LCD
lcd_send_data:
    MOV R1, #0x40               # 0x40: Indicar que es un dato (carácter)
    STR R1, [I2C0_DATA]         # Almacenar el dato en el registro de datos
    BL i2c_wait                 # Esperar que el dato se haya enviado
    BX LR

# Función para limpiar la pantalla del LCD
lcd_clear:
    MOV R0, #0x01               # Comando para limpiar pantalla
    BL lcd_send_command         # Enviar el comando de limpiar
    BX LR

# Función para mostrar un carácter en el LCD
lcd_display_char:
    # R0 contiene el valor del carácter a mostrar
    MOV R1, #0x40               # Indicar que es un dato (no un comando)
    STR R0, [I2C0_DATA]         # Almacenar el dato en el registro de datos
    BL i2c_wait                 # Esperar que el dato se haya enviado
    BX LR

# Función de espera 
i2c_wait:
    MOV R0, #0x01               # Esperar por el bit de finalización en el estado del I2C
wait_loop:
    LDR R1, [I2C0_STATUS]       # Leer el estado del I2C
    TST R1, #0x01               # Verificar si el bus está libre
    BEQ wait_loop               # Si no está libre, seguir esperando
    BX LR                       # Cuando el bus esté libre, regresar
