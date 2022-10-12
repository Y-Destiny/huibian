;输入小写，输出对应大写
DATA SEGMENT 
    STR1 BYTE 'please input small letter: $'
    STR2 BYTE 'this is not small letter,please reload: $'
    STR3 BYTE 'the capital is: $'
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
;输入小写字母
START: MOV AX,DATA
       MOV DS,AX

       MOV DX,OFFSET STR1
       MOV AH,09H
       INT 21H

NEXT:  MOV AH,01H
       INT 21H
       MOV CL,AL

       CALL CRLF
       ;判断是否是小写字母，不是则提示再次输入
       CMP CL,61H
       JL  THEN
       CMP CL,7AH
       JG  THEN

       MOV DX,OFFSET STR3
       MOV AH,09H
       INT 21H
       SUB CL,20H;小写字母ascll码减20h得到大写字母
       MOV DL,CL
       MOV AH,02H
       INT 21H
       CALL CRLF
       JMP START

THEN:  MOV DX,OFFSET STR2
       MOV AH,09H
       INT 21H
       JMP NEXT

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

CODE ENDS
     END START