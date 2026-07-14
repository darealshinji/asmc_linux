
.intel_syntax noprefix

.global tqsort
.global tstrupr
.global tstrstart
.global tmemcpy
.global tmemmove
.global tmemset
.global tstrlen
.global tstrchr
.global tstrrchr
.global tstrcpy
.global tstrncpy
.global tstrcat
.global tstrcmp
.global tmemcmp
.global tmemicmp
.global tstricmp
.global tstrstr
.global _ltype


.SECTION .text
	.ALIGN	16

$_001:	mov	rax, qword ptr [rcx]
	xchg	qword ptr [rdx], rax
	mov	qword ptr [rcx], rax
	cmp	r8d, 8
	jz	$_002
	mov	rax, qword ptr [rcx+0x8]
	xchg	qword ptr [rdx+0x8], rax
	mov	qword ptr [rcx+0x8], rax
$_002:	ret

tqsort:
	mov	qword ptr [rsp+0x18], r8
	mov	qword ptr [rsp+0x20], r9
	push	rsi
	push	rdi
	push	rbx
	push	r12
	push	r13
	push	r14
	push	rbp
	mov	rbp, rsp
	sub	rsp, 1024
	xor	r14d, r14d
	cmp	edx, 1
	jbe	$_023
	lea	eax, [rdx-0x1]
	mul	dword ptr [rbp+0x50]
	mov	rsi, rcx
	lea	rax, [rcx+rax]
	mov	rdi, rax
$_003:	mov	ecx, dword ptr [rbp+0x50]
	mov	rax, rdi
	add	rax, rcx
	sub	rax, rsi
	jz	$_004
	xor	rdx, rdx
	div	rcx
	shr	rax, 1
	mul	rcx
$_004:	mov	rbx, rsi
	add	rbx, rax
	mov	rdx, rbx
	mov	rcx, rsi
	call	qword ptr [rbp+0x58]
	cmp	eax, 0
	jle	$_005
	mov	r8d, dword ptr [rbp+0x50]
	mov	rdx, rbx
	mov	rcx, rsi
	call	$_001
$_005:	mov	rdx, rdi
	mov	rcx, rsi
	call	qword ptr [rbp+0x58]
	cmp	eax, 0
	jle	$_006
	mov	r8d, dword ptr [rbp+0x50]
	mov	rdx, rdi
	mov	rcx, rsi
	call	$_001
$_006:	mov	rdx, rdi
	mov	rcx, rbx
	call	qword ptr [rbp+0x58]
	cmp	eax, 0
	jle	$_007
	mov	r8d, dword ptr [rbp+0x50]
	mov	rdx, rdi
	mov	rcx, rbx
	call	$_001
$_007:	mov	r12, rsi
	mov	r13, rdi
$_008:	mov	ecx, dword ptr [rbp+0x50]
	add	r12, rcx
	cmp	r12, rdi
	jnc	$_009
	mov	rdx, rbx
	mov	rcx, r12
	call	qword ptr [rbp+0x58]
	cmp	eax, 0
	jle	$_008
$_009:	mov	ecx, dword ptr [rbp+0x50]
	sub	r13, rcx
	cmp	r13, rbx
	jbe	$_010
	mov	rdx, rbx
	mov	rcx, r13
	call	qword ptr [rbp+0x58]
	cmp	eax, 0
	jle	$_010
	jmp	$_009

$_010:	mov	rcx, r13
	mov	rax, r12
	cmp	rcx, rax
	jnc	$_011
	jmp	$_013

$_011:	cmp	rbx, rcx
	jnz	$_012
	mov	rbx, rax
$_012:	mov	r8d, dword ptr [rbp+0x50]
	mov	rdx, rax
	call	$_001
	jmp	$_008

$_013:	mov	eax, dword ptr [rbp+0x50]
	add	r13, rax
	cmp	rbx, r13
	jnc	$_015
$_014:	mov	eax, dword ptr [rbp+0x50]
	sub	r13, rax
	cmp	r13, rbx
	jbe	$_015
	mov	rdx, rbx
	mov	rcx, r13
	call	qword ptr [rbp+0x58]
	test	eax, eax
	jnz	$_015
	jmp	$_014

$_015:	cmp	rbx, r13
	jc	$_017
$_016:	mov	eax, dword ptr [rbp+0x50]
	sub	r13, rax
	cmp	r13, rsi
	jbe	$_017
	mov	rdx, rbx
	mov	rcx, r13
	call	qword ptr [rbp+0x58]
	test	eax, eax
	jnz	$_017
	jmp	$_016

$_017:	mov	rdx, r12
	mov	rax, r13
	sub	rax, rsi
	mov	rcx, rdi
	sub	rcx, rdx
	cmp	rax, rcx
	jnc	$_020
	cmp	rdx, rdi
	jnc	$_018
	mov	ecx, r14d
	mov	qword ptr [rbp+rcx*8-0x1F0], rdx
	mov	qword ptr [rbp+rcx*8-0x3E0], rdi
	inc	r14d
$_018:	mov	rax, r13
	cmp	rsi, rax
	jnc	$_019
	mov	rdi, rax
	jmp	$_003

$_019:	jmp	$_022

$_020:	mov	rax, r13
	cmp	rsi, rax
	jnc	$_021
	mov	ecx, r14d
	mov	qword ptr [rbp+rcx*8-0x3E0], rax
	mov	qword ptr [rbp+rcx*8-0x1F0], rsi
	inc	r14d
$_021:	cmp	rdx, rdi
	jnc	$_022
	mov	rsi, rdx
	jmp	$_003

$_022:	test	r14d, r14d
	jz	$_023
	dec	r14d
	mov	ecx, r14d
	mov	rsi, qword ptr [rbp+rcx*8-0x1F0]
	mov	rdi, qword ptr [rbp+rcx*8-0x3E0]
	jmp	$_003

$_023:
	leave
	pop	r14
	pop	r13
	pop	r12
	pop	rbx
	pop	rdi
	pop	rsi
	ret

tstrupr:
	mov	rdx, rcx
$_024:	movzx	eax, byte ptr [rcx]
	test	byte ptr [r15+rax], 0x02
	jz	$_025
	and	byte ptr [rcx], 0xFFFFFFDF
$_025:	inc	rcx
	test	eax, eax
	jnz	$_024
	mov	rax, rdx
	ret

tstrstart:
	jmp	$_027

$_026:	add	rcx, 1
$_027:	movzx	eax, byte ptr [rcx]
	test	byte ptr [r15+rax], 0x08
	jnz	$_026
	xchg	rax, rcx
	ret

tmemcpy:
	push	rdi
	push	rbp
	mov	rbp, rsp
	mov	rax, rcx
	xchg	rdx, rsi
	mov	ecx, r8d
	mov	rdi, rax
	rep movsb
	mov	rsi, rdx
	leave
	pop	rdi
	ret

tmemmove:
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	mov	rax, rcx
	mov	rsi, rdx
	mov	ecx, r8d
	mov	rdi, rax
	cmp	rax, rsi
	ja	$_028
	rep movsb
	jmp	$_029

$_028:	lea	rsi, [rsi+rcx-0x1]
	lea	rdi, [rdi+rcx-0x1]
	std
	rep movsb
	cld
$_029:	leave
	pop	rdi
	pop	rsi
	ret

tmemset:
	push	rdi
	push	rbp
	mov	rbp, rsp
	mov	rdi, rcx
	mov	al, dl
	mov	rdx, rcx
	mov	ecx, r8d
	rep stosb
	mov	rax, rdx
	leave
	pop	rdi
	ret

tstrlen:
	push	rdi
	push	rbp
	mov	rbp, rsp
	mov	rdi, rcx
	mov	rax, rcx
	and	ecx, 0x03
	jz	$_031
	sub	rax, rcx
	shl	ecx, 3
	mov	edx, 4294967295
	shl	edx, cl
	not	edx
	or	edx, dword ptr [rax]
	lea	ecx, [rdx-0x1010101]
	not	edx
	and	ecx, edx
	and	ecx, 0x80808080
	jnz	$_032
$_030:	add	rax, 4
$_031:	mov	edx, dword ptr [rax]
	lea	ecx, [rdx-0x1010101]
	not	edx
	and	ecx, edx
	and	ecx, 0x80808080
	jz	$_030
$_032:	bsf	ecx, ecx
	shr	ecx, 3
	add	rax, rcx
	sub	rax, rdi
	leave
	pop	rdi
	ret

tstrchr:
	xor	eax, eax
$_033:	cmp	al, byte ptr [rcx]
	jz	$_035
	cmp	dl, byte ptr [rcx]
	jz	$_034
	inc	rcx
	jmp	$_033

$_034:	mov	rax, rcx
$_035:	ret

tstrrchr:
	xor	eax, eax
$_036:	cmp	byte ptr [rcx], 0
	jz	$_038
	cmp	dl, byte ptr [rcx]
	jz	$_037
	inc	rcx
	jmp	$_036

$_037:	mov	rax, rcx
	inc	rcx
	jmp	$_036

$_038:
	ret

tstrcpy:
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	mov	rdi, rcx
	mov	rsi, rdx
	jmp	$_040

$_039:	mov	dword ptr [rdi], eax
	add	rdi, 4
$_040:	mov	eax, dword ptr [rsi]
	add	rsi, 4
	lea	edx, [rax-0x1010101]
	not	eax
	and	edx, eax
	not	eax
	and	edx, 0x80808080
	jz	$_039
	bt	edx, 7
	mov	byte ptr [rdi], al
	jc	$_041
	bt	edx, 15
	mov	byte ptr [rdi+0x1], ah
	jc	$_041
	shr	eax, 16
	bt	edx, 23
	mov	byte ptr [rdi+0x2], al
	jc	$_041
	mov	byte ptr [rdi+0x3], ah
$_041:	mov	rax, rcx
	leave
	pop	rdi
	pop	rsi
	ret

tstrncpy:
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	mov	rdi, rcx
	mov	rsi, rcx
	mov	ecx, r8d
$_042:	test	ecx, ecx
	jz	$_043
	dec	ecx
	mov	al, byte ptr [rdx]
	mov	byte ptr [rdi], al
	add	rdx, 1
	add	rdi, 1
	test	al, al
	jnz	$_042
	rep stosb
$_043:	mov	rax, rsi
	leave
	pop	rdi
	pop	rsi
	ret

tstrcat:
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	rdi, rcx
	mov	rbx, rcx
$_044:	mov	eax, dword ptr [rdi]
	add	rdi, 4
	lea	ecx, [rax-0x1010101]
	not	eax
	and	ecx, eax
	and	ecx, 0x80808080
	jz	$_044
	bsf	ecx, ecx
	shr	ecx, 3
	lea	rdi, [rdi+rcx-0x4]
	mov	rcx, rdx
	jmp	$_046

$_045:	mov	dword ptr [rdi], eax
	add	rdi, 4
$_046:	mov	eax, dword ptr [rcx]
	add	rcx, 4
	lea	edx, [rax-0x1010101]
	not	eax
	and	edx, eax
	not	eax
	and	edx, 0x80808080
	jz	$_045
	bt	edx, 7
	mov	byte ptr [rdi], al
	jc	$_047
	bt	edx, 15
	mov	byte ptr [rdi+0x1], ah
	jc	$_047
	shr	eax, 16
	bt	edx, 23
	mov	byte ptr [rdi+0x2], al
	jc	$_047
	mov	byte ptr [rdi+0x3], ah
$_047:	mov	rax, rbx
	leave
	pop	rbx
	pop	rdi
	ret

tstrcmp:
	dec	rcx
	dec	rdx
	mov	eax, 1
$_048:	test	eax, eax
	jz	$_049
	inc	rcx
	inc	rdx
	mov	al, byte ptr [rcx]
	cmp	al, byte ptr [rdx]
	jz	$_048
	sbb	eax, eax
	sbb	eax, -1
$_049:	ret

tmemcmp:
	mov	qword ptr [rsp+0x18], r8
	push	rsi
	push	rdi
	push	rbp
	mov	rbp, rsp
	mov	rdi, rcx
	mov	rsi, rdx
	mov	ecx, dword ptr [rbp+0x30]
	xor	eax, eax
	repe cmpsb
	jz	$_050
	sbb	eax, eax
	sbb	eax, -1
$_050:	leave
	pop	rdi
	pop	rsi
	ret

tmemicmp:
	push	rbx
	push	rbp
	mov	rbp, rsp
	mov	ebx, r8d
$_051:	test	ebx, ebx
	jz	$_052
	dec	ebx
	mov	al, byte ptr [rcx+rbx]
	cmp	al, byte ptr [rdx+rbx]
	jz	$_051
	xor	al, 0x20
	cmp	al, byte ptr [rdx+rbx]
	jz	$_051
	sbb	ebx, ebx
	sbb	ebx, -1
$_052:	mov	eax, ebx
	leave
	pop	rbx
	ret

tstricmp:
	dec	rcx
	dec	rdx
	mov	eax, 1
$_053:	test	eax, eax
	jz	$_054
	inc	rcx
	inc	rdx
	mov	al, byte ptr [rcx]
	cmp	al, byte ptr [rdx]
	jz	$_053
	xor	al, 0x20
	cmp	al, byte ptr [rdx]
	jz	$_053
	xor	al, 0x20
	cmp	al, byte ptr [rdx]
	sbb	eax, eax
	sbb	eax, -1
$_054:	ret

tstrstr:
	push	rsi
	push	rdi
	push	rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	rdi, rcx
	mov	rbx, rdx
	mov	rcx, rbx
	call	tstrlen
	mov	esi, eax
	test	eax, eax
	jz	$_058
	mov	rcx, rdi
	call	tstrlen
	mov	ecx, eax
	test	eax, eax
	jz	$_058
	xor	eax, eax
	dec	rsi
$_055:	mov	al, byte ptr [rbx]
	repne scasb
	mov	al, 0
	jnz	$_058
	test	esi, esi
	jz	$_057
	cmp	ecx, esi
	jc	$_058
	mov	edx, esi
$_056:	mov	al, byte ptr [rbx+rdx]
	cmp	al, byte ptr [rdi+rdx-0x1]
	jnz	$_055
	dec	edx
	jnz	$_056
$_057:	lea	rax, [rdi-0x1]
$_058:	leave
	pop	rbx
	pop	rdi
	pop	rsi
	ret


.SECTION .data
	.ALIGN	16


.macro dup num type
.rept  \num
.byte  \type
.endr
.endm


/* _UPPER   = 0x01  upper case letter */
/* _LOWER   = 0x02  lower case letter */
/* _DIGIT   = 0x04  digit[0-9] */
/* _SPACE   = 0x08  tab, carriage return, newline, vertical tab or form feed */
/* _PUNCT   = 0x10  punctuation character */
/* _CONTROL = 0x20  control character */
/* _LABEL   = 0x40  _UPPER + _LOWER + '@' + '_' + '$' + '?' */
/* _HEX     = 0x80  hexadecimal digit */

_ltype:
    DUP  9, 0x20            /* 00-08 */
    DUP  5, 0x20+0x08       /* 09-0D */
    DUP 18, 0x20            /* 0E-1F */
    .byte   0x08            /* 20 SPACE */
    DUP  3, 0x10            /* 21-23 (!-#) */
    .byte   0x10+0x40       /* 24 $ */
    DUP 11, 0x10            /* 25-2F (%-/) */
    DUP 10, 0x04+0x80       /* 30-39 (0-9) */
    DUP  5, 0x10            /* 3A-3E :;<=> */
    DUP  2, 0x10+0x40       /* 3F-40 ?@ */
    DUP  6, 0x01+0x40+0x80  /* 41-46 (A-F) */
    DUP 20, 0x01+0x40       /* 47-5A (G-Z) */
    DUP  4, 0x10            /* 5B-5E [\]^ */
    .byte   0x10+0x40       /* 5F _ */
    .byte   0x10            /* 60 ` */
    DUP  6, 0x02+0x40+0x80  /* 61-66 (a-f) */
    DUP 20, 0x02+0x40       /* 67-7A (g-z) */
    DUP  4, 0x10            /* 7B-7E */
    .byte   0x20            /* 7F */
    .zero   128 * 1         /* and the rest are 0... */


.att_syntax prefix
