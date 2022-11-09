.global binary_search
binary_search:
	MOV R3,#0
	SUB R4,R2,#1
	MOV R5,R4,LSR #1
	MOV R6,#-1
	MOV R7,#1
loop:	CMP R6,#-1
	BNE return

	CMP R3,R4
	BGT return

	LDR R8,[R0,R5,LSL #2]
	CMP R8,R1
	BNE if3
	MOV R6,R5
	B end

if3:	CMP R8,R1
	BLT else
	SUB R4,R5,#1
	B end
	
else:	ADD R3,R5,#1	

end:	MVN R11,R7
	ADD R11,R11,#1
	MOV R8,R11
	SUB R9,R4,R3
	MOV R10,R9,LSR #1
	ADD R5,R3,R10
	ADD R7,R7,#1
	B loop
return:	MOV R0,R6
	MOV PC,LR
