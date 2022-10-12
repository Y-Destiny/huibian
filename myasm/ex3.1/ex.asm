;习题5.22：从键盘输入一系列字符（以回车符结束），并按字母、数字及其他字符分类计数，最后显示这三类字符的计数结果（使用子程序BINIDEC）。
;子程序 BINIDEC：将BX中的无符号数用十进制数的形式输出。

DATA SEGMENT
    Count_Letter DB 0
    Count_Digit DB 0
    Count_Other DB 0
    STR  BYTE 'Please input string:$'
    STR1 BYTE 'Count_Other is:$'
    STR2 BYTE 'Count_Letter is:$'
    STR3 BYTE 'Count_Digit is:$'
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
L0: 
        MOV AH, 01H
        INT 21H
        CMP AL,0DH
        JZ  PRINT

        CMP AL, 30H
        JL  OTHER 
        CMP AL, 39H
        JLE DIGIT
        CMP AL, 41H
        JL  OTHER
        CMP AL, 5AH
        JLE LETTER 
        CMP AL, 61H
        JL  OTHER
        CMP AL, 7AH
        JLE LETTER
OTHER:
        INC Count_Other
        JMP L0
DIGIT:
        INC Count_Digit
        JMP L0
LETTER:
        INC Count_Letter
        JMP L0
PRINT:
        LEA DX, STR1
        MOV AH, 09H
        INT 21H
        MOV AX, 0
        MOV AL, Count_Other
        CALL BINIDEC
        LEA DX, STR2
        MOV AH, 09H
        INT 21H
        MOV AX, 0
        MOV AL, Count_Letter
        CALL BINIDEC
        LEA DX, STR3
        MOV AH, 09H
        INT 21H
        MOV AX, 0
        MOV AL, Count_Digit
        CALL BINIDEC
        MOV AH, 4CH
        INT 21H
;description
BINIDEC PROC NEAR
    MOV BL,10
    DIV BL         ;除数在BL,商存在AL,余数存在AH
    
    PUSH AX
    
    MOV DL,AL 
    ADD DL,30H    ;输出商
    MOV AH,02H
    INT 21H
    
    POP AX
    
    MOV DL,AH
    ADD DL,30H
    MOV AH,02H
    INT 21H

    MOV DL,0DH
    MOV AH,02H
    INT 21H
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    RET
BINIDEC ENDP
CODES ENDS
END START