;输入一个字符，输出对应前驱和后继字符
DATA SEGMENT 
    STR1 BYTE 'please input CHAR: $'
    STR2 BYTE 'the answer is: $'
DATA ENDS
CODE SEGMENT 
    ASSUME CS:CODE
START:  MOV AX,DATA
        MOV DS,AX
        

L1:     MOV DX,OFFSET STR1
        MOV AH,09H
        INT 21H

        MOV AH,01H
        INT 21H
        MOV BL,AL
        CALL CRLF

        MOV DX,OFFSET STR2
        MOV AH,09H
        INT 21H
        MOV DL,BL
        SUB DL,01H ;从前驱字符开始输出
        MOV CH,03H
L2:     MOV AH,02H
        INT 21H
        ADD DL,01H
        DEC CH
        JNZ L2

        CALL CRLF
        JMP START
        MOV AH,4Ch
        INT 21H

;回车换行
CRLF PROC NEAR
       MOV DL,0DH
       MOV AH,02H
       INT 21H
       MOV DL,0AH
       MOV AH,02H
       INT 21H
       ret
CRLF ENDP
CODE ENDS
     END START