; Listing generated by Microsoft (R) Optimizing Compiler Version 16.00.40219.01 

include listing.inc

INCLUDELIB OLDNAMES

PUBLIC	?xrMemFill_x86@@YAXPEAXHI@Z			; xrMemFill_x86
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory_pso_fill.cpp
_TEXT	SEGMENT
dest$ = 8
value$ = 16
count$ = 24
?xrMemFill_x86@@YAXPEAXHI@Z PROC			; xrMemFill_x86

; 6    : 	memset	(dest,int(value),count);

	mov	r8d, r8d

; 7    : }

	jmp	memset
?xrMemFill_x86@@YAXPEAXHI@Z ENDP			; xrMemFill_x86
END