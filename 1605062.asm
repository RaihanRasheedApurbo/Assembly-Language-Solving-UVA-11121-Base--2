TITLE PGM4_1.5: SAMPLE INPUT
.MODEL SMALL
.STACK 100H
.DATA

MSG DB 'HELLO!$'   
DIVISOR DW ? 
DIVIDEND DW ?
REMINDER DW ?
MUSK DW ?
RESULT DW ? 
MULTIPLIER DW ?
CONSTANT1 DB ? 
CONSTANT2 DW ?
INCREMENTFLAG DW ? 
ITERATION DW ?
ITERATIONSAVE DW ?
RESULTREVERSE DW ?
CONSTANT3 DW ?
NEGETIVEFLAG DW ? 
TESTCASE DW ?


MAIN PROC
;INITIALIZE DS
MOV DX,@DATA
MOV DS,DX   

;INITIALIZATION COMPLETE


;CODE STARTS FROM HERE



;SOME STRUCTURES ARE BELOW


;1.DISPLAY CHARACTER
;MOV DL,5;THIS THREE LINES HELPS US TO
;MOV AH,2;DISPLAY 5 INTO THE CONSOLE
;INT 21H; WE CAN ONLY PRINT THE VALUE OF DL REGISTER SEGMENT


;2.INPUT A CHARACTER
;MOV AH,1
;INT 21H
;MOV BL,AL;THE INPUT IS SAVED IN AL RESGISTER SEGMENT
;WE ARE TRANSFERRING TO BL I DON'T KNOW WHY :V   


;3.LETS GO TO A NEW LINE
;MOV AH,2
;MOV DL,0DH
;INT 21H
;MOV DL,0AH
;INT 21H
;THATS ALL


;4.DISPLAY A MESSAGE
;LEA DX,MSG ; TRANSFERRING POINTER OF MESSAGE ARRAY IN DX
;MOV AH,9 ; AH=9 TO DISPLAY A MESSAGE
;INT 21H  ;PRINTS THE MESSAGE
;NEED TO REMEMBER ONE THING THE END CHARACTER OF THE MESSAGE
;SHOULD BE $ OTHERWISE THE PROGRAM WILL CRASH 



                 ;************SLIDE 2**************;

;5.
;Label1:
;MOV x,3     ;THESE ARE EQUIVALENT TO GOTO IN C  	             
;MOV y,4     ;JMP STANDS FOR JUMP
;JMP Label1  ;THIS CREATES A UNCONDITIONAL JUMP


;6.SINGLE IF STATEMENT   
;HERE JNL JUMP IF NOT LESS; CMP IS COMPARE

;CMP AX,0
;JNL END_IF:; JNL IS EQUAL TO !(AX<0) CONDITION WHICH IS STANDS FOR JUMP IF NOT LESS THAN
;NEG AX ;//// HERE SHOULD UNDER THE IF STATEMENT CONDITION GO
;       ;//// WE ARE JUST NEGETING HERE 
;END_IF:
                 
      
       

;7. IF ELSE STATEMENT  
; JNLE IS JUMP IF NOT LESS THAN OR EQUAL
;CMP AL,BL
;JNLE ELSE
;MOV DL,AL
;JMP DISPLAY
;ELSE:
;MOV DL,BL
;DISPLAY:
;MOV AH,2
;INT 21H 


;8.BOOLEAN AND OPERATION  
; JNL IS JUMP IF NOT LESS


;CMP AL,BL
;JNL END_IF
;CMP AL,BH
;JNL END_IF
;;UNDER IF STATEMENTS
;MOV DL,AL
;MOV AH,2
;INT 21H
;END_IF: 


 ; TAKING INPUT FROM KEYBOARD ;
 ; AT FIRST TAKING INPUT FOR TOTAL TEST CASE 
 
MOV TESTCASE,0; 
LOOP5:
    MOV AH,1;
    INT 21H;
    MOV BL,AL;
    CMP BL,0DH;
    JE ENDLOOP5; IF EQUAL THEN WE ARE OUT FROM LOOP
    SUB BL,'0'; MAKING ASCII TO BINARY
    MOV AX,TESTCASE;
    MUL CONSTANT3; DIVIDEND = DIVIDEND * 10;
    MOV BH,0; MAKING FRONT BYTE 0 SO THAT BX HOLD THE VALUE OF BL
    ADD AX,BX;     DIVIDND = DIVIDEND + NEW INPUT
    MOV TESTCASE,AX;   DIVIDEND = AX;
    JMP LOOP5; REITERATION STARTS
    
    
    
ENDLOOP5:

; FORMULA FOR PRINTING NEW LINE  ;
;3.LETS GO TO A NEW LINE
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H;THATS ALL 


; THIS LOOP COUNT TOTAL TEST CASE REMAINING
WRAPLOOP:
CMP TESTCASE,0;
JE ENDWRAPLOOP;
 
 
 
 
 
 
 
MOV DIVIDEND , 0;    
MOV CONSTANT3,10;
MOV NEGETIVEFLAG,0; 



; AT FIRST WE WOULD CHECK WHEHTER THE FIRST CHARACTER IS - SIGN OR NOT
MOV AH,1;
INT 21H;
CMP AL,'-';
JNE POSITIVENUMBER;
MOV NEGETIVEFLAG,1; 
 
 
LOOP4:
    MOV AH,1;
    INT 21H;
    ; INPUT IS SAVED IN AL WE ARE TRANSFERRING IT TO BL SEGMENT;
    POSITIVENUMBER:
    MOV BL,AL;
    CMP BL,0DH;
    JE ENDLOOP4; IF EQUAL THEN WE ARE OUT FROM LOOP
    SUB BL,'0'; MAKING ASCII TO BINARY
    MOV AX,DIVIDEND;
    MUL CONSTANT3; DIVIDEND = DIVIDEND * 10;
    MOV BH,0; MAKING FRONT BYTE 0 SO THAT BX HOLD THE VALUE OF BL
    ADD AX,BX;     DIVIDND = DIVIDEND + NEW INPUT
    MOV DIVIDEND,AX;   DIVIDEND = AX;
    JMP LOOP4; REITERATION STARTS
    
    
    
ENDLOOP4:  
         
CMP NEGETIVEFLAG,1;
JNE START;
NEG DIVIDEND; MAKING THE INPUT NEGETIVE



START: ; IF POSITIVE THEN NEG DIVIDEND; LINE IS ESCAPED
; FORMULA FOR PRINTING NEW LINE  ;
;3.LETS GO TO A NEW LINE
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H;THATS ALL






MOV AX , DIVIDEND; INITIALIZING DIVIDEND AX
;MOV DIVIDEND,AX; KEEPING A COPY INCASE NEEDED 
MOV RESULT , 0 ; INITIALIZING RESULT WITH 0 
MOV MULTIPLIER , 1; IT WILL BE USED TO UPDATE RESULT IN EACH ITERATION 
MOV CONSTANT1 , 2; WE WILL USE IT AS THE SOURCE OF MULTIPLICATION
MOV CONSTANT2 , -2; THIS IS OUR BASE THAT WILL BE USED IN DIVISION
MOV ITERATION , 0 ; COUNTS TOTAL NUMBER OF ITERATIONS


CMP AX,0
JNE LOOP1;
MOV DL,'0';     IF INPUT IS 0 THEN WE WOULD PUT THE BINARY BY HARDCODING 
MOV AH,2;
INT 21H;
                                                                  
                                                                  
LOOP1: ; INSIDE THE LOOP THAT WILL FIND REMINDER IN EACH ITERATION 



    ; CHECKING WHETHER DIVIDEND IS 0 OR NOT
    
    MOV AX,DIVIDEND; AX = DIVIDEND
    CMP AX,0
    JE ENDLOOP1; ENDING THE LOOP HERE            
    INC ITERATION ; WE ARE NOW SURE THAT AX IS NOT 0 SO THERE WILL BE A ITERATION
    ; ODD OR EVEN DETECTION AND REMINDER SELECTION ; 
     
    
    
    MOV MUSK,1; MAKING A MASK TO FIND WHETHER THE DIVIDENT IS EVEN OR ODD
    AND MUSK,AX; IF MUSK IS 0 THEN THEN AX IS EVEN OTHERWISE ODD
    MOV AX,RESULT; AX = RESULT
    CMP MUSK,0;
    JE IF1; GOING TO IF STATEMENT REMINDER IS 0 CAUSE EVEN
    JMP ELSE1; OTHERWISE GOING TO ELSE
    IF1:
        MOV REMINDER,0 ; 
        MOV INCREMENTFLAG , 0; IF THE NUMBER IS NEGETIVE WE DON'T NEED TO INCREMENT AFTER DIVISION
        SHL AX,1; LEFTSHIFTING
        OR AX,0;
        JMP ENDIF1; GOING TO ENDIF
    ELSE1:
        MOV REMINDER ,1 ;
        MOV INCREMENTFLAG , 1; IF THE NUMBER IS NEGETIVE WE HAVE TO INCREMENT AFTER DIVISION
        ;MOV AX,MULTIPLIER; MOVING MULTIPLIER TO A REGISTER FOR ADDITION
        ;ADD RESULT,AX;     RESULT = RESULT + MULTIPLIER // REMINDER =1
        SHL AX,1; LEFTSHIFTING
        OR AX,1;
    
    ENDIF1: 
    
    MOV RESULT,AX;
    
    ; MULTIPLIER = MULTIPLIER *2 IMPLEMENTATION   
    
    
    ;MOV AX , MULTIPLIER; 
    ;MUL CONSTANT1; AX = AX * 2
    ;MOV MULTIPLIER,AX; PRESERVING THE RESULT IN MULTIPLIER FOR NEXT ITERATION
    
    
    
    ; GETTING NEXT DIVIDEND
    
    MOV AX,DIVIDEND;  
    CMP AX,0; COMPARING IF AX POSITIVE OR NEGETIVE
    JL IF2; GOING TO IF2 WHERE AX IS ASSUMED NEGETIVE
    JMP ELSE2; GOING TO ESLE2 WHERE AX IS ASSUMED POSITIVE
    IF2:
        MOV DX,-1; MAKING DX = FFFFH 
        IDIV CONSTANT2; AX = AX/-2;                  
        CMP INCREMENTFLAG,0; CHECKING INCREMENT IS NEEDED OR NOT
        JE ENDIF3
            INC AX; AX = AX + 1 // DIVIDEND = (DIVDIDENT /2) +1
        ENDIF3:       
        JMP ENDIF2; ENDING IF ELSE STATEMENT
    
    ELSE2:
        MOV DX,0; MAKING DX = 0000H
        IDIV CONSTANT2; AX = AX/-2
    
        
    ENDIF2:
    MOV DIVIDEND,AX; PRESERVING NEXT DIVIDEND 
    
    
    JMP LOOP1; REITERATION STARTS FROM HERE

ENDLOOP1: 
         
        ; REVERSING RESULT SO THAT IT CAN BE EASILY SHOWN INTO OUTPUT ;
         
MOV AX,ITERATION; 
MOV ITERATIONSAVE,AX; PRESERVING TOTAL ITEATION NUMBER IN A VARIABLE
                    ; SO THAT WE CAN NOW DECREMENT ITERATION VARIABLE

;MOV MULTIPLIER,1;      INITIALIZING MULTIPLIER AND REVERSE RESULT
;MOV RESULTREVERSE , 0;
;LOOP2:
    ;CMP ITERATION,0   ; 
    ;JLE ENDLOOP2; IF ITERATION IS LESS THAN OR EQUAL 0 THE LOOP SHOULD BE OVER
    ;MOV CL,1;
    ;SHL RESULTREVERSE,CL; SHIFTING 1 BIT TO LEFT TO PRESERVE THE BIT 
                        ; WE ARE SHIFTING CAUSE NOW WE ARE SURE THAT THERE IS 
                        ; ATLEAST A SINGLE ITERATION WILL HOLD
    
    ;MOV AX,RESULT; MOVING RESULT INTO AX REGISTER
    ;MOV MUSK,1;
    ;AND MUSK,AX; EXTRACTING LAST BIT OF MUSK 
    ;SHR AX,CL; SHIFTING LAST BIT TO RIGHT TO GET NEW BIT IN NEXT ITERATION
    ;MOV RESULT,AX; TRANSFERING NEW VALUE OF RESULT INTO RESULT AFTER SHIFTING
    ;MOV AX,MUSK
    ;OR RESULTREVERSE,AX;ADDING NEW BIT WITH RESULTREVERESE 


    
    ;DEC ITERATION; ITERATION--; 
    ;JMP LOOP2; REITERATION STARTS FROM HERE
;ENDLOOP2:            
    
            ; PRINTING REVERSE BIT ; 
MOV AX,RESULT;
MOV RESULTREVERSE,AX;            
MOV AX,ITERATIONSAVE;
MOV ITERATION,AX; ITERATION = ITERATIONSAVE


LOOP3:
    CMP ITERATION,0;
    JLE ENDLOOP3;
    ; FORMULA FOR DISPLAYING CHARECTER ;
    ;1.DISPLAY CHARACTER
;MOV DL,5;THIS THREE LINES HELPS US TO
;MOV AH,2;DISPLAY 5 INTO THE CONSOLE
;INT 21H; WE CAN ONLY PRINT THE VALUE OF DL REGISTER SEGMENT
    MOV BX,RESULTREVERSE; BX = REVERSERESULT
    MOV MUSK,1;
    AND MUSK,BX; EXTRACTING LAST BIT INTO MUSK
    SHR BX,1;
    MOV RESULTREVERSE,BX; PRESERVING NEW RESULT
    ADD MUSK,'0'; MAKING ASCII OF LAST BIT
    MOV DX,MUSK;
    MOV AH,2;
    INT 21H;







    DEC ITERATION; ITERATION--
    JMP LOOP3; REITERATION STARTS FROM HERE
ENDLOOP3: 



; FORMULA FOR PRINTING NEW LINE  ;
;3.LETS GO TO A NEW LINE
MOV AH,2
MOV DL,0DH
INT 21H
MOV DL,0AH
INT 21H;THATS ALL
    

 



DEC TESTCASE; TESTCASE--
JMP WRAPLOOP;

ENDWRAPLOOP:









;RETURN TO DOS
MOV AH,4CH
INT 21H    
MAIN ENDP


END MAIN