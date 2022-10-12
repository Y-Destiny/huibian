DATA	SEGMENT                                          
      	BUF  	DB  23H,16H,08H,20H,64H,8AH,91H,35H,2BH,7FH  
      	CN   	EQU $-BUF 
DATA	ENDS
CODE 	SEGMENT      
      	ASSUME    CS:CODE,DS:DATA
START:	PUSH DS                                 
      	XOR  AX,AX 
      	PUSH AX
		MOV  AX,DATA
      	MOV  DS,AX

		                  
		

      	MOV  BX,OFFSET BUF               
      	MOV  CX,CN                       
      	DEC  CX                          
      	MOV  AL,[BX]                     
      	INC  BX                         
LP:	     CMP  AL,[BX]                    
      	JBE  NEXT                        
      	MOV  AL,[BX]                     
NEXT:	INC  BX                           
      	DEC  CX                          
      	JNZ  LP
		ADD  AL,48    
		MOV  DL,AL                      
      	MOV  AH,02H 
		INT  21H 	
		INT  20H                        
CODE	ENDS                             
      	END  START
