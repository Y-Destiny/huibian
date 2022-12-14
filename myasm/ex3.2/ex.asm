DATA SEGMENT
   STR BYTE 'please input the equation(just(int)'+'or'-'):$' 
DATA ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATA, SS:STACKS
START:
    MOV AX, DATA
    MOV DS, AX
    LEA DX, STR
    MOV AH, 09H
    INT 21H
    CALL DECIBIN
    MOV SI, BX
L0: CMP AL, 2BH
    JZ  DoAdd
    CMP AL, 2DH
    JZ  DoSub
    CMP AL, 3DH
    JZ  print
    JMP ERROR
DoAdd:
    CALL DECIBIN
    ADD SI, BX
    JMP L0
DoSub:
    CALL DECIBIN
    SUB SI, BX
    JMP L0
print:
    MOV AX, SI
    CALL BINIDEC
ERROR:   
    MOV AH, 4CH
    INT 21H
;输入十进制数
DECIBIN PROC NEAR
    MOV BX, 00H
NEWNUM:
    MOV AH, 01H
    INT 21H
    CMP AL, 30H
    JL  EXIT
    CMP AL, 39H
    JG  EXIT
    SUB AL, 30H
    MOV AH, 00H
    XCHG AX, BX
    MOV CX, 10D
    MUL CX
    XCHG BX, AX
    ADD BX,AX
    JMP NEWNUM
EXIT:
    RET
DECIBIN ENDP
;有符号数转十进制输出,入口参数SI
BINIDEC PROC NEAR
        PUSH BX
        PUSH DX
        MOV BX, SI

        CMP AX, 0
        JS  NEGATIVE
        JZ  ZERO
        JMP POSITIVE

    NEGATIVE:
        MOV DL, 2DH
        MOV AH, 02H
        INT 21H

        NEG	BX
        CALL OUTPUTNUM
        JMP DECIBINOVER
    POSITIVE:
        CALL OUTPUTNUM
        JMP DECIBINOVER
    ZERO:
        MOV DL,30H
        MOV AH,02H
        INT 21H
        MOV DL,0DH
        MOV AH,02H
        INT 21H
        MOV DL,0AH
        MOV AH,02H
        INT 21H
    DECIBINOVER:
        POP DX
        POP BX
        RET
BINIDEC ENDP
;输出十进制数,人口参数BX
OUTPUTNUM PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    MOV AX, BX
    MOV CX, 000AH
DoDiv:
    CMP AX, 0
    JZ  DIVOVER
    INC CH
    DIV CL
    PUSH AX
    MOV AH, 0
    JMP DoDiv
DIVOVER:
    CMP CH,0
    JZ  OUTOVER
    DEC CH
    POP AX
    MOV DL, AH
    ADD DL, 30H
    MOV AH, 02H
    INT 21H
    JMP DIVOVER

OUTOVER:
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H

    POP CX
    POP BX
    POP AX
    RET
OUTPUTNUM ENDP
CODES ENDS
END START