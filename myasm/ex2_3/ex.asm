;从键盘上输入一个8位二进制数，在显示器上显示其相应的十六进制数
DATA SEGMENT
    CHANGELINE DB 13,10,'$'
    STR1 BYTE 'please input the binary number(8 bit): $'
    STR2 BYTE 'the hexadecimal number is: $'
    STR3 BYTE 'the binary number  is must 0 or 1,please reload this number: $'
DATA ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATA, SS:STACKS
START:
    MOV AX, DATA
    MOV DS, AX
    MOV CH,08H
    MOV BL,00H

    MOV DX,OFFSET STR1
    MOV AH,09H
    INT 21H
L1:
    SAL BX,1
    MOV AH,01H
    INT 21H
    ;判断是否为0或1，若不是，则提示重新输入8位二进制数
    SUB AL,30H
    CMP AL,00H
    JL  L4
    CMP AL,01H
    JG  L4
    OR  BL,AL
    DEC CH
    JNZ L1

    CALL CRLF

    MOV DX,OFFSET STR2
    MOV AH,09H
    INT 21H

    MOV CX,0204H
L2:
    ROL BL,CL
    MOV AL,BL
    AND AL,0FH
    ADD AL,30H
    CMP AL,3AH
    JL  L3
    ADD AL,07H
L3:
    MOV DL,AL
    MOV AH,02H
    INT 21H
    DEC CH
    JNZ L2
    MOV AH, 4CH
    INT 21H

L4:
    CALL CRLF
    MOV DX,OFFSET STR3
    MOV AH,09H
    INT 21H
    MOV CH,08H
    MOV BL,00H
    JMP L1


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