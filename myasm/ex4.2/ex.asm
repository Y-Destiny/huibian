DATA SEGMENT
    count dw 1
    MSG DB 'THE BELL IS RINGING!',0DH,0AH,'$'
DATA ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATA, SS:STACKS
START:
    MOV AX, DATA
    MOV DS, AX
    
    MOV AL,1CH
    MOV AH,35H
    INT 21H
    PUSH ES
    PUSH BX
    PUSH DS

    LEA DX, ring
    mov ax,seg ring
    mov ds, AX
    MOV AL,1CH
    MOV AH,25H
    INT 21H
    POP DS
    IN AL,21H
    AND AL,11111110B
    OUT 21H,AL
    STI
    MOV DI,20000
delay:
    MOV SI,20000
DELAY1:
    DEC SI
    JNZ DELAY1
    DEC DI
    JNZ delay
    POP DX
    POP DS
    MOV AL,1CH
    MOV AH,25H
    INT 21H
    MOV AX,4C00H
    INT 21H
    MOV AH, 4CH
    INT 21H
;description
ring PROC
    PUSH DS
    PUSH AX
    PUSH CX
    PUSH DX
    MOV AX,DATA
    MOV DS,AX
    STI
    DEC count
    JNZ EXIT
    MOV DX,OFFSET MSG
    MOV AX,09H
    INT 21H
    MOV DX,100
    IN AL,61h
    AND AL,0FCH
sound:
    XOR AL,02H
    OUT 61H,AL
    MOV CX,1400H
WAIT1:
    LOOP WAIT1
    DEC DX
    JNE sound
    MOV count,182
EXIT:
    CLI
    POP DX
    POP CX
    POP AX
    POP DS
    IRET
ring ENDP
CODES ENDS
END START