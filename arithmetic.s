.section .text
.global arithmetic_add
.global arithmetic_subtract
.global arithmetic_multiply
.global arithmetic_divide


arithmetic_add:
    ADD R0, R1, R2
    BX LR

arithmetic_subtract:
    SUB R0, R1, R2
    BX LR

arithmetic_multiply:
    MUL R0, R1, R2
    BX LR

arithmetic_divide:
    CMP R2, #0        
    BEQ div_by_zero   
    UDIV R0, R1, R2   
    BX LR

div_by_zero:
    MOV R0, #0        
    BX LR
