; Listing generated by Microsoft (R) Optimizing Compiler Version 18.00.40629.0 

include listing.inc

INCLUDELIB OLDNAMES

PUBLIC	??_C@_0CO@NOFKPEC@Win95GetModuleBaseName?5Invalid?5s@ ; `string'
EXTRN	__imp_SymLoadModule64:PROC
EXTRN	__imp_SymInitialize:PROC
EXTRN	__imp_SetLastError:PROC
EXTRN	__imp_IsBadWritePtr:PROC
EXTRN	__imp_SymCleanup:PROC
EXTRN	__imp_lstrcpynA:PROC
EXTRN	__imp_lstrlenA:PROC
;	COMDAT ??_C@_0CO@NOFKPEC@Win95GetModuleBaseName?5Invalid?5s@
CONST	SEGMENT
??_C@_0CO@NOFKPEC@Win95GetModuleBaseName?5Invalid?5s@ DB 'Win95GetModuleB'
	DB	'aseName Invalid string buffer', 0aH, 00H	; `string'
PI_MUL_2 DD	040c90fdbr			; 6.28319
PUBLIC	BSUSymInitialize
PUBLIC	BSUGetModuleBaseName
	ALIGN	4

_Tuple_alloc DB	01H DUP (?)
	ALIGN	4

ignore	DB	01H DUP (?)
	ALIGN	4

allocator_arg DB 01H DUP (?)
	ALIGN	4

piecewise_construct DB 01H DUP (?)
_BSS	ENDS
pdata	SEGMENT
$pdata$BSUSymInitialize DD imagerel $LN307
	DD	imagerel $LN307+346
	DD	imagerel $unwind$BSUSymInitialize
$pdata$0$BSUSymInitialize DD imagerel $LN307+346
	DD	imagerel $LN307+545
	DD	imagerel $chain$0$BSUSymInitialize
$pdata$1$BSUSymInitialize DD imagerel $LN307+545
	DD	imagerel $LN307+569
	DD	imagerel $chain$1$BSUSymInitialize
$pdata$2$BSUSymInitialize DD imagerel $LN307+569
	DD	imagerel $LN307+597
	DD	imagerel $chain$2$BSUSymInitialize
$pdata$3$BSUSymInitialize DD imagerel $LN307+597
	DD	imagerel $LN307+686
	DD	imagerel $chain$3$BSUSymInitialize
$pdata$?Win95GetModuleBaseName@@YAKPEAXPEAUHINSTANCE__@@PEADK@Z DD imagerel ?Win95GetModuleBaseName@@YAKPEAXPEAUHINSTANCE__@@PEADK@Z
	DD	imagerel ?Win95GetModuleBaseName@@YAKPEAXPEAUHINSTANCE__@@PEADK@Z+236
	DD	imagerel $unwind$?Win95GetModuleBaseName@@YAKPEAXPEAUHINSTANCE__@@PEADK@Z
$pdata$BSUGetModuleBaseName DD imagerel $LN8
	DD	imagerel $LN8+124
	DD	imagerel $unwind$BSUGetModuleBaseName
xdata	SEGMENT
$unwind$BSUSymInitialize DD 091d01H
	DD	046641dH
	DD	045341dH
	DD	040011dH
	DD	0700ce00eH
	DD	0500bH
$chain$0$BSUSymInitialize DD 020821H
	DD	044f408H
	DD	imagerel $LN307
	DD	imagerel $LN307+346
	DD	imagerel $unwind$BSUSymInitialize
$chain$1$BSUSymInitialize DD 021H
	DD	imagerel $LN307
	DD	imagerel $LN307+346
	DD	imagerel $unwind$BSUSymInitialize
$chain$2$BSUSymInitialize DD 020021H
	DD	044f400H
	DD	imagerel $LN307
	DD	imagerel $LN307+346
	DD	imagerel $unwind$BSUSymInitialize
$chain$3$BSUSymInitialize DD 021H
	DD	imagerel $LN307
	DD	imagerel $LN307+346
	DD	imagerel $unwind$BSUSymInitialize
$unwind$?Win95GetModuleBaseName@@YAKPEAXPEAUHINSTANCE__@@PEADK@Z DD 071201H
	DD	0296412H
	DD	0283412H
	DD	0260112H
	DD	0700bH
$unwind$BSUGetModuleBaseName DD 081401H
	DD	086414H
	DD	075414H
	DD	063414H
	DD	070103214H
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\nt4processinfo.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
_TEXT	SEGMENT
hProcess$ = 48
hModule$ = 56
lpBaseName$ = 64
nSize$ = 72
BSUGetModuleBaseName PROC

; 24   : {

$LN8:
	mov	QWORD PTR [rsp+8], rbx
	mov	QWORD PTR [rsp+16], rbp
	mov	QWORD PTR [rsp+24], rsi
	push	rdi
	sub	rsp, 32					; 00000020H
	mov	ebx, r9d
	mov	rdi, r8
	mov	rsi, rdx
	mov	rbp, rcx

; 25   :     if ( TRUE == IsNT ( ) )

	call	IsNT
	cmp	eax, 1
	jne	SHORT $LN1@BSUGetModu
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\nt4processinfo.cpp

; 214  :     if ( FALSE == InitPSAPI ( ) )

	call	?InitPSAPI@@YAHXZ			; InitPSAPI
	test	eax, eax
	jne	SHORT $LN4@BSUGetModu

; 215  :     {
; 216  :         ASSERT ( !"InitiPSAPI failed!" ) ;
; 217  :         SetLastErrorEx ( ERROR_DLL_INIT_FAILED , SLE_ERROR ) ;

	lea	edx, QWORD PTR [rax+1]
	mov	ecx, 1114				; 0000045aH
	call	QWORD PTR __imp_SetLastErrorEx

; 218  :         return ( FALSE ) ;

	xor	eax, eax
	jmp	SHORT $LN2@BSUGetModu
$LN4@BSUGetModu:

; 219  :     }
; 220  :     return ( g_pGetModuleBaseName ( hProcess    ,
; 221  :                                     hModule     ,
; 222  :                                     lpBaseName  ,
; 223  :                                     nSize        ) ) ;

	mov	r9d, ebx
	mov	r8, rdi
	mov	rdx, rsi
	mov	rcx, rbp
	call	QWORD PTR g_pGetModuleBaseName
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 32   :                                        nSize         ) ) ;

	jmp	SHORT $LN2@BSUGetModu
$LN1@BSUGetModu:

; 33   :     }
; 34   :     return ( Win95GetModuleBaseName ( hProcess     ,
; 35   :                                       hModule      ,
; 36   :                                       lpBaseName   ,
; 37   :                                       nSize         ) ) ;

	mov	r9d, ebx
	mov	r8, rdi
	mov	rdx, rsi
	call	?Win95GetModuleBaseName@@YAKPEAXPEAUHINSTANCE__@@PEADK@Z ; Win95GetModuleBaseName
$LN2@BSUGetModu:

; 38   : 
; 39   : }

	mov	rbx, QWORD PTR [rsp+48]
	mov	rbp, QWORD PTR [rsp+56]
	mov	rsi, QWORD PTR [rsp+64]
	add	rsp, 32					; 00000020H
	pop	rdi
	ret	0
BSUGetModuleBaseName ENDP
_TEXT	ENDS
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\program files (x86)\microsoft visual studio 12.0\vc\include\string.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
_TEXT	SEGMENT
szBuff$ = 32
__formal$dead$ = 320
hModule$ = 328
lpBaseName$ = 336
nSize$ = 344
?Win95GetModuleBaseName@@YAKPEAXPEAUHINSTANCE__@@PEADK@Z PROC ; Win95GetModuleBaseName

; 46   : {

	mov	QWORD PTR [rsp+8], rbx
	mov	QWORD PTR [rsp+16], rsi
	push	rdi
	sub	rsp, 304				; 00000130H
	mov	rdi, rdx

; 47   :     ASSERT ( FALSE == IsBadWritePtr ( lpBaseName , nSize ) ) ;
; 48   :     if ( TRUE == IsBadWritePtr ( lpBaseName , nSize ) )

	mov	rcx, r8
	mov	edx, r9d
	mov	ebx, r9d
	mov	rsi, r8
	call	QWORD PTR __imp_IsBadWritePtr
	cmp	eax, 1
	jne	SHORT $LN4@Win95GetMo

; 49   :     {
; 50   :         TRACE0 ( "Win95GetModuleBaseName Invalid string buffer\n" ) ;

	lea	rcx, OFFSET FLAT:??_C@_0CO@NOFKPEC@Win95GetModuleBaseName?5Invalid?5s@
	call	?Log@@YAXPEBD@Z				; Log

; 51   :         SetLastError ( ERROR_INVALID_PARAMETER ) ;

	mov	ecx, 87					; 00000057H
	call	QWORD PTR __imp_SetLastError
$LN268@Win95GetMo:

; 52   :         return ( 0 ) ;

	xor	eax, eax
	jmp	$LN5@Win95GetMo
$LN4@Win95GetMo:

; 53   :     }
; 54   : 
; 55   :     // This could blow the stack...
; 56   :     char szBuff[ MAX_PATH + 1 ] ;
; 57   :     DWORD dwRet = GetModuleFileName ( hModule , szBuff , MAX_PATH ) ;

	lea	rdx, QWORD PTR szBuff$[rsp]
	mov	r8d, 260				; 00000104H
	mov	rcx, rdi
	call	QWORD PTR __imp_GetModuleFileNameA

; 58   :     ASSERT ( 0 != dwRet ) ;
; 59   :     if ( 0 == dwRet )

	test	eax, eax
	je	SHORT $LN268@Win95GetMo
; File c:\program files (x86)\microsoft visual studio 12.0\vc\include\string.h

; 226  :         { return (char*)strrchr((const char*)_Str, _Ch); }

	lea	rcx, QWORD PTR szBuff$[rsp]
	mov	edx, 92					; 0000005cH
	call	QWORD PTR __imp_strrchr
	mov	rdi, rax
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 67   :     if ( NULL != pStart )

	test	rax, rax
	je	SHORT $LN2@Win95GetMo

; 68   :     {
; 69   :         // Move up one character.
; 70   :         pStart++ ;

	inc	rdi

; 71   :         //lint -e666
; 72   :         iMin = min ( (int)nSize , (lstrlen ( pStart ) + 1) ) ;

	mov	rcx, rdi
	call	QWORD PTR __imp_lstrlenA
	inc	eax
	cmp	ebx, eax
	jl	SHORT $LN8@Win95GetMo
	mov	rcx, rdi
	call	QWORD PTR __imp_lstrlenA
	lea	ebx, DWORD PTR [rax+1]
$LN8@Win95GetMo:

; 73   :         //lint +e666
; 74   :         lstrcpyn ( lpBaseName , pStart , iMin ) ;

	mov	rdx, rdi

; 75   :     }
; 76   :     else

	jmp	SHORT $LN267@Win95GetMo
$LN2@Win95GetMo:

; 77   :     {
; 78   :         // Copy the szBuff buffer in.
; 79   :         //lint -e666
; 80   :         iMin = min ( (int)nSize , (lstrlen ( szBuff ) + 1) ) ;

	lea	rcx, QWORD PTR szBuff$[rsp]
	call	QWORD PTR __imp_lstrlenA
	inc	eax
	cmp	ebx, eax
	jl	SHORT $LN10@Win95GetMo
	lea	rcx, QWORD PTR szBuff$[rsp]
	call	QWORD PTR __imp_lstrlenA
	lea	ebx, DWORD PTR [rax+1]
$LN10@Win95GetMo:

; 81   :         //lint +e666
; 82   :         lstrcpyn ( lpBaseName , szBuff , iMin ) ;

	lea	rdx, QWORD PTR szBuff$[rsp]
$LN267@Win95GetMo:
	mov	r8d, ebx
	mov	rcx, rsi
	call	QWORD PTR __imp_lstrcpynA

; 83   :     }
; 84   :     // Always NULL terminate.
; 85   :     lpBaseName[ iMin ] = '\0' ;

	movsxd	rax, ebx
	mov	BYTE PTR [rax+rsi], 0

; 86   :     return ( (DWORD)(iMin - 1) ) ;

	lea	eax, DWORD PTR [rbx-1]
$LN5@Win95GetMo:

; 87   : }

	lea	r11, QWORD PTR [rsp+304]
	mov	rbx, QWORD PTR [r11+16]
	mov	rsi, QWORD PTR [r11+24]
	mov	rsp, r11
	pop	rdi
	ret	0
?Win95GetModuleBaseName@@YAKPEAXPEAUHINSTANCE__@@PEADK@Z ENDP ; Win95GetModuleBaseName
_TEXT	ENDS
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp
_TEXT	SEGMENT
dwCount$1 = 64
p$ = 72
p$ = 72
p$ = 72
stOSVI$2 = 80
szModName$3 = 240
dwPID$ = 544
hProcess$ = 552
UserSearchPath$ = 560
fInvadeProcess$ = 568
BSUSymInitialize PROC

; 94   : {

$LN307:
	mov	QWORD PTR [rsp+16], rbx
	mov	QWORD PTR [rsp+24], rsi
	push	rbp
	push	rdi
	push	r14
	lea	rbp, QWORD PTR [rsp-256]
	sub	rsp, 512				; 00000200H
	mov	ebx, r9d
	mov	rdi, r8
	mov	rsi, rdx
	mov	r14d, ecx

; 95   :     // If this is any flavor of NT or fInvadeProcess is FALSE, just call
; 96   :     // SymInitialize itself
; 97   :     if ( ( TRUE == IsNT ( ) ) || ( FALSE == fInvadeProcess ) )

	call	IsNT
	cmp	eax, 1
	je	$LN11@BSUSymInit
	test	ebx, ebx
	je	$LN11@BSUSymInit

; 102  :     }
; 103  :     else
; 104  :     {
; 105  :         // This is Win9x and the user wants to invade!
; 106  : 
; 107  :         // The first step is to initialize the symbol engine.  If it
; 108  :         // fails, there is not much I can do.
; 109  :         BOOL bSymInit = ::SymInitialize ( hProcess       ,
; 110  :                                           UserSearchPath ,
; 111  :                                           fInvadeProcess  ) ;

	mov	r8d, ebx
	mov	rdx, rdi
	mov	rcx, rsi
	call	QWORD PTR __imp_SymInitialize

; 112  :         ASSERT ( FALSE != bSymInit ) ;
; 113  :         if ( FALSE == bSymInit )

	test	eax, eax
	je	$LN305@BSUSymInit
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp

; 38   :                                      uiCount * sizeof(HMODULE) ) ) )   )

	lea	rcx, QWORD PTR dwCount$1[rsp]
	mov	edx, 4
	call	QWORD PTR __imp_IsBadWritePtr
	cmp	eax, 1
	je	$LN18@BSUSymInit

; 41   :         return ( FALSE ) ;
; 42   :     }
; 43   : 
; 44   :     // Figure out which OS we are on.
; 45   :     OSVERSIONINFO stOSVI ;
; 46   : 
; 47   :     FillMemory ( &stOSVI ,sizeof ( OSVERSIONINFO ), NULL  ) ;

	lea	rcx, QWORD PTR stOSVI$2[rsp]
	xor	edx, edx
	mov	r8d, 148				; 00000094H
	call	QWORD PTR ?Memory@@3VxrMemory@@A+16

; 48   :     stOSVI.dwOSVersionInfoSize = sizeof ( OSVERSIONINFO ) ;
; 49   : 
; 50   :     BOOL bRet = GetVersionEx ( &stOSVI ) ;

	lea	rcx, QWORD PTR stOSVI$2[rsp]
	mov	DWORD PTR stOSVI$2[rsp], 148		; 00000094H
	call	QWORD PTR __imp_GetVersionExA

; 51   :     ASSERT ( TRUE == bRet ) ;
; 52   :     if ( FALSE == bRet )

	test	eax, eax
	jne	SHORT $LN17@BSUSymInit

; 53   :     {
; 54   :         TRACE0 ( "GetVersionEx failed!\n" ) ;

	lea	rcx, OFFSET FLAT:??_C@_0BG@NMFPCNDP@GetVersionEx?5failed?$CB?6?$AA@
	call	?Log@@YAXPEBD@Z				; Log
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 127  :             VERIFY ( ::SymCleanup ( hProcess ) ) ;

	mov	rcx, rsi
	call	QWORD PTR __imp_SymCleanup

; 128  :             return ( FALSE ) ;

	xor	eax, eax
	jmp	$LN13@BSUSymInit
$LN17@BSUSymInit:
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp

; 60   :          ( 4 == stOSVI.dwMajorVersion                   )    )

	cmp	DWORD PTR stOSVI$2[rsp+16], 2
	jne	SHORT $LN16@BSUSymInit
	cmp	DWORD PTR stOSVI$2[rsp+4], 4
	jne	SHORT $LN16@BSUSymInit

; 61   :     {
; 62   :         // This is NT 4 so call its specific version in PSAPI.DLL
; 63   :         return ( NT4GetLoadedModules ( dwPID        ,
; 64   :                                        uiCount      ,
; 65   :                                        paModArray   ,
; 66   :                                        pdwRealCount  ) );

	lea	r9, QWORD PTR dwCount$1[rsp]
	xor	r8d, r8d
	xor	edx, edx
	mov	ecx, r14d
	call	?NT4GetLoadedModules@@YAHKIPEAPEAUHINSTANCE__@@PEAK@Z ; NT4GetLoadedModules
	jmp	SHORT $LN15@BSUSymInit
$LN16@BSUSymInit:

; 67   :     }
; 68   :     else
; 69   :     {
; 70   :         // Win9x and Win2K go through tool help.
; 71   :         return ( TLHELPGetLoadedModules ( dwPID         ,
; 72   :                                           uiCount       ,
; 73   :                                           paModArray    ,
; 74   :                                           pdwRealCount   ) ) ;

	lea	r9, QWORD PTR dwCount$1[rsp]
	xor	r8d, r8d
	xor	edx, edx
	mov	ecx, r14d
	call	?TLHELPGetLoadedModules@@YAHKIPEAPEAUHINSTANCE__@@PEAK@Z ; TLHELPGetLoadedModules
$LN15@BSUSymInit:
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 123  :                                          &dwCount  ) )

	test	eax, eax
	je	$LN301@BSUSymInit

; 131  :         HMODULE * paMods = new HMODULE[ dwCount ] ;

	mov	ecx, DWORD PTR dwCount$1[rsp]
	mov	eax, 8
	mul	rcx
	mov	rcx, -1
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h

; 128  : 	IC void*	operator new[]		(size_t size)		{	return Memory.mem_alloc(size?size:1);				}

	mov	edx, 1
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 131  :         HMODULE * paMods = new HMODULE[ dwCount ] ;

	cmovo	rax, rcx
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h

; 128  : 	IC void*	operator new[]		(size_t size)		{	return Memory.mem_alloc(size?size:1);				}

	lea	rcx, OFFSET FLAT:?Memory@@3VxrMemory@@A	; Memory
	test	rax, rax
	cmovne	rdx, rax
	call	?mem_alloc@xrMemory@@QEAAPEAX_K@Z	; xrMemory::mem_alloc
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 137  :                                          &dwCount  ) )

	mov	ebx, DWORD PTR dwCount$1[rsp]
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp

; 38   :                                      uiCount * sizeof(HMODULE) ) ) )   )

	lea	rcx, QWORD PTR dwCount$1[rsp]
	mov	edx, 4
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h

; 128  : 	IC void*	operator new[]		(size_t size)		{	return Memory.mem_alloc(size?size:1);				}

	mov	rdi, rax
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp

; 38   :                                      uiCount * sizeof(HMODULE) ) ) )   )

	call	QWORD PTR __imp_IsBadWritePtr
	cmp	eax, 1
	je	$LN281@BSUSymInit
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 137  :                                          &dwCount  ) )

	lea	r9, QWORD PTR dwCount$1[rsp]
	mov	r8, rdi
	mov	edx, ebx
	mov	ecx, r14d
	call	GetLoadedModules
	test	eax, eax
	je	$LN302@BSUSymInit

; 145  :         }
; 146  :         // The module filename.
; 147  :         TCHAR szModName [ MAX_PATH ] ;
; 148  :         for ( UINT uiCurr = 0 ; uiCurr < dwCount ; uiCurr++ )

	mov	QWORD PTR [rsp+544], r15
	xor	r15d, r15d
	mov	ebx, r15d
	cmp	DWORD PTR dwCount$1[rsp], ebx
	jbe	$LN4@BSUSymInit
	npad	14
$LL6@BSUSymInit:

; 149  :         {
; 150  :             // Get the module's filename.
; 151  :             if ( FALSE == GetModuleFileName ( paMods[ uiCurr ]     ,
; 152  :                                               szModName            ,
; 153  :                                               sizeof ( szModName )  ) )

	mov	eax, ebx
	lea	rdx, QWORD PTR szModName$3[rbp-256]
	mov	r8d, 260				; 00000104H
	mov	rcx, QWORD PTR [rdi+rax*8]
	lea	r14, QWORD PTR [rdi+rax*8]
	call	QWORD PTR __imp_GetModuleFileNameA
	test	eax, eax
	je	$LN296@BSUSymInit

; 161  :             }
; 162  : 
; 163  :             // In order to get the symbol engine to work outside a
; 164  :             // debugger, it needs a handle to the image.  Yes, this
; 165  :             // will leak but the OS will close it down when the process
; 166  :             // ends.
; 167  :             HANDLE hFile = CreateFile ( szModName       ,
; 168  :                                         GENERIC_READ    ,
; 169  :                                         FILE_SHARE_READ ,
; 170  :                                         NULL            ,
; 171  :                                         OPEN_EXISTING   ,
; 172  :                                         0               ,
; 173  :                                         0                ) ;

	xor	r9d, r9d
	mov	QWORD PTR [rsp+48], r15
	lea	rcx, QWORD PTR szModName$3[rbp-256]
	lea	r8d, QWORD PTR [r9+1]
	mov	edx, -2147483648			; 80000000H
	mov	DWORD PTR [rsp+40], r15d
	mov	DWORD PTR [rsp+32], 3
	call	QWORD PTR __imp_CreateFileA

; 174  : 
; 175  :             // For whatever reason, SymLoadModule can return zero, but
; 176  :             // it still loads the modules.  Sheez.
; 177  :             if ( FALSE == SymLoadModule ( hProcess               ,
; 178  :                                           hFile                  ,
; 179  :                                           szModName              ,
; 180  :                                           NULL                   ,
; 181  :                                          (DWORD)paMods[ uiCurr ] ,
; 182  :                                           0                       ) )

	mov	ecx, DWORD PTR [r14]
	mov	DWORD PTR [rsp+40], r15d
	mov	QWORD PTR [rsp+32], rcx
	lea	r8, QWORD PTR szModName$3[rbp-256]
	mov	rcx, rsi
	xor	r9d, r9d
	mov	rdx, rax
	call	QWORD PTR __imp_SymLoadModule64
	test	rax, rax
	jne	SHORT $LN5@BSUSymInit

; 183  :             {
; 184  :                 // Check the last error value.  If it is zero, then all
; 185  :                 // I can assume is that it worked.
; 186  :                 DWORD dwLastErr = GetLastError ( ) ;

	call	QWORD PTR __imp_GetLastError

; 187  :                 ASSERT ( ERROR_SUCCESS == dwLastErr ) ;
; 188  :                 if ( ERROR_SUCCESS != dwLastErr )

	test	eax, eax
	jne	SHORT $LN296@BSUSymInit
$LN5@BSUSymInit:

; 145  :         }
; 146  :         // The module filename.
; 147  :         TCHAR szModName [ MAX_PATH ] ;
; 148  :         for ( UINT uiCurr = 0 ; uiCurr < dwCount ; uiCurr++ )

	inc	ebx
	cmp	ebx, DWORD PTR dwCount$1[rsp]
	jb	$LL6@BSUSymInit
$LN4@BSUSymInit:
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h

; 129  : 	IC void		operator delete[]	(void* p)			{	xr_free(p);											}

	lea	rcx, QWORD PTR p$[rsp]
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 198  :         delete [] paMods ;

	mov	QWORD PTR p$[rsp], rdi
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h

; 129  : 	IC void		operator delete[]	(void* p)			{	xr_free(p);											}

	call	??$xr_free@X@@YAXAEAPEAX@Z		; xr_free<void>
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 200  :     return ( TRUE ) ;

	mov	eax, 1
$LN304@BSUSymInit:
	mov	r15, QWORD PTR [rsp+544]
$LN13@BSUSymInit:

; 201  : }

	lea	r11, QWORD PTR [rsp+512]
	mov	rbx, QWORD PTR [r11+40]
	mov	rsi, QWORD PTR [r11+48]
	mov	rsp, r11
	pop	r14
	pop	rdi
	pop	rbp
	ret	0
$LN296@BSUSymInit:

; 154  :             {
; 155  :                 ASSERT ( !"GetModuleFileName failed!" ) ;
; 156  :                 // Clean up the symbol engine and leave.
; 157  :                 VERIFY ( ::SymCleanup ( hProcess ) ) ;

	mov	rcx, rsi
	call	QWORD PTR __imp_SymCleanup
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h

; 129  : 	IC void		operator delete[]	(void* p)			{	xr_free(p);											}

	lea	rcx, QWORD PTR p$[rsp]
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 159  :                 delete [] paMods ;

	mov	QWORD PTR p$[rsp], rdi
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h

; 129  : 	IC void		operator delete[]	(void* p)			{	xr_free(p);											}

	call	??$xr_free@X@@YAXAEAPEAX@Z		; xr_free<void>
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 160  :                 return ( FALSE ) ;

	xor	eax, eax
	jmp	SHORT $LN304@BSUSymInit
$LN281@BSUSymInit:
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp

; 40   :         SetLastErrorEx ( ERROR_INVALID_PARAMETER , SLE_ERROR ) ;

	mov	edx, 1
	lea	ecx, QWORD PTR [rdx+86]
	call	QWORD PTR __imp_SetLastErrorEx
$LN302@BSUSymInit:
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 141  :             VERIFY ( ::SymCleanup ( hProcess ) ) ;

	mov	rcx, rsi
	call	QWORD PTR __imp_SymCleanup
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h

; 129  : 	IC void		operator delete[]	(void* p)			{	xr_free(p);											}

	lea	rcx, QWORD PTR p$[rsp]
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 143  :             delete [] paMods ;

	mov	QWORD PTR p$[rsp], rdi
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory.h

; 129  : 	IC void		operator delete[]	(void* p)			{	xr_free(p);											}

	call	??$xr_free@X@@YAXAEAPEAX@Z		; xr_free<void>
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 144  :             return ( FALSE ) ;

	xor	eax, eax
	jmp	SHORT $LN13@BSUSymInit
$LN18@BSUSymInit:
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\getloadedmodules.cpp

; 40   :         SetLastErrorEx ( ERROR_INVALID_PARAMETER , SLE_ERROR ) ;

	mov	edx, 1
	lea	ecx, QWORD PTR [rdx+86]
	call	QWORD PTR __imp_SetLastErrorEx
$LN301@BSUSymInit:
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\blackbox\bsufunctions.cpp

; 127  :             VERIFY ( ::SymCleanup ( hProcess ) ) ;

	mov	rcx, rsi
	call	QWORD PTR __imp_SymCleanup
$LN305@BSUSymInit:

; 128  :             return ( FALSE ) ;

	xor	eax, eax
	jmp	SHORT $LN13@BSUSymInit
$LN11@BSUSymInit:

; 98   :     {
; 99   :         return ( ::SymInitialize ( hProcess       ,
; 100  :                                    UserSearchPath ,
; 101  :                                    fInvadeProcess  ) ) ;

	mov	r8d, ebx
	mov	rdx, rdi
	mov	rcx, rsi
	call	QWORD PTR __imp_SymInitialize
	jmp	$LN13@BSUSymInit
BSUSymInitialize ENDP
_TEXT	ENDS
END
