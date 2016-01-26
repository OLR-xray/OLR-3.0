; Listing generated by Microsoft (R) Optimizing Compiler Version 18.00.40629.0 

include listing.inc

INCLUDELIB OLDNAMES

PUBLIC	lzo1x_decompress
pdata	SEGMENT
$pdata$lzo1x_decompress DD imagerel $LN153
	DD	imagerel $LN153+918
	DD	imagerel $unwind$lzo1x_decompress
xdata	SEGMENT
$unwind$lzo1x_decompress DD 040a01H
	DD	02740aH
	DD	013405H
; Function compile flags: /Ogtpy
; File c:\users\nummer\documents\github\olr-3.0\src\xray\xrcore\rt_lzo1x_d.ch
_TEXT	SEGMENT
in$ = 8
in_len$ = 16
out$ = 24
out_len$ = 32
wrkmem$dead$ = 40
lzo1x_decompress PROC

; 61   : {

$LN153:
	mov	QWORD PTR [rsp+8], rbx
	mov	QWORD PTR [rsp+16], rdi

; 62   :     register lzo_bytep op;
; 63   :     register const lzo_bytep ip;
; 64   :     register lzo_uint t;
; 65   : #if defined(COPY_DICT)
; 66   :     lzo_uint m_off;
; 67   :     const lzo_bytep dict_end;
; 68   : #else
; 69   :     register const lzo_bytep m_pos;
; 70   : #endif
; 71   : 
; 72   :     const lzo_bytep const ip_end = in + in_len;
; 73   : #if defined(HAVE_ANY_OP)
; 74   :     lzo_bytep const op_end = out + *out_len;
; 75   : #endif
; 76   : #if defined(LZO1Z)
; 77   :     lzo_uint last_m_off = 0;
; 78   : #endif
; 79   : 
; 80   :     LZO_UNUSED(wrkmem);
; 81   : 
; 82   : #if defined(COPY_DICT)
; 83   :     if (dict)
; 84   :     {
; 85   :         if (dict_len > M4_MAX_OFFSET)
; 86   :         {
; 87   :             dict += dict_len - M4_MAX_OFFSET;
; 88   :             dict_len = M4_MAX_OFFSET;
; 89   :         }
; 90   :         dict_end = dict + dict_len;
; 91   :     }
; 92   :     else
; 93   :     {
; 94   :         dict_len = 0;
; 95   :         dict_end = NULL;
; 96   :     }
; 97   : #endif /* COPY_DICT */
; 98   : 
; 99   :     *out_len = 0;
; 100  : 
; 101  :     op = out;
; 102  :     ip = in;
; 103  : 
; 104  :     if (*ip > 17)

	movzx	eax, BYTE PTR [rcx]
	mov	rdi, r8
	mov	r10, rcx
	lea	rbx, QWORD PTR [rcx+rdx]
	mov	QWORD PTR [r9], 0
	mov	r11, r8
	cmp	al, 17
	jbe	SHORT $LN57@lzo1x_deco

; 105  :     {
; 106  :         t = *ip++ - 17;

	movzx	eax, al
	sub	eax, 17
	inc	r10
	movsxd	rcx, eax

; 107  :         if (t < 4)

	cmp	rcx, 4
	jb	$match_next$154
	npad	5
$LL61@lzo1x_deco:

; 108  :             goto match_next;
; 109  :         assert(t > 0); NEED_OP(t); NEED_IP(t+1);
; 110  :         do *op++ = *ip++; while (--t > 0);

	movzx	eax, BYTE PTR [r10]
	inc	r11
	inc	r10
	mov	BYTE PTR [r11-1], al
	dec	rcx
	jne	SHORT $LL61@lzo1x_deco

; 111  :         goto first_literal_run;

	jmp	$first_literal_run$155
$LN57@lzo1x_deco:

; 112  :     }
; 113  : 
; 114  :     while (TEST_IP && TEST_OP)
; 115  :     {
; 116  :         t = *ip++;

	movzx	eax, BYTE PTR [r10]
	inc	r10

; 117  :         if (t >= 16)

	cmp	rax, 16
	jae	$match$156

; 118  :             goto match;
; 119  :         /* a literal run */
; 120  :         if (t == 0)

	test	rax, rax
	jne	SHORT $LN53@lzo1x_deco

; 121  :         {
; 122  :             NEED_IP(1);
; 123  :             while (*ip == 0)

	cmp	BYTE PTR [r10], al
	jne	SHORT $LN51@lzo1x_deco
	npad	13
$LL52@lzo1x_deco:

; 124  :             {
; 125  :                 t += 255;
; 126  :                 ip++;

	inc	r10
	add	rax, 255				; 000000ffH
	cmp	BYTE PTR [r10], 0
	je	SHORT $LL52@lzo1x_deco
$LN51@lzo1x_deco:

; 127  :                 NEED_IP(1);
; 128  :             }
; 129  :             t += 15 + *ip++;

	movzx	ecx, BYTE PTR [r10]
	add	ecx, 15
	movsxd	rcx, ecx
	add	rax, rcx
	inc	r10
$LN53@lzo1x_deco:

; 130  :         }
; 131  :         /* copy literals */
; 132  :         assert(t > 0); NEED_OP(t+3); NEED_IP(t+4);
; 133  : #if defined(LZO_UNALIGNED_OK_4) || defined(LZO_ALIGNED_OK_4)
; 134  : #if !defined(LZO_UNALIGNED_OK_4)
; 135  :         if (PTR_ALIGNED2_4(op,ip))
; 136  :         {
; 137  : #endif
; 138  :         COPY4(op,ip);

	mov	ecx, DWORD PTR [r10]

; 139  :         op += 4; ip += 4;

	add	r11, 4
	add	r10, 4
	mov	DWORD PTR [r11-4], ecx

; 140  :         if (--t > 0)

	dec	rax
	je	SHORT $first_literal_run$155

; 141  :         {
; 142  :             if (t >= 4)

	cmp	rax, 4
	jb	SHORT $LL40@lzo1x_deco
	npad	7
$LL48@lzo1x_deco:

; 143  :             {
; 144  :                 do {
; 145  :                     COPY4(op,ip);

	mov	ecx, DWORD PTR [r10]

; 146  :                     op += 4; ip += 4; t -= 4;

	sub	rax, 4
	add	r11, 4
	mov	DWORD PTR [r11-4], ecx
	add	r10, 4

; 147  :                 } while (t >= 4);

	cmp	rax, 4
	jae	SHORT $LL48@lzo1x_deco

; 148  :                 if (t > 0) do *op++ = *ip++; while (--t > 0);

	test	rax, rax
	je	SHORT $first_literal_run$155
	npad	2
$LL44@lzo1x_deco:
	movzx	ecx, BYTE PTR [r10]
	inc	r11
	inc	r10
	mov	BYTE PTR [r11-1], cl
	dec	rax
	jne	SHORT $LL44@lzo1x_deco

; 149  :             }
; 150  :             else

	jmp	SHORT $first_literal_run$155
	npad	11
$LL40@lzo1x_deco:

; 151  :                 do *op++ = *ip++; while (--t > 0);

	movzx	ecx, BYTE PTR [r10]
	inc	r11
	inc	r10
	mov	BYTE PTR [r11-1], cl
	dec	rax
	jne	SHORT $LL40@lzo1x_deco
$first_literal_run$155:

; 152  :         }
; 153  : #if !defined(LZO_UNALIGNED_OK_4)
; 154  :         }
; 155  :         else
; 156  : #endif
; 157  : #endif
; 158  : #if !defined(LZO_UNALIGNED_OK_4)
; 159  :         {
; 160  :             *op++ = *ip++; *op++ = *ip++; *op++ = *ip++;
; 161  :             do *op++ = *ip++; while (--t > 0);
; 162  :         }
; 163  : #endif
; 164  : 
; 165  : 
; 166  : first_literal_run:
; 167  : 
; 168  : 
; 169  :         t = *ip++;

	movzx	eax, BYTE PTR [r10]
	inc	r10

; 170  :         if (t >= 16)

	cmp	rax, 16
	jae	SHORT $match$156

; 171  :             goto match;
; 172  : #if defined(COPY_DICT)
; 173  : #if defined(LZO1Z)
; 174  :         m_off = (1 + M2_MAX_OFFSET) + (t << 6) + (*ip++ >> 2);
; 175  :         last_m_off = m_off;
; 176  : #else
; 177  :         m_off = (1 + M2_MAX_OFFSET) + (t >> 2) + (*ip++ << 2);
; 178  : #endif
; 179  :         NEED_OP(3);
; 180  :         t = 3; COPY_DICT(t,m_off)
; 181  : #else /* !COPY_DICT */
; 182  : #if defined(LZO1Z)
; 183  :         t = (1 + M2_MAX_OFFSET) + (t << 6) + (*ip++ >> 2);
; 184  :         m_pos = op - t;
; 185  :         last_m_off = t;
; 186  : #else
; 187  :         m_pos = op - (1 + M2_MAX_OFFSET);
; 188  :         m_pos -= t >> 2;
; 189  :         m_pos -= *ip++ << 2;

	movzx	ecx, BYTE PTR [r10]
	shr	rax, 2
	inc	r10
	shl	ecx, 2
	movsxd	rdx, ecx
	mov	rcx, r11
	sub	rcx, rdx
	sub	rcx, rax

; 190  : #endif
; 191  :         TEST_LB(m_pos); NEED_OP(3);
; 192  :         *op++ = *m_pos++; *op++ = *m_pos++; *op++ = *m_pos;

	add	r11, 3
	movzx	eax, BYTE PTR [rcx-2049]
	mov	BYTE PTR [r11-3], al
	movzx	eax, BYTE PTR [rcx-2048]
	mov	BYTE PTR [r11-2], al
	movzx	eax, BYTE PTR [rcx-2047]
	mov	BYTE PTR [r11-1], al
	jmp	$match_done$157
$match$156:

; 193  : #endif /* COPY_DICT */
; 194  :         goto match_done;
; 195  : 
; 196  : 
; 197  :         /* handle matches */
; 198  :         do {
; 199  : match:
; 200  :             if (t >= 64)                /* a M2 match */

	cmp	rax, 64					; 00000040H
	jb	SHORT $LN31@lzo1x_deco

; 201  :             {
; 202  : #if defined(COPY_DICT)
; 203  : #if defined(LZO1X)
; 204  :                 m_off = 1 + ((t >> 2) & 7) + (*ip++ << 3);
; 205  :                 t = (t >> 5) - 1;
; 206  : #elif defined(LZO1Y)
; 207  :                 m_off = 1 + ((t >> 2) & 3) + (*ip++ << 2);
; 208  :                 t = (t >> 4) - 3;
; 209  : #elif defined(LZO1Z)
; 210  :                 m_off = t & 0x1f;
; 211  :                 if (m_off >= 0x1c)
; 212  :                     m_off = last_m_off;
; 213  :                 else
; 214  :                 {
; 215  :                     m_off = 1 + (m_off << 6) + (*ip++ >> 2);
; 216  :                     last_m_off = m_off;
; 217  :                 }
; 218  :                 t = (t >> 5) - 1;
; 219  : #endif
; 220  : #else /* !COPY_DICT */
; 221  : #if defined(LZO1X)
; 222  :                 m_pos = op - 1;
; 223  :                 m_pos -= (t >> 2) & 7;
; 224  :                 m_pos -= *ip++ << 3;

	mov	rcx, rax
	mov	r8, r11

; 225  :                 t = (t >> 5) - 1;

	shr	rax, 5
	shr	rcx, 2
	inc	r10
	and	ecx, 7
	sub	r8, rcx
	movzx	ecx, BYTE PTR [r10-1]
	shl	ecx, 3
	movsxd	rdx, ecx
	sub	r8, rdx
	dec	r8
	dec	rax
$copy_match$158:

; 395  : #endif
; 396  :             {
; 397  : copy_match:
; 398  :                 *op++ = *m_pos++; *op++ = *m_pos++;

	movzx	ecx, BYTE PTR [r8]
	add	r11, 2
	add	r8, 2
	mov	BYTE PTR [r11-2], cl
	movzx	ecx, BYTE PTR [r8-1]
	mov	BYTE PTR [r11-1], cl
	npad	2
$LL6@lzo1x_deco:

; 399  :                 do *op++ = *m_pos++; while (--t > 0);

	movzx	ecx, BYTE PTR [r8]
	inc	r11
	lea	r8, QWORD PTR [r8+1]
	mov	BYTE PTR [r11-1], cl
	dec	rax
	jne	SHORT $LL6@lzo1x_deco

; 400  :             }
; 401  : 
; 402  : #endif /* COPY_DICT */
; 403  : 
; 404  : match_done:

	jmp	$match_done$157
$LN31@lzo1x_deco:

; 226  : #elif defined(LZO1Y)
; 227  :                 m_pos = op - 1;
; 228  :                 m_pos -= (t >> 2) & 3;
; 229  :                 m_pos -= *ip++ << 2;
; 230  :                 t = (t >> 4) - 3;
; 231  : #elif defined(LZO1Z)
; 232  :                 {
; 233  :                     lzo_uint off = t & 0x1f;
; 234  :                     m_pos = op;
; 235  :                     if (off >= 0x1c)
; 236  :                     {
; 237  :                         assert(last_m_off > 0);
; 238  :                         m_pos -= last_m_off;
; 239  :                     }
; 240  :                     else
; 241  :                     {
; 242  :                         off = 1 + (off << 6) + (*ip++ >> 2);
; 243  :                         m_pos -= off;
; 244  :                         last_m_off = off;
; 245  :                     }
; 246  :                 }
; 247  :                 t = (t >> 5) - 1;
; 248  : #endif
; 249  :                 TEST_LB(m_pos); assert(t > 0); NEED_OP(t+3-1);
; 250  :                 goto copy_match;
; 251  : #endif /* COPY_DICT */
; 252  :             }
; 253  :             else if (t >= 32)           /* a M3 match */

	cmp	rax, 32					; 00000020H
	jb	SHORT $LN28@lzo1x_deco

; 254  :             {
; 255  :                 t &= 31;

	and	eax, 31

; 256  :                 if (t == 0)

	jne	SHORT $LN27@lzo1x_deco

; 257  :                 {
; 258  :                     NEED_IP(1);
; 259  :                     while (*ip == 0)

	cmp	BYTE PTR [r10], al
	jne	SHORT $LN25@lzo1x_deco
	npad	7
$LL26@lzo1x_deco:

; 260  :                     {
; 261  :                         t += 255;
; 262  :                         ip++;

	inc	r10
	add	rax, 255				; 000000ffH
	cmp	BYTE PTR [r10], 0
	je	SHORT $LL26@lzo1x_deco
$LN25@lzo1x_deco:

; 263  :                         NEED_IP(1);
; 264  :                     }
; 265  :                     t += 31 + *ip++;

	movzx	ecx, BYTE PTR [r10]
	add	ecx, 31
	movsxd	rcx, ecx
	add	rax, rcx
	inc	r10
$LN27@lzo1x_deco:

; 266  :                 }
; 267  : #if defined(COPY_DICT)
; 268  : #if defined(LZO1Z)
; 269  :                 m_off = 1 + (ip[0] << 6) + (ip[1] >> 2);
; 270  :                 last_m_off = m_off;
; 271  : #else
; 272  :                 m_off = 1 + (ip[0] >> 2) + (ip[1] << 6);
; 273  : #endif
; 274  : #else /* !COPY_DICT */
; 275  : #if defined(LZO1Z)
; 276  :                 {
; 277  :                     lzo_uint off = 1 + (ip[0] << 6) + (ip[1] >> 2);
; 278  :                     m_pos = op - off;
; 279  :                     last_m_off = off;
; 280  :                 }
; 281  : #elif defined(LZO_UNALIGNED_OK_2) && defined(LZO_ABI_LITTLE_ENDIAN)
; 282  :                 m_pos = op - 1;
; 283  :                 m_pos -= (* (const lzo_ushortp) ip) >> 2;

	movzx	ecx, WORD PTR [r10]
	mov	r8, r11
	shr	rcx, 2
	sub	r8, rcx
	dec	r8

; 284  : #else
; 285  :                 m_pos = op - 1;
; 286  :                 m_pos -= (ip[0] >> 2) + (ip[1] << 6);
; 287  : #endif
; 288  : #endif /* COPY_DICT */
; 289  :                 ip += 2;

	add	r10, 2
	jmp	SHORT $LN17@lzo1x_deco
$LN28@lzo1x_deco:

; 290  :             }
; 291  :             else if (t >= 16)           /* a M4 match */

	cmp	rax, 16
	jb	$LN23@lzo1x_deco

; 292  :             {
; 293  : #if defined(COPY_DICT)
; 294  :                 m_off = (t & 8) << 11;
; 295  : #else /* !COPY_DICT */
; 296  :                 m_pos = op;
; 297  :                 m_pos -= (t & 8) << 11;

	mov	rcx, rax
	mov	r8, r11
	and	ecx, 8
	shl	rcx, 11
	sub	r8, rcx

; 298  : #endif /* COPY_DICT */
; 299  :                 t &= 7;

	and	eax, 7

; 300  :                 if (t == 0)

	jne	SHORT $LN22@lzo1x_deco

; 301  :                 {
; 302  :                     NEED_IP(1);
; 303  :                     while (*ip == 0)

	cmp	BYTE PTR [r10], al
	jne	SHORT $LN20@lzo1x_deco
	npad	6
$LL21@lzo1x_deco:

; 304  :                     {
; 305  :                         t += 255;
; 306  :                         ip++;

	inc	r10
	add	rax, 255				; 000000ffH
	cmp	BYTE PTR [r10], 0
	je	SHORT $LL21@lzo1x_deco
$LN20@lzo1x_deco:

; 307  :                         NEED_IP(1);
; 308  :                     }
; 309  :                     t += 7 + *ip++;

	movzx	ecx, BYTE PTR [r10]
	add	ecx, 7
	movsxd	rcx, ecx
	add	rax, rcx
	inc	r10
$LN22@lzo1x_deco:

; 310  :                 }
; 311  : #if defined(COPY_DICT)
; 312  : #if defined(LZO1Z)
; 313  :                 m_off += (ip[0] << 6) + (ip[1] >> 2);
; 314  : #else
; 315  :                 m_off += (ip[0] >> 2) + (ip[1] << 6);
; 316  : #endif
; 317  :                 ip += 2;
; 318  :                 if (m_off == 0)
; 319  :                     goto eof_found;
; 320  :                 m_off += 0x4000;
; 321  : #if defined(LZO1Z)
; 322  :                 last_m_off = m_off;
; 323  : #endif
; 324  : #else /* !COPY_DICT */
; 325  : #if defined(LZO1Z)
; 326  :                 m_pos -= (ip[0] << 6) + (ip[1] >> 2);
; 327  : #elif defined(LZO_UNALIGNED_OK_2) && defined(LZO_ABI_LITTLE_ENDIAN)
; 328  :                 m_pos -= (* (const lzo_ushortp) ip) >> 2;

	movzx	ecx, WORD PTR [r10]

; 329  : #else
; 330  :                 m_pos -= (ip[0] >> 2) + (ip[1] << 6);
; 331  : #endif
; 332  :                 ip += 2;

	add	r10, 2
	shr	rcx, 2
	sub	r8, rcx

; 333  :                 if (m_pos == op)

	cmp	r8, r11
	je	$eof_found$159

; 334  :                     goto eof_found;
; 335  :                 m_pos -= 0x4000;

	sub	r8, 16384				; 00004000H
$LN17@lzo1x_deco:

; 364  : #endif /* COPY_DICT */
; 365  :                 goto match_done;
; 366  :             }
; 367  : 
; 368  :             /* copy match */
; 369  : #if defined(COPY_DICT)
; 370  : 
; 371  :             NEED_OP(t+3-1);
; 372  :             t += 3-1; COPY_DICT(t,m_off)
; 373  : 
; 374  : #else /* !COPY_DICT */
; 375  : 
; 376  :             TEST_LB(m_pos); assert(t > 0); NEED_OP(t+3-1);
; 377  : #if defined(LZO_UNALIGNED_OK_4) || defined(LZO_ALIGNED_OK_4)
; 378  : #if !defined(LZO_UNALIGNED_OK_4)
; 379  :             if (t >= 2 * 4 - (3 - 1) && PTR_ALIGNED2_4(op,m_pos))
; 380  :             {
; 381  :                 assert((op - m_pos) >= 4);  /* both pointers are aligned */
; 382  : #else
; 383  :             if (t >= 2 * 4 - (3 - 1) && (op - m_pos) >= 4)

	cmp	rax, 6
	jb	$copy_match$158
	mov	rcx, r11
	sub	rcx, r8
	cmp	rcx, 4
	jl	$copy_match$158

; 384  :             {
; 385  : #endif
; 386  :                 COPY4(op,m_pos);

	mov	ecx, DWORD PTR [r8]

; 387  :                 op += 4; m_pos += 4; t -= 4 - (3 - 1);

	add	r11, 4
	add	r8, 4
	mov	DWORD PTR [r11-4], ecx
	sub	rax, 2
	npad	5
$LL14@lzo1x_deco:

; 388  :                 do {
; 389  :                     COPY4(op,m_pos);

	mov	ecx, DWORD PTR [r8]

; 390  :                     op += 4; m_pos += 4; t -= 4;

	sub	rax, 4
	add	r11, 4
	mov	DWORD PTR [r11-4], ecx
	add	r8, 4

; 391  :                 } while (t >= 4);

	cmp	rax, 4
	jae	SHORT $LL14@lzo1x_deco

; 392  :                 if (t > 0) do *op++ = *m_pos++; while (--t > 0);

	test	rax, rax
	je	SHORT $match_done$157
	npad	2
$LL10@lzo1x_deco:
	movzx	ecx, BYTE PTR [r8]
	inc	r11
	lea	r8, QWORD PTR [r8+1]
	mov	BYTE PTR [r11-1], cl
	dec	rax
	jne	SHORT $LL10@lzo1x_deco

; 393  :             }
; 394  :             else

	jmp	SHORT $match_done$157
$LN23@lzo1x_deco:

; 336  : #if defined(LZO1Z)
; 337  :                 last_m_off = pd((const lzo_bytep)op, m_pos);
; 338  : #endif
; 339  : #endif /* COPY_DICT */
; 340  :             }
; 341  :             else                            /* a M1 match */
; 342  :             {
; 343  : #if defined(COPY_DICT)
; 344  : #if defined(LZO1Z)
; 345  :                 m_off = 1 + (t << 6) + (*ip++ >> 2);
; 346  :                 last_m_off = m_off;
; 347  : #else
; 348  :                 m_off = 1 + (t >> 2) + (*ip++ << 2);
; 349  : #endif
; 350  :                 NEED_OP(2);
; 351  :                 t = 2; COPY_DICT(t,m_off)
; 352  : #else /* !COPY_DICT */
; 353  : #if defined(LZO1Z)
; 354  :                 t = 1 + (t << 6) + (*ip++ >> 2);
; 355  :                 m_pos = op - t;
; 356  :                 last_m_off = t;
; 357  : #else
; 358  :                 m_pos = op - 1;
; 359  :                 m_pos -= t >> 2;
; 360  :                 m_pos -= *ip++ << 2;

	movzx	ecx, BYTE PTR [r10]
	shr	rax, 2
	inc	r10
	shl	ecx, 2
	movsxd	rdx, ecx
	mov	rcx, r11
	sub	rcx, rdx
	sub	rcx, rax

; 361  : #endif
; 362  :                 TEST_LB(m_pos); NEED_OP(2);
; 363  :                 *op++ = *m_pos++; *op++ = *m_pos;

	add	r11, 2
	movzx	eax, BYTE PTR [rcx-1]
	mov	BYTE PTR [r11-2], al
	movzx	eax, BYTE PTR [rcx]
	mov	BYTE PTR [r11-1], al
$match_done$157:

; 405  : #if defined(LZO1Z)
; 406  :             t = ip[-1] & 3;
; 407  : #else
; 408  :             t = ip[-2] & 3;

	movzx	ecx, BYTE PTR [r10-2]
	and	ecx, 3

; 409  : #endif
; 410  :             if (t == 0)

	je	$LN57@lzo1x_deco
$match_next$154:

; 411  :                 break;
; 412  : 
; 413  :             /* copy literals */
; 414  : match_next:
; 415  :             assert(t > 0); assert(t < 4); NEED_OP(t); NEED_IP(t+1);
; 416  : #if 0
; 417  :             do *op++ = *ip++; while (--t > 0);
; 418  : #else
; 419  :             *op++ = *ip++;

	movzx	eax, BYTE PTR [r10]
	inc	r11
	inc	r10
	mov	BYTE PTR [r11-1], al

; 420  :             if (t > 1) { *op++ = *ip++; if (t > 2) { *op++ = *ip++; } }

	cmp	rcx, 1
	jbe	SHORT $LN1@lzo1x_deco
	movzx	eax, BYTE PTR [r10]
	inc	r11
	inc	r10
	mov	BYTE PTR [r11-1], al
	cmp	rcx, 2
	jbe	SHORT $LN1@lzo1x_deco
	movzx	eax, BYTE PTR [r10]
	inc	r11
	inc	r10
	mov	BYTE PTR [r11-1], al
$LN1@lzo1x_deco:

; 421  : #endif
; 422  :             t = *ip++;

	movzx	eax, BYTE PTR [r10]
	inc	r10
	jmp	$match$156
$eof_found$159:

; 423  :         } while (TEST_IP && TEST_OP);
; 424  :     }
; 425  : 
; 426  : #if defined(HAVE_TEST_IP) || defined(HAVE_TEST_OP)
; 427  :     /* no EOF code was found */
; 428  :     *out_len = pd(op, out);
; 429  :     return LZO_E_EOF_NOT_FOUND;
; 430  : #endif
; 431  : 
; 432  : eof_found:
; 433  :     assert(t == 1);
; 434  :     *out_len = pd(op, out);

	sub	r11, rdi
	mov	QWORD PTR [r9], r11

; 435  :     return (ip == ip_end ? LZO_E_OK :
; 436  :            (ip < ip_end  ? LZO_E_INPUT_NOT_CONSUMED : LZO_E_INPUT_OVERRUN));

	cmp	r10, rbx
	jne	SHORT $LN67@lzo1x_deco
	xor	eax, eax

; 437  : 
; 438  : 
; 439  : #if defined(HAVE_NEED_IP)
; 440  : input_overrun:
; 441  :     *out_len = pd(op, out);
; 442  :     return LZO_E_INPUT_OVERRUN;
; 443  : #endif
; 444  : 
; 445  : #if defined(HAVE_NEED_OP)
; 446  : output_overrun:
; 447  :     *out_len = pd(op, out);
; 448  :     return LZO_E_OUTPUT_OVERRUN;
; 449  : #endif
; 450  : 
; 451  : #if defined(LZO_TEST_OVERRUN_LOOKBEHIND)
; 452  : lookbehind_overrun:
; 453  :     *out_len = pd(op, out);
; 454  :     return LZO_E_LOOKBEHIND_OVERRUN;
; 455  : #endif
; 456  : }

	mov	rbx, QWORD PTR [rsp+8]
	mov	rdi, QWORD PTR [rsp+16]
	ret	0
$LN67@lzo1x_deco:
	mov	rdi, QWORD PTR [rsp+16]
	cmp	r10, rbx
	mov	rbx, QWORD PTR [rsp+8]
	mov	eax, -4
	mov	ecx, -8
	cmovb	eax, ecx
	ret	0
lzo1x_decompress ENDP
_TEXT	ENDS
END
