; Listing generated by Microsoft (R) Optimizing Compiler Version 18.00.40629.0 

include listing.inc

INCLUDELIB OLDNAMES

PUBLIC	??_C@_0BK@PMIJIOLO@CStreamReader?3?3open_chunk?$AA@ ; `string'
PUBLIC	??_C@_0BC@KONKOEDC@stream_reader?4cpp?$AA@	; `string'
PUBLIC	??_C@_0CO@HFDHLGGI@cannot?5use?5CStreamReader?5on?5comp@ ; `string'
PUBLIC	??_C@_0M@EEKDJLEO@?$CBcompressed?$AA@		; `string'
;	COMDAT ?ignore_always@?5??open_chunk@CStreamReader@@QEAAPEAV2@AEBI@Z@4_NA
_BSS	SEGMENT
?ignore_always@?5??open_chunk@CStreamReader@@QEAAPEAV2@AEBI@Z@4_NA DB 01H DUP (?) ; `CStreamReader::open_chunk'::`6'::ignore_always
_BSS	ENDS
;	COMDAT ??_C@_0M@EEKDJLEO@?$CBcompressed?$AA@
CONST	SEGMENT
??_C@_0M@EEKDJLEO@?$CBcompressed?$AA@ DB '!compressed', 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_0CO@HFDHLGGI@cannot?5use?5CStreamReader?5on?5comp@
CONST	SEGMENT
??_C@_0CO@HFDHLGGI@cannot?5use?5CStreamReader?5on?5comp@ DB 'cannot use C'
	DB	'StreamReader on compressed chunks', 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_0BC@KONKOEDC@stream_reader?4cpp?$AA@
CONST	SEGMENT
??_C@_0BC@KONKOEDC@stream_reader?4cpp?$AA@ DB 'stream_reader.cpp', 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_0BK@PMIJIOLO@CStreamReader?3?3open_chunk?$AA@
CONST	SEGMENT
??_C@_0BK@PMIJIOLO@CStreamReader?3?3open_chunk?$AA@ DB 'CStreamReader::op'
	DB	'en_chunk', 00H				; `string'
PI_MUL_2 DD	040c90fdbr			; 6.28319
PUBLIC	??$_max@I@@YAIII@Z				; _max<unsigned int>
PUBLIC	?open_chunk@CStreamReader@@QEAAPEAV1@AEBI@Z	; CStreamReader::open_chunk
PUBLIC	?map@CStreamReader@@AEAAXAEBI@Z			; CStreamReader::map
PUBLIC	?advance@CStreamReader@@QEAAXAEBH@Z		; CStreamReader::advance
PUBLIC	?destroy@CStreamReader@@UEAAXXZ			; CStreamReader::destroy
PUBLIC	?construct@CStreamReader@@UEAAXAEBQEAXAEBI111@Z	; CStreamReader::construct
PUBLIC	?r@CStreamReader@@QEAAXPEAXI@Z			; CStreamReader::r
pdata	SEGMENT
$pdata$?open_chunk@CStreamReader@@QEAAPEAV1@AEBI@Z DD imagerel $LN31
	DD	imagerel $LN31+251
	DD	imagerel $unwind$?open_chunk@CStreamReader@@QEAAPEAV1@AEBI@Z
$pdata$?map@CStreamReader@@AEAAXAEBI@Z DD imagerel $LN12
	DD	imagerel $LN12+147
	DD	imagerel $unwind$?map@CStreamReader@@AEAAXAEBI@Z
$pdata$?advance@CStreamReader@@QEAAXAEBH@Z DD imagerel $LN43
	DD	imagerel $LN43+209
	DD	imagerel $unwind$?advance@CStreamReader@@QEAAXAEBH@Z
$pdata$?construct@CStreamReader@@UEAAXAEBQEAXAEBI111@Z DD imagerel $LN16
	DD	imagerel $LN16+194
	DD	imagerel $unwind$?construct@CStreamReader@@UEAAXAEBQEAXAEBI111@Z
$pdata$?r@CStreamReader@@QEAAXPEAXI@Z DD imagerel $LN58
	DD	imagerel $LN58+343
	DD	imagerel $unwind$?r@CStreamReader@@QEAAXPEAXI@Z
xdata	SEGMENT
$unwind$?open_chunk@CStreamReader@@QEAAPEAV1@AEBI@Z DD 043101H
	DD	0c3431H
	DD	070029206H
$unwind$?map@CStreamReader@@AEAAXAEBI@Z DD 060f01H
	DD	09640fH
	DD	08340fH
	DD	0700b520fH
$unwind$?advance@CStreamReader@@QEAAXAEBH@Z DD 060f01H
	DD	09640fH
	DD	08340fH
	DD	0700b520fH
$unwind$?construct@CStreamReader@@UEAAXAEBQEAXAEBI111@Z DD 060f01H
	DD	09640fH
	DD	08340fH
	DD	0700b520fH
$unwind$?r@CStreamReader@@QEAAXPEAXI@Z DD 085301H
	DD	0a7453H
	DD	0b340dH
	DD	0e009520dH
	DD	050066007H
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
_TEXT	SEGMENT
this$ = 80
_buffer$ = 88
$T1 = 96
buffer_size$ = 96
?r@CStreamReader@@QEAAXPEAXI@Z PROC			; CStreamReader::r

; 82   : {

$LN58:
	mov	QWORD PTR [rsp+16], rbx
	push	rbp
	push	rsi
	push	r14
	sub	rsp, 48					; 00000030H
	mov	rbx, rcx

; 83   : 	VERIFY						(m_current_pointer >= m_start_pointer);
; 84   : 	VERIFY						(u32(m_current_pointer - m_start_pointer) <= m_current_window_size);
; 85   : 
; 86   : 	int							offset_inside_window = int(m_current_pointer - m_start_pointer);
; 87   : 	if (offset_inside_window + buffer_size < m_current_window_size) {

	mov	ecx, DWORD PTR [rcx+56]
	mov	r14, rdx
	mov	edx, DWORD PTR [rbx+48]
	mov	esi, DWORD PTR [rbx+36]
	mov	eax, ecx
	sub	eax, edx
	mov	ebp, r8d
	add	eax, r8d
	cmp	eax, esi
	jae	SHORT $LN4@r

; 88   : 		Memory.mem_copy			(_buffer,m_current_pointer,buffer_size);

	mov	rdx, QWORD PTR [rbx+56]
	mov	r8d, ebp
	mov	rcx, r14
	call	QWORD PTR ?Memory@@3VxrMemory@@A+8

; 89   : 		m_current_pointer		+= buffer_size;

	add	QWORD PTR [rbx+56], rbp

; 108  : }

	mov	rbx, QWORD PTR [rsp+88]
	add	rsp, 48					; 00000030H
	pop	r14
	pop	rsi
	pop	rbp
	ret	0
$LN4@r:

; 90   : 		return;
; 91   : 	}
; 92   : 
; 93   : 	u8							*buffer = (u8*)_buffer;
; 94   : 	u32							elapsed_in_window = m_current_window_size - (m_current_pointer - m_start_pointer);

	sub	esi, ecx
	mov	QWORD PTR [rsp+80], rdi
	add	esi, edx
	npad	11
$LL3@r:

; 95   : 
; 96   : 	do {
; 97   : 		Memory.mem_copy			(buffer,m_current_pointer,elapsed_in_window);

	mov	rdx, QWORD PTR [rbx+56]
	mov	r8d, esi
	mov	rcx, r14
	call	QWORD PTR ?Memory@@3VxrMemory@@A+8

; 98   : 		buffer					+= elapsed_in_window;

	mov	eax, esi

; 99   : 		buffer_size				-= elapsed_in_window;

	sub	ebp, esi
	add	r14, rax

; 61   : }
; 62   : 
; 63   : void CStreamReader::advance					(const int &offset)
; 64   : {
; 65   : 	VERIFY						(m_current_pointer >= m_start_pointer);
; 66   : 	VERIFY						(u32(m_current_pointer - m_start_pointer) <= m_current_window_size);
; 67   : 	int							offset_inside_window = int(m_current_pointer - m_start_pointer);

	mov	eax, DWORD PTR [rbx+56]
	sub	eax, DWORD PTR [rbx+48]

; 68   : 	if (offset_inside_window + offset >= (int)m_current_window_size) {

	lea	ecx, DWORD PTR [rax+rsi]
	cmp	ecx, DWORD PTR [rbx+36]
	jl	$LN14@r
$LN56@r:

; 69   : 		remap					(m_current_offset_from_start + offset_inside_window + offset);

	mov	edi, DWORD PTR [rbx+32]
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h

; 30   : 	UnmapViewOfFile	(m_current_map_view_of_file);

	mov	rcx, QWORD PTR [rbx+40]
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp

; 69   : 		remap					(m_current_offset_from_start + offset_inside_window + offset);

	add	edi, eax
	add	edi, esi
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h

; 30   : 	UnmapViewOfFile	(m_current_map_view_of_file);

	call	QWORD PTR __imp_UnmapViewOfFile
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp

; 34   : 	start_offset				= (start_offset/granularity)*granularity;

	xor	edx, edx
	mov	DWORD PTR [rbx+32], edi
	add	edi, DWORD PTR [rbx+16]
	mov	rax, QWORD PTR ?xr_FS@@3PEAVCLocatorAPI@@EA ; xr_FS
	mov	r8d, DWORD PTR [rax+116]
	mov	eax, edi
	div	r8d

; 35   : 
; 36   : 	VERIFY						(pure_start_offset >= start_offset);
; 37   : 	u32							pure_end_offset = m_window_size + pure_start_offset;
; 38   : 	u32							end_offset = pure_end_offset/granularity;

	xor	edx, edx
	mov	esi, eax
	mov	eax, DWORD PTR [rbx+28]
	add	eax, edi
	div	r8d
	imul	esi, r8d

; 39   : 	if (pure_end_offset%granularity)

	test	edx, edx
	je	SHORT $LN28@r

; 40   : 		++end_offset;

	inc	eax
$LN28@r:

; 41   : 
; 42   : 	end_offset					*= granularity;
; 43   : 	if (end_offset > m_archive_size)
; 44   : 		end_offset				= m_archive_size;
; 45   : 	
; 46   : 	m_current_window_size		= end_offset - start_offset;
; 47   : 	m_current_map_view_of_file	= (u8*)
; 48   : 		MapViewOfFile(
; 49   : 			m_file_mapping_handle,
; 50   : 			FILE_MAP_READ,
; 51   : 			0,
; 52   : 			start_offset,
; 53   : 			m_current_window_size
; 54   : 		);

	mov	rcx, QWORD PTR [rbx+8]
	imul	eax, r8d
	mov	r9d, esi
	cmp	eax, DWORD PTR [rbx+24]
	cmova	eax, DWORD PTR [rbx+24]
	xor	r8d, r8d
	sub	eax, esi
	lea	edx, QWORD PTR [r8+4]
	mov	DWORD PTR [rbx+36], eax
	mov	QWORD PTR [rsp+32], rax
	call	QWORD PTR __imp_MapViewOfFile

; 55   : 	m_current_pointer			= m_current_map_view_of_file;
; 56   : 
; 57   : 	u32							difference = pure_start_offset - start_offset;

	sub	edi, esi
	mov	QWORD PTR [rbx+40], rax

; 58   : 	m_current_window_size		-= difference;

	sub	DWORD PTR [rbx+36], edi

; 59   : 	m_current_pointer			+= difference;

	mov	ecx, edi
	add	rax, rcx
	mov	QWORD PTR [rbx+56], rax

; 60   : 	m_start_pointer				= m_current_pointer;

	mov	QWORD PTR [rbx+48], rax

; 70   : 		return;

	jmp	SHORT $LN21@r
$LN14@r:

; 71   : 	}
; 72   : 
; 73   : 	if (offset_inside_window + offset < 0) {

	test	ecx, ecx
	js	$LN56@r

; 74   : 		remap					(m_current_offset_from_start + offset_inside_window + offset);
; 75   : 		return;
; 76   : 	}
; 77   : 
; 78   : 	m_current_pointer			+= offset;

	movsxd	rax, esi
	add	QWORD PTR [rbx+56], rax
$LN21@r:

; 100  : 		advance					(elapsed_in_window);
; 101  : 
; 102  : 		elapsed_in_window		= m_current_window_size;

	mov	esi, DWORD PTR [rbx+36]

; 103  : 	}
; 104  : 	while (m_current_window_size < buffer_size);

	cmp	esi, ebp
	jb	$LL3@r

; 105  : 
; 106  : 	Memory.mem_copy				(buffer,m_current_pointer,buffer_size);

	mov	rdx, QWORD PTR [rbx+56]
	mov	r8d, ebp
	mov	rcx, r14
	call	QWORD PTR ?Memory@@3VxrMemory@@A+8

; 107  : 	advance						(buffer_size);

	lea	rdx, QWORD PTR $T1[rsp]
	mov	rcx, rbx
	mov	DWORD PTR $T1[rsp], ebp
	call	?advance@CStreamReader@@QEAAXAEBH@Z	; CStreamReader::advance
	mov	rdi, QWORD PTR [rsp+80]

; 108  : }

	mov	rbx, QWORD PTR [rsp+88]
	add	rsp, 48					; 00000030H
	pop	r14
	pop	rsi
	pop	rbp
	ret	0
?r@CStreamReader@@QEAAXPEAXI@Z ENDP			; CStreamReader::r
_TEXT	ENDS
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\_std_extensions.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
_TEXT	SEGMENT
this$ = 64
file_mapping_handle$ = 72
start_offset$ = 80
file_size$ = 88
archive_size$ = 96
window_size$ = 104
?construct@CStreamReader@@UEAAXAEBQEAXAEBI111@Z PROC	; CStreamReader::construct

; 11   : {

$LN16:
	mov	QWORD PTR [rsp+8], rbx
	mov	QWORD PTR [rsp+16], rsi
	push	rdi
	sub	rsp, 48					; 00000030H

; 12   : 	m_file_mapping_handle		= file_mapping_handle;

	mov	rax, QWORD PTR [rdx]
	mov	rbx, rcx
	mov	QWORD PTR [rcx+8], rax

; 13   : 	m_start_offset				= start_offset;

	mov	edi, DWORD PTR [r8]
	mov	DWORD PTR [rcx+16], edi

; 14   : 	m_file_size					= file_size;

	mov	eax, DWORD PTR [r9]
	mov	DWORD PTR [rcx+20], eax

; 15   : 	m_archive_size				= archive_size;

	mov	rax, QWORD PTR archive_size$[rsp]
	mov	edx, DWORD PTR [rax]
	mov	DWORD PTR [rcx+24], edx

; 16   : 	m_window_size				= _max(window_size,FS.dwAllocGranularity);

	mov	rax, QWORD PTR ?xr_FS@@3PEAVCLocatorAPI@@EA ; xr_FS
	mov	r8d, DWORD PTR [rax+116]
	mov	rax, QWORD PTR window_size$[rsp]
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\_std_extensions.h

; 94   : template <class T>	IC T		_max	(T a, T b)	{ return a>b?a:b;	}

	cmp	DWORD PTR [rax], r8d
	cmova	r8d, DWORD PTR [rax]
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp

; 34   : 	start_offset				= (start_offset/granularity)*granularity;

	xor	edx, edx
	mov	DWORD PTR [rcx+32], 0

; 16   : 	m_window_size				= _max(window_size,FS.dwAllocGranularity);

	mov	DWORD PTR [rcx+28], r8d

; 20   : 
; 21   : void CStreamReader::destroy					()
; 22   : {
; 23   : 	unmap						();
; 24   : }
; 25   : 
; 26   : void CStreamReader::map						(const u32 &new_offset)
; 27   : {
; 28   : 	VERIFY						(new_offset <= m_file_size);
; 29   : 	m_current_offset_from_start	= new_offset;
; 30   : 
; 31   : 	u32							granularity = FS.dwAllocGranularity;

	mov	rax, QWORD PTR ?xr_FS@@3PEAVCLocatorAPI@@EA ; xr_FS
	mov	ecx, DWORD PTR [rax+116]

; 34   : 	start_offset				= (start_offset/granularity)*granularity;

	mov	eax, edi
	div	ecx

; 35   : 
; 36   : 	VERIFY						(pure_start_offset >= start_offset);
; 37   : 	u32							pure_end_offset = m_window_size + pure_start_offset;
; 38   : 	u32							end_offset = pure_end_offset/granularity;

	xor	edx, edx
	mov	esi, eax
	lea	eax, DWORD PTR [r8+rdi]
	div	ecx
	imul	esi, ecx

; 39   : 	if (pure_end_offset%granularity)

	test	edx, edx
	je	SHORT $LN6@construct

; 40   : 		++end_offset;

	inc	eax
$LN6@construct:

; 41   : 
; 42   : 	end_offset					*= granularity;

	imul	eax, ecx

; 43   : 	if (end_offset > m_archive_size)
; 44   : 		end_offset				= m_archive_size;
; 45   : 	
; 46   : 	m_current_window_size		= end_offset - start_offset;
; 47   : 	m_current_map_view_of_file	= (u8*)
; 48   : 		MapViewOfFile(
; 49   : 			m_file_mapping_handle,
; 50   : 			FILE_MAP_READ,
; 51   : 			0,
; 52   : 			start_offset,
; 53   : 			m_current_window_size
; 54   : 		);

	mov	rcx, QWORD PTR [rbx+8]
	mov	r9d, esi
	cmp	eax, DWORD PTR [rbx+24]
	cmova	eax, DWORD PTR [rbx+24]
	xor	r8d, r8d
	sub	eax, esi
	lea	edx, QWORD PTR [r8+4]
	mov	DWORD PTR [rbx+36], eax
	mov	QWORD PTR [rsp+32], rax
	call	QWORD PTR __imp_MapViewOfFile

; 55   : 	m_current_pointer			= m_current_map_view_of_file;
; 56   : 
; 57   : 	u32							difference = pure_start_offset - start_offset;

	sub	edi, esi

; 17   : 
; 18   : 	map							(0);
; 19   : }

	mov	rsi, QWORD PTR [rsp+72]

; 43   : 	if (end_offset > m_archive_size)
; 44   : 		end_offset				= m_archive_size;
; 45   : 	
; 46   : 	m_current_window_size		= end_offset - start_offset;
; 47   : 	m_current_map_view_of_file	= (u8*)
; 48   : 		MapViewOfFile(
; 49   : 			m_file_mapping_handle,
; 50   : 			FILE_MAP_READ,
; 51   : 			0,
; 52   : 			start_offset,
; 53   : 			m_current_window_size
; 54   : 		);

	mov	QWORD PTR [rbx+40], rax

; 58   : 	m_current_window_size		-= difference;

	sub	DWORD PTR [rbx+36], edi

; 59   : 	m_current_pointer			+= difference;

	mov	ecx, edi
	add	rax, rcx
	mov	QWORD PTR [rbx+56], rax

; 60   : 	m_start_pointer				= m_current_pointer;

	mov	QWORD PTR [rbx+48], rax

; 17   : 
; 18   : 	map							(0);
; 19   : }

	mov	rbx, QWORD PTR [rsp+64]
	add	rsp, 48					; 00000030H
	pop	rdi
	ret	0
?construct@CStreamReader@@UEAAXAEBQEAXAEBI111@Z ENDP	; CStreamReader::construct
_TEXT	ENDS
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
_TEXT	SEGMENT
this$ = 8
?destroy@CStreamReader@@UEAAXXZ PROC			; CStreamReader::destroy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h

; 30   : 	UnmapViewOfFile	(m_current_map_view_of_file);

	mov	rcx, QWORD PTR [rcx+40]
	rex_jmp	QWORD PTR __imp_UnmapViewOfFile
?destroy@CStreamReader@@UEAAXXZ ENDP			; CStreamReader::destroy
_TEXT	ENDS
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
_TEXT	SEGMENT
this$ = 64
offset$ = 72
?advance@CStreamReader@@QEAAXAEBH@Z PROC		; CStreamReader::advance

; 64   : {

$LN43:
	mov	QWORD PTR [rsp+8], rbx
	mov	QWORD PTR [rsp+16], rsi
	push	rdi
	sub	rsp, 48					; 00000030H

; 65   : 	VERIFY						(m_current_pointer >= m_start_pointer);
; 66   : 	VERIFY						(u32(m_current_pointer - m_start_pointer) <= m_current_window_size);
; 67   : 	int							offset_inside_window = int(m_current_pointer - m_start_pointer);

	mov	eax, DWORD PTR [rcx+56]
	mov	rdi, rcx
	sub	eax, DWORD PTR [rcx+48]

; 68   : 	if (offset_inside_window + offset >= (int)m_current_window_size) {

	movsxd	rcx, DWORD PTR [rdx]
	lea	edx, DWORD PTR [rcx+rax]
	cmp	edx, DWORD PTR [rdi+36]
	jl	$LN2@advance
$LN41@advance:

; 69   : 		remap					(m_current_offset_from_start + offset_inside_window + offset);

	mov	ebx, DWORD PTR [rdi+32]
	add	ebx, ecx
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h

; 30   : 	UnmapViewOfFile	(m_current_map_view_of_file);

	mov	rcx, QWORD PTR [rdi+40]
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp

; 69   : 		remap					(m_current_offset_from_start + offset_inside_window + offset);

	add	ebx, eax
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h

; 30   : 	UnmapViewOfFile	(m_current_map_view_of_file);

	call	QWORD PTR __imp_UnmapViewOfFile
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp

; 34   : 	start_offset				= (start_offset/granularity)*granularity;

	xor	edx, edx
	mov	DWORD PTR [rdi+32], ebx
	add	ebx, DWORD PTR [rdi+16]
	mov	rax, QWORD PTR ?xr_FS@@3PEAVCLocatorAPI@@EA ; xr_FS
	mov	r8d, DWORD PTR [rax+116]
	mov	eax, ebx
	div	r8d

; 35   : 
; 36   : 	VERIFY						(pure_start_offset >= start_offset);
; 37   : 	u32							pure_end_offset = m_window_size + pure_start_offset;
; 38   : 	u32							end_offset = pure_end_offset/granularity;

	xor	edx, edx
	mov	esi, eax
	mov	eax, DWORD PTR [rdi+28]
	add	eax, ebx
	div	r8d
	imul	esi, r8d

; 39   : 	if (pure_end_offset%granularity)

	test	edx, edx
	je	SHORT $LN16@advance

; 40   : 		++end_offset;

	inc	eax
$LN16@advance:

; 41   : 
; 42   : 	end_offset					*= granularity;
; 43   : 	if (end_offset > m_archive_size)
; 44   : 		end_offset				= m_archive_size;
; 45   : 	
; 46   : 	m_current_window_size		= end_offset - start_offset;
; 47   : 	m_current_map_view_of_file	= (u8*)
; 48   : 		MapViewOfFile(
; 49   : 			m_file_mapping_handle,
; 50   : 			FILE_MAP_READ,
; 51   : 			0,
; 52   : 			start_offset,
; 53   : 			m_current_window_size
; 54   : 		);

	mov	rcx, QWORD PTR [rdi+8]
	imul	eax, r8d
	mov	r9d, esi
	cmp	eax, DWORD PTR [rdi+24]
	cmova	eax, DWORD PTR [rdi+24]
	xor	r8d, r8d
	sub	eax, esi
	lea	edx, QWORD PTR [r8+4]
	mov	DWORD PTR [rdi+36], eax
	mov	QWORD PTR [rsp+32], rax
	call	QWORD PTR __imp_MapViewOfFile

; 55   : 	m_current_pointer			= m_current_map_view_of_file;
; 56   : 
; 57   : 	u32							difference = pure_start_offset - start_offset;

	sub	ebx, esi
	mov	QWORD PTR [rdi+40], rax

; 58   : 	m_current_window_size		-= difference;

	sub	DWORD PTR [rdi+36], ebx

; 59   : 	m_current_pointer			+= difference;

	mov	ecx, ebx
	add	rax, rcx
	mov	QWORD PTR [rdi+56], rax

; 60   : 	m_start_pointer				= m_current_pointer;

	mov	QWORD PTR [rdi+48], rax

; 79   : }

	mov	rbx, QWORD PTR [rsp+64]
	mov	rsi, QWORD PTR [rsp+72]
	add	rsp, 48					; 00000030H
	pop	rdi
	ret	0
$LN2@advance:

; 70   : 		return;
; 71   : 	}
; 72   : 
; 73   : 	if (offset_inside_window + offset < 0) {

	test	edx, edx
	js	$LN41@advance

; 74   : 		remap					(m_current_offset_from_start + offset_inside_window + offset);
; 75   : 		return;
; 76   : 	}
; 77   : 
; 78   : 	m_current_pointer			+= offset;

	add	QWORD PTR [rdi+56], rcx

; 79   : }

	mov	rbx, QWORD PTR [rsp+64]
	mov	rsi, QWORD PTR [rsp+72]
	add	rsp, 48					; 00000030H
	pop	rdi
	ret	0
?advance@CStreamReader@@QEAAXAEBH@Z ENDP		; CStreamReader::advance
_TEXT	ENDS
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
_TEXT	SEGMENT
this$ = 64
new_offset$ = 72
?map@CStreamReader@@AEAAXAEBI@Z PROC			; CStreamReader::map

; 27   : {

$LN12:
	mov	QWORD PTR [rsp+8], rbx
	mov	QWORD PTR [rsp+16], rsi
	push	rdi
	sub	rsp, 48					; 00000030H

; 28   : 	VERIFY						(new_offset <= m_file_size);
; 29   : 	m_current_offset_from_start	= new_offset;

	mov	eax, DWORD PTR [rdx]

; 30   : 
; 31   : 	u32							granularity = FS.dwAllocGranularity;
; 32   : 	u32							start_offset = m_start_offset + new_offset;

	mov	edi, DWORD PTR [rcx+16]
	mov	rbx, rcx
	mov	DWORD PTR [rcx+32], eax
	add	edi, DWORD PTR [rdx]
	mov	rax, QWORD PTR ?xr_FS@@3PEAVCLocatorAPI@@EA ; xr_FS
	mov	r8d, DWORD PTR [rax+116]

; 33   : 	u32							pure_start_offset = start_offset;
; 34   : 	start_offset				= (start_offset/granularity)*granularity;

	xor	edx, edx
	mov	eax, edi
	div	r8d

; 35   : 
; 36   : 	VERIFY						(pure_start_offset >= start_offset);
; 37   : 	u32							pure_end_offset = m_window_size + pure_start_offset;
; 38   : 	u32							end_offset = pure_end_offset/granularity;

	xor	edx, edx
	mov	esi, eax
	mov	eax, DWORD PTR [rcx+28]
	add	eax, edi
	div	r8d
	imul	esi, r8d

; 39   : 	if (pure_end_offset%granularity)

	test	edx, edx
	je	SHORT $LN2@map

; 40   : 		++end_offset;

	inc	eax
$LN2@map:

; 41   : 
; 42   : 	end_offset					*= granularity;

	imul	eax, r8d

; 43   : 	if (end_offset > m_archive_size)
; 44   : 		end_offset				= m_archive_size;
; 45   : 	
; 46   : 	m_current_window_size		= end_offset - start_offset;
; 47   : 	m_current_map_view_of_file	= (u8*)
; 48   : 		MapViewOfFile(
; 49   : 			m_file_mapping_handle,
; 50   : 			FILE_MAP_READ,
; 51   : 			0,
; 52   : 			start_offset,
; 53   : 			m_current_window_size
; 54   : 		);

	mov	r9d, esi
	cmp	eax, DWORD PTR [rcx+24]
	cmova	eax, DWORD PTR [rcx+24]
	xor	r8d, r8d
	sub	eax, esi
	lea	edx, QWORD PTR [r8+4]
	mov	DWORD PTR [rcx+36], eax
	mov	rcx, QWORD PTR [rcx+8]
	mov	QWORD PTR [rsp+32], rax
	call	QWORD PTR __imp_MapViewOfFile

; 55   : 	m_current_pointer			= m_current_map_view_of_file;
; 56   : 
; 57   : 	u32							difference = pure_start_offset - start_offset;

	sub	edi, esi

; 58   : 	m_current_window_size		-= difference;
; 59   : 	m_current_pointer			+= difference;
; 60   : 	m_start_pointer				= m_current_pointer;
; 61   : }

	mov	rsi, QWORD PTR [rsp+72]
	sub	DWORD PTR [rbx+36], edi
	mov	QWORD PTR [rbx+40], rax
	mov	ecx, edi
	add	rax, rcx
	mov	QWORD PTR [rbx+56], rax
	mov	QWORD PTR [rbx+48], rax
	mov	rbx, QWORD PTR [rsp+64]
	add	rsp, 48					; 00000030H
	pop	rdi
	ret	0
?map@CStreamReader@@AEAAXAEBI@Z ENDP			; CStreamReader::map
_TEXT	ENDS
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrdebugnew.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory_subst_msvc.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory_subst_msvc.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp
_TEXT	SEGMENT
this$ = 96
chunk_id$ = 104
$T1 = 112
compressed$ = 112
size$ = 120
?open_chunk@CStreamReader@@QEAAPEAV1@AEBI@Z PROC	; CStreamReader::open_chunk

; 111  : {

$LN31:
	push	rdi
	sub	rsp, 80					; 00000050H

; 112  : 	BOOL						compressed;
; 113  : 	u32							size = find_chunk(chunk_id,&compressed);

	mov	edx, DWORD PTR [rdx]
	lea	r8, QWORD PTR compressed$[rsp]
	mov	rdi, rcx
	call	?find_chunk@?$IReaderBase@VCStreamReader@@@@QEAAIIPEAH@Z ; IReaderBase<CStreamReader>::find_chunk
	mov	DWORD PTR size$[rsp], eax

; 114  : 	if (!size)

	test	eax, eax
	jne	SHORT $LN4@open_chunk

; 115  : 		return					(0);

	xor	eax, eax

; 121  : }

	add	rsp, 80					; 00000050H
	pop	rdi
	ret	0
$LN4@open_chunk:

; 116  : 
; 117  : 	R_ASSERT2					(!compressed,"cannot use CStreamReader on compressed chunks");

	cmp	BYTE PTR ?ignore_always@?5??open_chunk@CStreamReader@@QEAAPEAV2@AEBI@Z@4_NA, 0
	mov	QWORD PTR [rsp+96], rbx
	jne	SHORT $LN3@open_chunk
	cmp	DWORD PTR compressed$[rsp], 0
	je	SHORT $LN3@open_chunk
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrdebugnew.cpp

; 462  : 	backend		(e1,e2,0,0,file,line,function,ignore_always);

	lea	rax, OFFSET FLAT:?ignore_always@?5??open_chunk@CStreamReader@@QEAAPEAV2@AEBI@Z@4_NA
	lea	r8, OFFSET FLAT:??_C@_0CO@HFDHLGGI@cannot?5use?5CStreamReader?5on?5comp@
	lea	rdx, OFFSET FLAT:??_C@_0M@EEKDJLEO@?$CBcompressed?$AA@
	mov	QWORD PTR [rsp+64], rax
	lea	rax, OFFSET FLAT:??_C@_0BK@PMIJIOLO@CStreamReader?3?3open_chunk?$AA@
	lea	rcx, OFFSET FLAT:?Debug@@3VxrDebug@@A	; Debug
	mov	QWORD PTR [rsp+56], rax
	lea	rax, OFFSET FLAT:??_C@_0BC@KONKOEDC@stream_reader?4cpp?$AA@
	mov	DWORD PTR [rsp+48], 117			; 00000075H
	mov	QWORD PTR [rsp+40], rax
	xor	r9d, r9d
	mov	QWORD PTR [rsp+32], 0
	call	?backend@xrDebug@@QEAAXPEBD0000H0AEA_N@Z ; xrDebug::backend
$LN3@open_chunk:
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory_subst_msvc.h

; 68   : 	T* ptr	= (T*)Memory.mem_alloc(sizeof(T));

	lea	rcx, OFFSET FLAT:?Memory@@3VxrMemory@@A	; Memory
	mov	edx, 64					; 00000040H
	call	?mem_alloc@xrMemory@@QEAAPEAX_K@Z	; xrMemory::mem_alloc
	mov	rbx, rax

; 69   : 	return new (ptr) T();

	test	rax, rax
	je	SHORT $LN12@open_chunk
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h

; 5    : {

	lea	rax, OFFSET FLAT:??_7CStreamReader@@6B@
	mov	QWORD PTR [rbx], rax
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\xrmemory_subst_msvc.h

; 69   : 	return new (ptr) T();

	jmp	SHORT $LN13@open_chunk
$LN12@open_chunk:
	xor	ebx, ebx
$LN13@open_chunk:
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp

; 119  : 	result->construct			(file_mapping_handle(),m_start_offset + tell(),size,m_archive_size,m_window_size);

	mov	ecx, DWORD PTR [rdi+56]
	mov	r10, QWORD PTR [rbx]
	lea	r8, QWORD PTR [rdi+24]
	sub	ecx, DWORD PTR [rdi+48]
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader_inline.h

; 25   : 	return			(m_file_mapping_handle);

	lea	rdx, QWORD PTR [rdi+8]
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\stream_reader.cpp

; 119  : 	result->construct			(file_mapping_handle(),m_start_offset + tell(),size,m_archive_size,m_window_size);

	lea	r9, QWORD PTR size$[rsp]
	add	ecx, DWORD PTR [rdi+32]
	add	ecx, DWORD PTR [rdi+16]
	mov	DWORD PTR $T1[rsp], ecx
	lea	rcx, QWORD PTR [rdi+28]
	mov	QWORD PTR [rsp+40], rcx
	mov	QWORD PTR [rsp+32], r8
	lea	r8, QWORD PTR $T1[rsp]
	mov	rcx, rbx
	call	QWORD PTR [r10+8]

; 120  : 	return						(result);

	mov	rax, rbx
	mov	rbx, QWORD PTR [rsp+96]

; 121  : }

	add	rsp, 80					; 00000050H
	pop	rdi
	ret	0
?open_chunk@CStreamReader@@QEAAPEAV1@AEBI@Z ENDP	; CStreamReader::open_chunk
_TEXT	ENDS
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\_std_extensions.h
;	COMDAT ??$_max@I@@YAIII@Z
_TEXT	SEGMENT
a$ = 8
b$ = 16
??$_max@I@@YAIII@Z PROC					; _max<unsigned int>, COMDAT

; 94   : template <class T>	IC T		_max	(T a, T b)	{ return a>b?a:b;	}

	cmp	ecx, edx
	cmova	edx, ecx
	mov	eax, edx
	ret	0
??$_max@I@@YAIII@Z ENDP					; _max<unsigned int>
_TEXT	ENDS
END
