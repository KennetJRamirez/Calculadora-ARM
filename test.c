#include "arithmetic.h"      
#include "math_functions.h" 
#include "trigonometry.h"     

int main() {
    int result;

    result = arithmetic_add(5, 3);        
    result = arithmetic_subtract(5, 3);   
    result = arithmetic_multiply(5, 3);   
    result = arithmetic_divide(6, 3);     

    result = math_factorial(5);           
    result = math_exponential(2);         
    result = math_log(10);                 

    result = trig_sin(30);              
    result = trig_cos(30);                
    result = trig_tan(30);                 

    return 0;
}
