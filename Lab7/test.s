MOV R0,#5
MOV R1,#2
ADD R2,R1,R0,LSL#1
MOV R3,data

STR R2,[R3,#0]
LDR R4,[R3,#4]






data:
	.word 0x0
	.word 0x5
	.word 0x0

