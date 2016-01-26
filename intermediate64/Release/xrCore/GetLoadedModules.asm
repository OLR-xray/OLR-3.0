; Listing generated by Microsoft (R) Optimizing Compiler Version 16.00.40219.01 

include listing.inc

INCLUDELIB OLDNAMES

PUBLIC	??_C@_0BG@NMFPCNDP@GetVersionEx?5failed?$CB?6?$AA@ ; `string'
EXTRN	__imp_GetVersionExA:PROC
EXTRN	__imp_SetLastErrorEx:PROC
;	COMDAT ??_C@_0BG@NMFPCNDP@GetVersionEx?5failed?$CB?6?$AA@
CONST	SEGMENT
??_C@_0BG@NMFPCNDP@GetVersionEx?5failed?$CB?6?$AA@ DB 'GetVersionEx faile'
	DB	'd!', 0aH, 00H				; `string'
PI_MUL_2 DD	040c90fdbr			; 6.28319
PUBLIC	GetLoadedModules
pdata	SEGMENT
$pdata$GetLoadedModules DD imagerel $LN11
	DD	imagerel $LN11+201
	DD	imagerel $unwind$GetLoadedModules
pdata	ENDS
xdata	SEGMENT
$unwind$GetLoadedModules DD 091701H
	DD	01c6417H
	DD	01b5417H
	DD	01a3417H
	DD	0180117H
	DD	07010H
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp
xdata	ENDS
_TEXT	SEGMENT
stOSVI$ = 32
dwPID$ = 208
uiCount$ = 216
paModArray$ = 224
pdwRealCount$ = 232
GetLoadedModules PROC

; 17   : {

$LN11:
	mov	QWORD PTR [rsp+8], rbx
	mov	QWORD PTR [rsp+16], rbp
	mov	QWORD PTR [rsp+24], rsi
	push	rdi
	sub	rsp, 192				; 000000c0H
	mov	rsi, r9
	mov	rdi, r8
	mov	ebx, edx
	mov	ebp, ecx

; 18   :     // Do the debug checking.
; 19   :     ASSERT ( NULL != pdwRealCount ) ;
; 20   :     ASSERT ( FALSE == IsBadWritePtr ( pdwRealCount , sizeof ( UINT ) ));
; 21   : #ifdef _DEBUG
; 22   :     if ( 0 != uiCount )
; 23   :     {
; 24   :         ASSERT ( NULL != paModArray ) ;
; 25   :         ASSERT ( FALSE == IsBadWritePtr ( paModArray                   ,
; 26   :                                           uiCount *
; 27   :                                                 sizeof ( HMODULE )   ));
; 28   :     }
; 29   : #endif
; 30   : 
; 31   :     // Do the parameter checking for real.  Note that I only check the
; 32   :     // memory in paModArray if uiCount is > 0.  The user can pass zero
; 33   :     // in uiCount if they are just interested in the total to be
; 34   :     // returned so they could dynamically allocate a buffer.
; 35   :     if ( ( TRUE == IsBadWritePtr ( pdwRealCount , sizeof(UINT) ) )    ||
; 36   :          ( ( uiCount > 0 ) &&
; 37   :            ( TRUE == IsBadWritePtr ( paModArray ,
; 38   :                                      uiCount * sizeof(HMODULE) ) ) )   )

	test	edx, edx
	je	SHORT $LN5@GetLoadedM
	mov	edx, ebx
	mov	rcx, r8
	shl	rdx, 3
	call	QWORD PTR __imp_IsBadWritePtr
	cmp	eax, 1
	jne	SHORT $LN5@GetLoadedM

; 39   :     {
; 40   :         SetLastErrorEx ( ERROR_INVALID_PARAMETER , SLE_ERROR ) ;

	lea	ecx, QWORD PTR [rax+86]
	mov	edx, eax
	call	QWORD PTR __imp_SetLastErrorEx

; 41   :         return ( FALSE ) ;

	xor	eax, eax
	jmp	SHORT $LN9@GetLoadedM
$LN5@GetLoadedM:

; 42   :     }
; 43   : 
; 44   :     // Figure out which OS we are on.
; 45   :     OSVERSIONINFO stOSVI ;
; 46   : 
; 47   :     FillMemory ( &stOSVI ,sizeof ( OSVERSIONINFO ), NULL  ) ;

	lea	rcx, QWORD PTR stOSVI$[rsp]
	xor	edx, edx
	mov	r8d, 148				; 00000094H
	call	QWORD PTR ?Memory@@3VxrMemory@@A+16

; 48   :     stOSVI.dwOSVersionInfoSize = sizeof ( OSVERSIONINFO ) ;
; 49   : 
; 50   :     BOOL bRet = GetVersionEx ( &stOSVI ) ;

	lea	rcx, QWORD PTR stOSVI$[rsp]
	mov	DWORD PTR stOSVI$[rsp], 148		; 00000094H
	call	QWORD PTR __imp_GetVersionExA

; 51   :     ASSERT ( TRUE == bRet ) ;
; 52   :     if ( FALSE == bRet )

	test	eax, eax
	jne	SHORT $LN3@GetLoadedM

; 53   :     {
; 54   :         TRACE0 ( "GetVersionEx failed!\n" ) ;

	lea	rcx, OFFSET FLAT:??_C@_0BG@NMFPCNDP@GetVersionEx?5failed?$CB?6?$AA@
	call	?Log@@YAXPEBD@Z				; Log

; 55   :         return ( FALSE ) ;

	xor	eax, eax
	jmp	SHORT $LN9@GetLoadedM
$LN3@GetLoadedM:

; 56   :     }
; 57   : 
; 58   :     // Check the version and call the appropriate thing.
; 59   :     if ( ( VER_PLATFORM_WIN32_NT == stOSVI.dwPlatformId ) &&
; 60   :          ( 4 == stOSVI.dwMajorVersion                   )    )

	cmp	DWORD PTR stOSVI$[rsp+16], 2
	jne	SHORT $LN2@GetLoadedM
	cmp	DWORD PTR stOSVI$[rsp+4], 4
	jne	SHORT $LN2@GetLoadedM

; 61   :     {
; 62   :         // This is NT 4 so call its specific version in PSAPI.DLL
; 63   :         return ( NT4GetLoadedModules ( dwPID        ,
; 64   :                                        uiCount      ,
; 65   :                                        paModArray   ,
; 66   :                                        pdwRealCount  ) );

	mov	r9, rsi
	mov	r8, rdi
	mov	edx, ebx
	mov	ecx, ebp
	call	?NT4GetLoadedModules@@YAHKIPEAPEAUHINSTANCE__@@PEAK@Z ; NT4GetLoadedModules
	jmp	SHORT $LN9@GetLoadedM
$LN2@GetLoadedM:

; 67   :     }
; 68   :     else
; 69   :     {
; 70   :         // Win9x and Win2K go through tool help.
; 71   :         return ( TLHELPGetLoadedModules ( dwPID         ,
; 72   :                                           uiCount       ,
; 73   :                                           paModArray    ,
; 74   :                                           pdwRealCount   ) ) ;

	mov	r9, rsi
	mov	r8, rdi
	mov	edx, ebx
	mov	ecx, ebp
	call	?TLHELPGetLoadedModules@@YAHKIPEAPEAUHINSTANCE__@@PEAK@Z ; TLHELPGetLoadedModules
$LN9@GetLoadedM:

; 75   :     }
; 76   : }

	lea	r11, QWORD PTR [rsp+192]
	mov	rbx, QWORD PTR [r11+16]
	mov	rbp, QWORD PTR [r11+24]
	mov	rsi, QWORD PTR [r11+32]
	mov	rsp, r11
	pop	rdi
	ret	0
GetLoadedModules ENDP
END