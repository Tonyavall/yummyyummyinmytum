; general comments

; preprocessor directives
.586
.MODEL FLAT

; external files to link with

; stack configuration
.STACK 4096

; named memory allocation and initialization
.DATA
theAnswer	DWORD	0ABCDABCDh

; names of procedures defined in other *.asm files in the project

; procedure code
.CODE
main	PROC

	mov EAX, 23902 
	add EAX, -32
	mov theAnswer, EAX

	mov EAX, 0
	ret
main	ENDP

END