DATA SEGMENT
    
DATA ENDS

STACKS SEGMENT
    
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATA, SS:STACKS
START:
    MOV AX, DATA
    MOV DS, AX
    CALL sound
    MOV AH, 4CH
    INT 21H

;description
sound PROC
    PUSH ax
    push DX
    mov dx,CX
    in al, 61H
    and al, 11111100B
trig:
    xor al,2
    out 61h, al
    mov cx,Bx
delay:
    loop delay
    dec dx
    jne trig
    pop dx
    pop ax
sound ENDP
CODES ENDS
END START