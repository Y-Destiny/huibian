                 
CODE 	SEGMENT      
      	ASSUME    CS:CODE
START:	MOV  DL,33H                  
		MOV  AH,02H                    
		INT    21H                   
		INT    20H                          
CODE	ENDS                             
      	END  START
