; Listing generated by Microsoft (R) Optimizing Compiler Version 16.00.40219.01 

include listing.inc

INCLUDELIB OLDNAMES

PUBLIC	?IsDegenerate@IndexedTriangle@Meshmerizer@@QEBA_NXZ ; Meshmerizer::IndexedTriangle::IsDegenerate
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcdb\opc_triangle.cpp
_TEXT	SEGMENT
this$ = 8
?IsDegenerate@IndexedTriangle@Meshmerizer@@QEBA_NXZ PROC ; Meshmerizer::IndexedTriangle::IsDegenerate

; 36   : 	if(mVRef[0]==mVRef[1])	return true;

	mov	edx, DWORD PTR [rcx]
	mov	r8d, DWORD PTR [rcx+4]
	cmp	edx, r8d
	jne	SHORT $LN3@IsDegenera
$LN6@IsDegenera:
	mov	al, 1

; 39   : 	return false;
; 40   : }

	ret	0
$LN3@IsDegenera:

; 37   : 	if(mVRef[1]==mVRef[2])	return true;

	mov	eax, DWORD PTR [rcx+8]
	cmp	r8d, eax
	je	SHORT $LN6@IsDegenera

; 38   : 	if(mVRef[2]==mVRef[0])	return true;

	cmp	eax, edx
	sete	al

; 39   : 	return false;
; 40   : }

	ret	0
?IsDegenerate@IndexedTriangle@Meshmerizer@@QEBA_NXZ ENDP ; Meshmerizer::IndexedTriangle::IsDegenerate
END