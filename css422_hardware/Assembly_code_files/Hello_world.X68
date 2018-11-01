*-----------------------------------------------------------
* Title      : Assembly HelloWorld
* Written by : Urmum Bangsohard
* Date       :
* Description: The quick start guide from easy68k.com
*-----------------------------------------------------------
    ORG     $1000           ; first instruction of program
START:
*----- Code for output -----
LOOP    LEA         MESSAGE,A1   *Loads MESSAGE into address register A1
        MOVE.B      #14,D0       *Moves the number 14 into data register D0
        TRAP        #15          *Executes trap task, as the value read from D0, which displays MESSAGE
    
*----- Code for output -----
        MOVE.B      #4,D0        *TRAP code 4 tells the assembler to save input from keyboard
        TRAP        #15
    
        CMP.L       #0,D1        *Compare D1 to the number 0
        BEQ         DONE         *Branch to DONE if they are equal
        
        CMP.B       #0,D1        *Compare D1 to 0
        BLT         INVALID      *BLT branches if D1 is less than 0
        CMP.B       #9,D1        *Compares D1 to 1
        BGT         INVALID      *BGT branches if D1 is greater than 9
        
        BRA         LOOP 

INVALID LEA         INV,A1
        MOVE.B      #14,D0
        TRAP        #15
        BRA         LOOP
    
DONE    MOVE.B      #9,D0        *Staging trap code for halting code
        TRAP        #15          *Execute the trap code at D0, Halt the simulation
        
        
*This equates to an 'else' clause where we now branch because the values weren't equal
    

* Put variables and constants here
CR      EQU     $0D
LF      EQU     $0A
INV     DC.B    'That is not a number between 1 and 9',CR,LF,0
MESSAGE DC.B    'HELLO WORLD',CR,LF
        DC.B    'ALL CAPS FOR SHOUTING',CR,LF
        DC.B    'END OF LINE',CR,LF,'Hey, enter a number Bruh...',CR,LF,0
        END     START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
