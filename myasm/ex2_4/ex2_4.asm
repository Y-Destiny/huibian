;要求从键盘上接收一个4位十六进制数，然后在显示器上显示其对应的16位二进制数。 （
DATA SEGMENT
    CHANGELINE DB 13,10,'$'
    STR1 BYTE 'please input the hexadecimal number: $'
    STR2 BYTE 'the binary number is: $'
    STR3 BYTE 'the hexadecimal number is must in (0-9),(A-F)or(a-f),please reload this number: $'
DATA ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATA, SS:STACKS
START:
    MOV AX, DATA
    MOV DS, AX
    MOV CX,0404H
    MOV BX,0

    MOV DX,OFFSET STR1
    MOV AH,09H
    INT 21H
L1:
    MOV AH,01H
    INT 21H
    CMP AL,30H;判断输入ascll码是否<0，若<0则提示重新输入4位16进制数
    JL  L5
    SUB AL,30H;数字0-9ascll码减30H得到00H-09H
    CMP AL,0AH;判断输入是否<10，若<10则将该位存入bx
    JL  L2
    SUB AL,07H;A-F ascll码减30H后减07H得到0AH-0FH
    ;判断输入是否在A-F之间，若不是则提示重新输入4位16进制数，否则该位存入bx
    CMP AL,0AH
    JL  L5
    CMP AL,10H
    JL  L2
    SUB AL,20H;A-F ascll码减30H减07H后再减20H得到0AH-0FH
    ;判断输入是否在a-f之间，若不是则提示重新输入4位16进制数，否则该位存入bx
    CMP AL,0AH
    JL  L5
    CMP AL,10H
    JGE  L5
L2:
    SHL BX,CL
    OR  BL,AL
    DEC CH
    JNZ L1

    CALL CRLF

    MOV DX,OFFSET STR1
    MOV AH,09H
    INT 21H
    MOV CH,10H
L3:
    MOV DL,30H
    SHL BX,1
    JNC L4
    MOV DL,31H
L4:
    MOV AH,02H
    INT 21H
    DEC CH
    JNZ L3

    CALL CRLF
    JMP START
    
L5:
    CALL CRLF
    MOV DX,OFFSET STR3
    MOV AH,09H
    INT 21H
    MOV CH,04H
    MOV Bx,0
    JMP L1

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