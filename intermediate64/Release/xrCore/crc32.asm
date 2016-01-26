; Listing generated by Microsoft (R) Optimizing Compiler Version 18.00.40629.0 

include listing.inc

INCLUDELIB OLDNAMES

crc32_ready DD	01H DUP (?)
_BSS	ENDS
PUBLIC	?crc32_init@@YAXXZ				; crc32_init
PUBLIC	?Reflect@@YAIID@Z				; Reflect
PUBLIC	?crc32@@YAIPEBXI@Z				; crc32
	ALIGN	4

crc32_table DD	0100H DUP (?)
_BSS	ENDS
pdata	SEGMENT
$pdata$?crc32_init@@YAXXZ DD imagerel $LN64
	DD	imagerel $LN64+373
	DD	imagerel $unwind$?crc32_init@@YAXXZ
$pdata$?crc32@@YAIPEBXI@Z DD imagerel $LN12
	DD	imagerel $LN12+105
	DD	imagerel $unwind$?crc32@@YAIPEBXI@Z
xdata	SEGMENT
$unwind$?crc32_init@@YAXXZ DD 020501H
	DD	013405H
$unwind$?crc32@@YAIPEBXI@Z DD 040a01H
	DD	06340aH
	DD	07006320aH
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\crc32.cpp
_TEXT	SEGMENT
P$ = 48
len$ = 56
?crc32@@YAIPEBXI@Z PROC					; crc32

; 43   : {

$LN12:
	mov	QWORD PTR [rsp+8], rbx
	push	rdi
	sub	rsp, 32					; 00000020H

; 44   : 	if (!crc32_ready)	

	cmp	DWORD PTR crc32_ready, 0
	mov	ebx, edx
	mov	rdi, rcx
	jne	SHORT $LN3@crc32

; 45   : 	{
; 46   : 		crc32_init	();

	call	?crc32_init@@YAXXZ			; crc32_init

; 47   : 		crc32_ready	= TRUE;

	mov	DWORD PTR crc32_ready, 1
$LN3@crc32:

; 48   : 	}
; 49   : 
; 50   : 	// Pass a text string to this function and it will return the CRC. 
; 51   : 
; 52   : 	// Once the lookup table has been filled in by the two functions above, 
; 53   : 	// this function creates all CRCs using only the lookup table. 
; 54   : 
; 55   : 	// Be sure to use unsigned variables, 
; 56   : 	// because negative values introduce high bits 
; 57   : 	// where zero bits are required. 
; 58   : 
; 59   : 	// Start out with all bits set high. 
; 60   : 	u32		ulCRC		= 0xffffffff; 

	or	eax, -1					; ffffffffH

; 61   : 	u8*		buffer		= (u8*)P;
; 62   : 
; 63   : 	// Perform the algorithm on each character 
; 64   : 	// in the string, using the lookup table values. 
; 65   : 	while(len--) 

	test	ebx, ebx
	je	SHORT $LN7@crc32
	lea	r8, OFFSET FLAT:crc32_table
	npad	11
$LL2@crc32:

; 66   : 		ulCRC = (ulCRC >> 8) ^ crc32_table[(ulCRC & 0xFF) ^ *buffer++]; 

	movzx	ecx, BYTE PTR [rdi]
	movzx	edx, al
	lea	rdi, QWORD PTR [rdi+1]
	xor	rdx, rcx
	mov	ecx, eax
	mov	eax, DWORD PTR [r8+rdx*4]
	shr	ecx, 8
	xor	eax, ecx
	dec	ebx
	jne	SHORT $LL2@crc32
$LN7@crc32:

; 67   : 
; 68   : 	// Exclusive OR the result with the beginning value. 
; 69   : 	return ulCRC ^ 0xffffffff; 

	not	eax

; 70   : } 

	mov	rbx, QWORD PTR [rsp+48]
	add	rsp, 32					; 00000020H
	pop	rdi
	ret	0
?crc32@@YAIPEBXI@Z ENDP					; crc32
_TEXT	ENDS
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\crc32.cpp
;	COMDAT ?Reflect@@YAIID@Z
_TEXT	SEGMENT
ref$ = 8
ch$ = 16
?Reflect@@YAIID@Z PROC					; Reflect, COMDAT

; 8    : {

	mov	r8d, ecx

; 9    : 	// Used only by Init_CRC32_Table(). 
; 10   : 
; 11   : 	u32 value(0); 
; 12   : 
; 13   : 	// Swap bit 0 for bit 7 
; 14   : 	// bit 1 for bit 6, etc. 
; 15   : 	for(int i = 1; i < (ch + 1); i++) 

	movsx	ecx, dl
	xor	r9d, r9d
	lea	eax, DWORD PTR [rcx+1]
	cmp	eax, 1
	jle	SHORT $LN11@Reflect

; 18   : 			value |= 1 << (ch - i); 

	dec	ecx
	lea	r10d, DWORD PTR [rax-1]
$LL4@Reflect:

; 16   : 	{ 
; 17   : 		if(ref & 1) 

	test	r8b, 1
	je	SHORT $LN1@Reflect

; 18   : 			value |= 1 << (ch - i); 

	mov	edx, 1
	shl	edx, cl
	or	r9d, edx
$LN1@Reflect:

; 19   : 		ref >>= 1; 

	shr	r8d, 1
	dec	ecx
	dec	r10
	jne	SHORT $LL4@Reflect
$LN11@Reflect:

; 20   : 	} 
; 21   : 	return value; 

	mov	eax, r9d

; 22   : } 

	ret	0
?Reflect@@YAIID@Z ENDP					; Reflect
_TEXT	ENDS
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\crc32.cpp
_TEXT	SEGMENT
?crc32_init@@YAXXZ PROC					; crc32_init

; 25   : {

$LN64:
	mov	QWORD PTR [rsp+8], rbx

; 26   : 	// Call this function only once to initialize the CRC table. 
; 27   : 
; 28   : 	// This is the official polynomial used by CRC-32 
; 29   : 	// in PKZip, WinZip and Ethernet. 
; 30   : 	u32 ulPolynomial = 0x04c11db7; 
; 31   : 
; 32   : 	// 256 values representing ASCII character codes. 
; 33   : 	for(int i = 0; i <= 0xFF; i++) 

	xor	r10d, r10d
	lea	r11, OFFSET FLAT:crc32_table
	mov	ebx, 128				; 00000080H
	npad	12
$LL6@crc32_init:

; 12   : 
; 13   : 	// Swap bit 0 for bit 7 
; 14   : 	// bit 1 for bit 6, etc. 
; 15   : 	for(int i = 1; i < (ch + 1); i++) 
; 16   : 	{ 
; 17   : 		if(ref & 1) 

	test	r10b, 1
	mov	edx, 0

; 19   : 		ref >>= 1; 

	mov	eax, r10d
	cmovne	edx, ebx
	shr	eax, 1
	test	al, 1
	je	SHORT $LN37@crc32_init

; 18   : 			value |= 1 << (ch - i); 

	or	edx, 64					; 00000040H
$LN37@crc32_init:

; 19   : 		ref >>= 1; 

	shr	eax, 1
	test	al, 1
	je	SHORT $LN39@crc32_init

; 18   : 			value |= 1 << (ch - i); 

	or	edx, 32					; 00000020H
$LN39@crc32_init:

; 19   : 		ref >>= 1; 

	shr	eax, 1
	test	al, 1
	je	SHORT $LN41@crc32_init

; 18   : 			value |= 1 << (ch - i); 

	or	edx, 16
$LN41@crc32_init:

; 19   : 		ref >>= 1; 

	shr	eax, 1
	test	al, 1
	je	SHORT $LN43@crc32_init

; 18   : 			value |= 1 << (ch - i); 

	or	edx, 8
$LN43@crc32_init:

; 19   : 		ref >>= 1; 

	shr	eax, 1
	test	al, 1
	je	SHORT $LN45@crc32_init

; 18   : 			value |= 1 << (ch - i); 

	or	edx, 4
$LN45@crc32_init:

; 19   : 		ref >>= 1; 

	shr	eax, 1
	test	al, 1
	je	SHORT $LN47@crc32_init

; 18   : 			value |= 1 << (ch - i); 

	or	edx, 2
$LN47@crc32_init:

; 12   : 
; 13   : 	// Swap bit 0 for bit 7 
; 14   : 	// bit 1 for bit 6, etc. 
; 15   : 	for(int i = 1; i < (ch + 1); i++) 
; 16   : 	{ 
; 17   : 		if(ref & 1) 

	test	al, 2
	je	SHORT $LN49@crc32_init

; 18   : 			value |= 1 << (ch - i); 

	or	edx, 1
$LN49@crc32_init:

; 34   : 	{ 
; 35   : 		crc32_table[i]=Reflect(i, 8) << 24; 

	shl	edx, 24

; 36   : 		for (int j = 0; j < 8; j++) 
; 37   : 			crc32_table[i] = (crc32_table[i] << 1) ^ (crc32_table[i] & (1 << 31) ? ulPolynomial : 0); 

	mov	eax, edx
	and	eax, -2147483648			; 80000000H
	neg	eax
	lea	eax, DWORD PTR [rdx+rdx]
	sbb	ecx, ecx
	and	ecx, 79764919				; 04c11db7H
	xor	ecx, eax
	mov	eax, ecx
	and	eax, -2147483648			; 80000000H
	neg	eax
	lea	eax, DWORD PTR [rcx+rcx]
	sbb	edx, edx
	and	edx, 79764919				; 04c11db7H
	xor	edx, eax
	mov	eax, edx
	and	eax, -2147483648			; 80000000H
	neg	eax
	lea	eax, DWORD PTR [rdx+rdx]
	sbb	ecx, ecx
	and	ecx, 79764919				; 04c11db7H
	xor	ecx, eax
	mov	eax, ecx
	and	eax, -2147483648			; 80000000H
	neg	eax
	lea	eax, DWORD PTR [rcx+rcx]
	sbb	edx, edx
	and	edx, 79764919				; 04c11db7H
	xor	edx, eax
	mov	eax, edx
	and	eax, -2147483648			; 80000000H
	neg	eax
	lea	eax, DWORD PTR [rdx+rdx]
	sbb	ecx, ecx
	and	ecx, 79764919				; 04c11db7H
	xor	ecx, eax
	mov	eax, ecx
	and	eax, -2147483648			; 80000000H
	neg	eax
	lea	eax, DWORD PTR [rcx+rcx]
	sbb	edx, edx
	and	edx, 79764919				; 04c11db7H
	xor	edx, eax
	mov	eax, edx
	and	eax, -2147483648			; 80000000H
	neg	eax
	lea	eax, DWORD PTR [rdx+rdx]
	sbb	ecx, ecx
	and	ecx, 79764919				; 04c11db7H
	xor	ecx, eax
	mov	eax, ecx
	and	eax, -2147483648			; 80000000H
	neg	eax
	sbb	eax, eax
	add	ecx, ecx
	and	eax, 79764919				; 04c11db7H
	xor	eax, ecx

; 11   : 	u32 value(0); 

	xor	r9d, r9d

; 34   : 	{ 
; 35   : 		crc32_table[i]=Reflect(i, 8) << 24; 

	lea	r8d, QWORD PTR [r9+30]
	mov	DWORD PTR [r11], eax
$LL18@crc32_init:

; 12   : 
; 13   : 	// Swap bit 0 for bit 7 
; 14   : 	// bit 1 for bit 6, etc. 
; 15   : 	for(int i = 1; i < (ch + 1); i++) 
; 16   : 	{ 
; 17   : 		if(ref & 1) 

	test	al, 1
	je	SHORT $LN15@crc32_init

; 18   : 			value |= 1 << (ch - i); 

	lea	ecx, DWORD PTR [r8+1]
	mov	edx, 1
	shl	edx, cl
	or	r9d, edx
$LN15@crc32_init:

; 19   : 		ref >>= 1; 

	shr	eax, 1
	test	al, 1
	je	SHORT $LN60@crc32_init

; 18   : 			value |= 1 << (ch - i); 

	mov	ecx, r8d
	mov	edx, 1
	shl	edx, cl
	or	r9d, edx
$LN60@crc32_init:

; 19   : 		ref >>= 1; 

	sub	r8d, 2
	shr	eax, 1
	cmp	r8d, -2
	jg	SHORT $LL18@crc32_init

; 38   : 		crc32_table[i] = Reflect(crc32_table[i], 32); 

	inc	r10d
	mov	DWORD PTR [r11], r9d
	add	r11, 4
	cmp	r10d, 255				; 000000ffH
	jle	$LL6@crc32_init

; 39   : 	} 
; 40   : } 

	mov	rbx, QWORD PTR [rsp+8]
	ret	0
?crc32_init@@YAXXZ ENDP					; crc32_init
_TEXT	ENDS
END
