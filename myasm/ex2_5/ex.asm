;编写一个程序,要求比较数组ARRAY中的三个16位补码，并根据比较结果在终端上显示如下信息：
;1）	如果三个数都不相等，显示0；
;2）	如果三个输油两个相等，显示1；
;3）	如果三个数都相当，显示2。

DATA SEGMENT
      ;ARRAY DW -1,2,3;
      ARRAY DW -1,-1,-1;
      ;ARRAY DW -1,-2,-1;
      STR BYTE 'the answer is : $'
DATA ENDS

STACKS SEGMENT
      
STACKS ENDS

CODES SEGMENT
      ASSUME CS:CODES, DS:DATA, SS:STACKS
START:
      MOV AX, DATA
      MOV DS, AX
      LEA SI, ARRAY
      MOV AX, [SI]
      ADD SI, 02H
      MOV BX, [SI]
      ADD SI, 02H
      MOV CX, [SI]
      
      MOV DX,OFFSET STR
      MOV AH,09H
      INT 21H


      CMP AX, BX
      JZ  L0
      JNZ L1
L0:   CMP BX, CX
      JZ  R0
      JNZ R1
L1:   CMP AX,CX
      JZ  R1
      JNZ L2
L2:   CMP BX,CX
      JZ  R1
      JNZ R3



R0:   MOV DL, 32H
      MOV AH,02H
      INT 21H
      JMP EXIT
R1:   MOV DL, 31H
      MOV AH,02H
      INT 21H
      JMP EXIT
R3:   MOV DL, 30H
      MOV AH,02H
      INT 21H
      JMP EXIT
EXIT: MOV AH, 4CH
      INT 21H
CODES ENDS
END START