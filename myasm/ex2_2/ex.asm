;用15行*16列的表格形式显示ASCII码为10H-FFH的所有字符（双重循环程序）
DATA SEGMENT
    CHANGELINE DB 13,10,'$'
DATA ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATA, SS:STACKS
START:
    MOV AX, DATA
    MOV DS, AX
    MOV CX,0F10H
    MOV BL,10H
L1: MOV AH,02H
    MOV DL,20H
    INT 21H

    MOV DL,BL
    INT 21H
    INC DL
    MOV BL,DL
    DEC CL
    JNZ L1

    CALL CRLF
    
    DEC CH
    MOV CL,10H
    JNZ L1

    MOV AH, 4CH
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
CODES ENDS
END START