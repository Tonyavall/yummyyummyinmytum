; general comments
	; For the expression 2(-a + b - 1) + c
	; Since a is a negative number, and the expression not including c could be negative, the program must include signed integers.
	; -expression not including c could be negative, i.e- 2(-999 + 000 - 1) = -2000
	; Thus, with signed integers the lowest possible size between BYTE/WORD/DWORD we could use is WORD, which has the range of -32768d-32767d.
	; This is true by first looking at the max value of lastFour, below, which is 9999 and too large to fit into a BYTE size range of -128d-127d.
	; This is also true for the min value of lastFour listed below.
	; We should also take in consideration the resulting expressions value.
	; When we plug in the max value for firstThree and lastFour, and the min value for areaCode to get the max value of the expression we get
	; 2(-200 + 999 - 1) + 9999 = 11595, which is in range of size WORD for signed integers.
	; The same can be said about the lowest possible value from the expression.
	; 2(-999 + 000 - 1) + 0000 = -2000, which is in range of size WORD for signed integers.
	; Because of the reasons stated above, the smallest register size and data size possible would be a WORD size.

; preprocessor directives
.586
.MODEL FLAT

; external files to link with

; stack configuration
.STACK 4096

; named memory allocation and initialization
.DATA
; Area code (NPA) has range 200 to 999 for U.S.
areaCode	WORD	912
; Assumption: First three digits (NXX) of phone number has range 000 to 999. 
firstThree	WORD	202
; Assumption: Last four digits of phone number has range 0000 to 9999.
lastFour	WORD	9922

; names of procedures defined in other *.asm files in the project

; procedure code
.CODE
main	PROC
; Register dictionary for this procedure.
	; Again, instructions are done as signed integers.
	; For the expression 2(-a + b - 1) + c.
	; Before calculations
		; AX holds the value of a, the area code of a phone number.
		; BX holds the value of b, the first three digits of a phone number.
		; CX holds the value of c, the last four digits of a phone number.
	; After calculations
		; AX holds the resulting value of calculations.

	mov AX, areaCode ; copy WORD size areaCode value in memory to AX register.
	; This two operand instruction copies the right operand data into the left operand.
	; The signed WORD integer (912d) in memory is copied to WORD size AX register.

	mov BX, firstThree ; copy WORD size firstThree value in memory to BX register.
	; This two operand instruction copies the right operand data into the left operand.
	; The signed WORD integer (202d) in memory is copied to WORD size BX register.

	mov CX, lastFour ; copy WORD size lastFour value in memory to CX register.
	; This two operand instruction copies the right operand data into the left operand.
	; The signed WORD integer (9922d) in memory is copied to WORD size CX register.	

	neg AX ; convert the value in AX register to a negative.
	; The value in AX register changes from 912d to -912d or from 0390h to FC70h.

	add AX, BX ; add AX register value to BX register value and store the resulting sum value in AX register.
	; This two operand instruction adds the right operand to the left operand. The left operand is replaced by the sum.
	; -912d + 202d = -710d, which is a value AX register can hold

	dec AX ; Subtract 1d from AX register value.
	; This one operand instruction decreases the operand value by 1.
	; -710d - 1d = -711d, which is a value AX register can hold

	add AX, AX ; Since we're multiplying by 2, we simply add the value to itself
	; This two operand instruction copies the right operand data into the left operand.
	; -711d + -711d = -1422d, which is a value AX register can hold

	add AX, CX ; Add AX register value with CX register value and store the resulting value in AX register.
	; This two operand instruction adds the right operand to the left operand. The left operand is replaced by the sum.
	; -1422d + 9922d = 8500d, which is a value AX register can hold

	mov EAX, 0
	ret
main	ENDP

END