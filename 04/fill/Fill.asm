// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

@256
D = A
@n     //number of rows
M = D

@32
D = A
@m     //number of columns
M = D

@status
M = 0

(GAMELOOP)
@i 
M = 0  //i = 0

@j
M = 0   //j = 0

//initialize data
@SCREEN 
D = A   //copy address value
@address
M = D   // address = 16384
@address2
M = 0   //for inner loop to manipulate


@KBD 
D = M

@status 
M = 0
@PAINT
D;JEQ	//jump to paint with status zero if D value is zero

@status
M = -1
@PAINT	//jump to paint with status -1 if D value has something greater than zero
D;JGT

@GAMELOOP
0;JMP

(PAINT)
    //BOUNDARY CHECK
    @i
    D = M
    @n 
    D = D - M
    @GAMELOOP
    D;JEQ       // if i > n just get out
    
    @address    //update the address for column manipulation
    D = M
    @address2   //copy
    M = D
    @j          //reset j again
    M = 0 
        
    //COMPUTATION
        (LOOP2)
        //BOUNDARY CHECK FOR INNERLOOP
        @j
        D = M
        @m 
        D = D - M 
        @POST
        D;JEQ

        //COMPUTATION LOGIC
      
        @status
        D = M
        @address2
        A = M
        M = D  //RAM[address] = status
    
        //INNER LOOP POST INCREMENTS
        @j
        M = M + 1
        @address2
        M = M + 1
        @LOOP2
        0;JMP

    (POST)
    //POST INCREMENTS
    @i
    M = M + 1
    @32
    D = A 
    @address
    M = D + M   //address = address + 32 next row
    @PAINT
    0;JMP

