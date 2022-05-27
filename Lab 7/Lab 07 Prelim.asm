CS224
Lab 06
Sec No. 06
Izaan Aamir
22001488

Faaiz Khan 
22001476

a) Specify the special function registers (SFRs) for the I/O device(s) involved in Part2-b

TRISA: to show direction of DC Motor as output
TRISE: push button input
PORTA: output write
PORTE: input read

b) C code for Part2-b, with lots of comments, an explanatory header, well-chosen identifiers and good use of spacing and layout to make your program self-documenting. 

void main() {
  JTAGEN_bit = 0;
  AD1PCFG = 0xFFFF;      // Configure AN pins as digital I/O
  TRISE = 0XFF;  //This port is used for input
  TRISA = 0xFFFC;  //This port is used for output determining the turning direction of DC motor
  
  PORTE = 0x0000;  // reset the values
  PORTA = 0xFFFC;  // reset the values 

  while(1) {
      if ( PORTEbits.RE0 == 1 || PORTEbits.RE1 == 1 ) {
           PORTAbits.RA0 = PORTEbits.RE0;  //turns clockwise
           PORTAbits.RA1 = PORTEbits.RE1; // turns anticlockwise
      }      
  }
}

c) Specify the special function registers (SFRs) for the I/O device(s) involved in Part2-c. 
TRISA: determines which number to be displayed as an output to D
TRISE:  displays the related digit in the seven segment display as an output to AN
PORTA: writes to D
PORTE: writes to AN



d) C code for Part2-c, with lots of comments, an explanatory header, well-chosen identifiers and good use of spacing and layout to make your program self-documenting. 

// Hexadecimal values for digits in seven segment display
unsigned char hex_values[]={0x2C,0x08,0x09,0x6F,0x22,0x1D,0x77,0x01,0x33,0x23};
unsigned int numbers[] = {0,1,2,3};

void main() {

  AD1PCFG = 0xFFFF;      // Configure AN pins as digital I/O
  JTAGEN_bit = 0;        // Disable JTAG
      
  TRISA = 0x00;  //this port outputs to D
  TRISE = 0x00;  //this port outputs to AN

  while(1)
  {
    for (int i= 0; i< 500; i++) { //loop to display each number at least 1 second
    // First Digit display
    PORTA=hex_values[numbers[0]];     // number is displayed on the first digit of the seven segment display
    PORTE=0x01;                  // Wait 1 ms to switch to the next digit
    Delay_ms(1);
    
    // Second Digit display
    PORTA=hex_values[numbers[1]];     //  number is displayed on second digit of the seven segment 
    PORTE=0x02;                  // Wait 1 ms to switch to the next digit
    Delay_ms(1);
    
    // Third Digit display
    PORTA=hex_values[numbers[2]];  // number is displayed on third digit of the seven segment 
    PORTE=0x04;                 // Wait 1 ms to switch to the next digit
    Delay_ms(1);
    
    // Fourth Digit display
    PORTA=hex_values[numbers[3]];  // number is displayed on fourth digit of the seven segment  
    PORTE=0x08;                 // Wait 1 ms to switch to the next digit
    Delay_ms(1);
    }	
    for (int j = 0;j< 4;j++){ //incrementing the values
	numbers[j]++;
     }
    // check to keep values under 10
    if (numbers[0] > 9) {
      num1 = 1;
    }
    if (numbers[1] > 9) {
      num2 = 1;
    }
    if (numbers[2] > 9) {
      num3 = 1;
    }
    if (numbers[3] > 9) {
      num4 = 1;
    }

  }
}

e) Specify the special function registers (SFRs) for the I/O device(s) involved in Part2-d. 

       TRISA:  LEDs output which shows the counted number
       TRISE -> shows related digit on seven segment display as an input to AN
       PORTA -> to write D
       PORTE -> to write AN


f) C code for Part2-d, with lots of comments, an explanatory header, well-chosen identifiers and good use of spacing and layout to make your program self-documenting. 



bool correctPos = true;
char numCount = 0111111111;

void main() {

 AD1PCFG = 0xFFFF; // Configure AN pins as digital I/O
 DDPCON.JTAGEN = 0; // disable JTAG

 TRISA = 0x0000;   // use A port LED outputs
 TRISE = 0xFFFF;   // use E port for button inputs

 PORTA = 0XFFFF;   // reset LEDs
 PORTE = 0X0000;   // reset buttons

}

