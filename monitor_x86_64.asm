; DavydovMA 2013040600 {
%ifndef	ASM_MONITOR_X86_64	; ASM_MONITOR_X86_64 {
%define	ASM_MONITOR_X86_64

%define	ASM_MONITOR_X86_64_FILE		"monitor_x86_64.asm"
%define	ASM_MONITOR_X86_64_NAME		"monitor_x86_64"
%define	ASM_MONITOR_X86_64_VERSION	"20.01"
%define	ASM_MONITOR_X86_64_COPYRIGHT	"Copyright 1990-2019"
%define	ASM_MONITOR_X86_64_AUTHOR	"DavydovMA"
%define	ASM_MONITOR_X86_64_URL		"http://domain"
%define	ASM_MONITOR_X86_64_EMAIL	"dev-asm@domain"

BITS 64

; ------------- ---- ------
; block:	define
; rem:		+ need
; date:		2020-01-12
;
%define		_libasm_hex_04b
%define		_libasm_hex_08b
; off	%define		_libasm_hex_12b
%define		_libasm_hex_16b
; off	%define		_libasm_hex_20b
; off	%define		_libasm_hex_24b
; off	%define		_libasm_hex_28b
; off	%define		_libasm_hex_32b
; off	%define		_libasm_hex_32bs
; off	%define		_libasm_hex_08m
; off	%define		_libasm_hex_16m
; off	%define		_libasm_hex_32m
; off	%define		_libasm_hex_64m
; off	%define		_libasm_hex_80m
; off	%define		_libasm_hex_128m
; off	%define		_libasm_hex_256m
; off	%define		_libasm_hex_512m
; off	%define		_libasm_hex_128l
; off	%define		_libasm_efi_all
%define		_libasm_efi_input_reset
%define		_libasm_efi_input_read_key
;)	%define		_libasm_efi_simple_text_input_protocol
; off	%define		_libasm_efi_text_reset
%define		_libasm_efi_text_string
; off	%define		_libasm_efi_text_test_string
; off	%define		_libasm_efi_text_query_mode
; off	%define		_libasm_efi_text_set_mode
%define		_libasm_efi_text_set_attribute
%define		_libasm_efi_text_clear_screen
; off	%define		_libasm_efi_text_set_cursor_position
%define		_libasm_efi_text_enable_cursor
;)	%define		_libasm_efi_simple_text_output_protocol
;)	%define		_libasm_efi_simple_protocol
;)	%define		_libasm_efi_scrcxrax
; off	%define		_libasm_efi_strerror
%define		_libasm_efi_init
;
; ------------- ---- ------
; block:	EQU
; rem:
; date:		2020-01-11
;
libasm_prn_ascii	equ	libasm_efl_prn
libasm_prn_ascii_msg	equ	libasm_efl_prn_msg
BUFFER_SH_SIZE		equ	8*9
COLOR_DEFAULT		equ	0x07
COLOR_TITLE		equ	0x0c
%define	LIBASM_EFI_X86_64_RC	RBP
%define	R_ADDR_RSP		R10
%define	R_ADDR_BUF		R11
%define	R_FREE_0		R12
%define	R_FREE_1		R13
%define	R_FREE_2		R14
;
; ------------- ---- ------
; soft:		monitor {
; rem:		
; date:		2020-01-12
; in:
; out:
;
global	_start
section	.text
_start:
	push	r15
	push	r14
	push	r13
	push	r12
	push	r11
	push	r10
	push	r9
	push	r8
	push	rbp
	push	rdi
	push	rsi
	push	rdx
	push	rcx
	push	rbx
	push	rax	; +8
	pushfq		; 0
	mov	R_ADDR_RSP, rsp		; R_ADDR_RSP
	sub	rsp, BUFFER_SH_SIZE	; R_ADDR_BUF alloc {
	mov	R_ADDR_BUF, rsp		; } R_ADDR_BUF alloc
	call	libasm_efi_init		; LIBASM_EFI_X86_64_RC = addr_code_begin
; SH
.j_sh_init:				; sh: init
	xor	rdx, rdx
	inc	rdx
	call	libasm_efl_cls
	xor	rdx, rdx
	mov	dl, COLOR_TITLE
	call	libasm_efi_text_set_attribute
	mov	rax, msg_title		; sh: print_title {
	call	libasm_efl_prn_msg
	xor	rdx, rdx
	mov	dl, COLOR_DEFAULT
	call	libasm_efi_text_set_attribute
	mov	rax, msg_title_2
.j_sh_wait_msg:
	call	libasm_efl_prn_msg		; } sh: print_title_2
.j_sh_wait:				; sh: --> {
	mov	rax, msg_shell
	call	libasm_efl_prn_msg		; } sh: -->
; BUFFER edit
	xor	rbx, rbx
	mov	bl, BUFFER_SH_SIZE	; buffer_edit {
	call	f_buffer_edit		; } buffer_edit
; BUFFER read
;	nop				; buffer_read {
	mov	rsi, R_ADDR_BUF		; buffer_index
	cld
	lodsb				; READ cmd
;DUMP
	cmp	al, 'D'			; found: DUMP
	jz	.j_mode_dump
	cmp	al, 'd'			; found: DUMP
	jnz	.j_cmd_dump_next
.j_mode_dump:				; mode: dump {
	call	f_buffer_addr		; RBX: get ADDR
	or	rax, rax
	jnz	.j_sh_wait_msg		; --> ERROR: *
.j_mode_dump_show:
;	nop				; dump_show {
	xor	bl, bl			; ADDR 00 shift
.j_mode_dump_not00:
	test	bl, 0x0f
	jnz	.j_mode_dump_not0
	call	f_prn_msg_nl		; addr_x0
	mov	rax, rbx
	call	f_prn_hex_rax
.j_mode_dump_not0:			; byte
	push	rbx
;	nop				; dumpline {
	mov	ah, ' '
	mov	al, ':'
	call	libasm_efl_prn
.j_dumpline_11:				; byte
	mov	al, bl
	and	al, 0x1
	jnz	.j_dumpline_12
	mov	al, ah
	call	libasm_efl_prn
.j_dumpline_12:
	mov	al, [ rbx ]
	call	libasm_hex_08b
	inc	rbx
	mov	al, bl
	and	al, 0xf
	jnz	.j_dumpline_11
;	nop				; } dumpline
	pop	rbx
;	nop				; aumpline {
	mov	al, ' '
	call	libasm_efl_prn
	mov	al, '|'
	call	libasm_efl_prn
.j_aumpline_01:				; byte
	mov	al, [ rbx ]
	cmp	al, 20h
	jb	.j_aumpline_02		; <
	cmp	al, 7fh
	jb	.j_aumpline_03		; <
.j_aumpline_02:
	mov	al, '.'
.j_aumpline_03:
	call	libasm_efl_prn
	inc	rbx
	mov	al, bl
	and	al, 0xf
	jnz	.j_aumpline_01
	mov	al, '|'
	call	libasm_efl_prn
;	nop				; } aumpline
	or	bl, bl
	jnz	.j_mode_dump_not00
;	nop				; } dump_show
	call	libasm_efl_key_reset
	call	libasm_efl_key_wait	;
	cmp	edx, 0x17		; key: ESC
	jz	.j_mode_dump_end
	cmp	edx, 0x2e0000		; key '.'
	jnz	.j_mode_dump_show
.j_mode_dump_end:
	jmp	.j_sh_wait		; -->
.j_cmd_dump_next:			; } mode: dump
; MODIFY
	cmp	al, 'M'			; found: MODIFY
	jz	.j_mode_modify
	cmp	al, 'm'			; found: MODIFY
	jnz	.j_cmd_modify_next
.j_mode_modify:				; mode: modify {
	call	f_buffer_addr		; RBX: get ADDR
	or	rax, rax
	jnz	.j_sh_wait_msg		; --> ERROR: *
.j_mode_modify_begin:
	mov	rdi, rbx		; addr_index
	mov	R_FREE_0, msg_dd	; save msg_dd
.j_mode_modify_next:
	call	f_prn_msg_nl		; print addr
	mov	rax, rdi
	call	f_prn_hex_rax
	mov	rax, R_FREE_0		; load msg_dd
	call	libasm_efl_prn_msg
	mov	al, [ rdi ]		; FROM MEMORY
	call	libasm_hex_08b		; print
	mov	rax, R_FREE_0		; load msg_dd
	call	libasm_efl_prn_msg
	xor	rbx, rbx		; buffer size {
	mov	bl, 2			; } buffer_size
	call	f_buffer_edit		; RBX: ADDR_BUF
	mov	rsi, rbx		; RSI: ADDR_BUF
	call	f_buffer_addr		; RBX: BYTE
	jnc	.j_mode_modify_skip
	or	rax, rax
	mov	rax, msg_nl		; NL
	jnz	.j_sh_wait_msg		; -->
	mov	[ rdi ], bl		; SAVE
	mov	rax, R_FREE_0		; load msg_dd
	call	libasm_efl_prn_msg
	mov	al, bl			; AL: BYTE
	call	libasm_hex_08b		; print byte_save
	mov	rax, R_FREE_0		; load msg_dd
	call	libasm_efl_prn_msg
	mov	al, [ rdi ]		; LOAD
	call	libasm_hex_08b		; print byte_check
.j_mode_modify_skip:
	inc	rdi
	jmp	.j_mode_modify_next
.j_cmd_modify_next:			; } mode: modify
; FILL
	cmp	al, 'F'			; found: FILL
	jz	.j_mode_fill
	cmp	al, 'f'			; found: FILL
	jnz	.j_cmd_fill_next
.j_mode_fill:				; mode: fill {
	call	f_buffer_addr		; RBX: get ADDR_1
	or	rax, rax
	jnz	.j_sh_wait_msg		; --> ERROR: *
	cmp	[ rsi - 1 ], al		; check last byte as end {
	mov	rax, msg_error_shaddr	; ERROR: addr_incorrect
	jz	.j_sh_wait_msg		; } check last byte as end
	mov	R_FREE_0, rax		; save_addr_incorrect
	mov	rdi, rbx		; RDI: = ADDR_1
	call	f_buffer_addr		; RBX: get ADDR_2
	or	rax, rax
	jnz	.j_sh_wait_msg		; --> ERROR: *
	cmp	[ rsi - 1 ], al		; check last byte as end {
	mov	rax, msg_error_shfill	; ERROR: fill_incorrect
	jz	.j_sh_wait_msg		; --> } check last byte as end
	mov	R_FREE_1, rax		; save_fill_incorrect
	cmp	rdi, rbx		; ADDR_1  vs  ADDR_2
	mov	rax, R_FREE_0		; ERROR: addr_incorrect
	jnbe	.j_sh_wait_msg		; > -->
	mov	rcx, rbx		; RCX: = ADDR_2
	call	f_buffer_addr		; RBX: get FILL
	or	rax, rax
	mov	rax, R_FREE_1		; ERROR: fill_incorrect
	jnz	.j_sh_wait_msg		; -->
	call	f_prn_msg_nl		; print ADDR_1 {
	mov	rax, rdi
	call	f_prn_hex_rax		; } print ADDR_1
	mov	rax, rcx
	call	f_prn_hex_rax_dd	; } print ADDR_2
	mov	rax, msg_dd		; print FILL {
	call	libasm_efl_prn_msg
	mov	al, bl			; AL: FILL
	call	libasm_hex_08b		; } print FILL
	cld				; FILL {
	sub	rcx, rdi		; RCX: count ADDR_1 - ADDR_2
	inc	rcx			; ++ byte_00
rep	stosb				; } FILL
	jmp	.j_sh_wait		; -->
.j_cmd_fill_next:			; } mode: fill
; TRANSFER
	cmp	al, 'T'			; found: TRANSFER
	jz	.j_mode_transfer
	cmp	al, 't'			; found: TRANSFER
	jnz	.j_cmd_transfer_next
.j_mode_transfer:			; mode: transfer {
	call	f_buffer_addr		; RBX: get ADDR_1
	or	rax, rax
	jnz	.j_sh_wait_msg		; --> ERROR: *
	cmp	[ rsi - 1 ], al		; check last byte as end {
	mov	rax, msg_error_shaddr	; ERROR: addr_incorrect
	jz	.j_sh_wait_msg		; } check last byte as end
	mov	R_FREE_0, rax		; save_addr_incorrect
	mov	rdi, rbx		; RDI: = ADDR_1
	call	f_buffer_addr		; RBX: get ADDR_2
	or	rax, rax
	jnz	.j_sh_wait_msg		; ERROR: *
	cmp	[ rsi - 1 ], al		; check last byte as end {
	mov	rax, R_FREE_0		; ERROR: addr_incorrect
	jz	.j_sh_wait_msg		; } check last byte as end
	cmp	rdi, rbx		; ADDR_1  vs  ADDR_2
	mov	rax, R_FREE_0		; ERROR: addr_incorrect
	jnbe	.j_sh_wait_msg		; > -->
	mov	rcx, rbx		; RCX: = ADDR_2
	call	f_buffer_addr		; RBX: get ADDR_3
	or	rax, rax
	mov	rax, r10		; ERROR: addr_incorrect
	jnz	.j_sh_wait_msg		; -->
	call	f_prn_msg_nl		; print ADDR_1 {
	mov	rax, rdi
	call	f_prn_hex_rax		; } print ADDR_1
	mov	rax, rcx
	call	f_prn_hex_rax_dd	; } print ADDR_2
	mov	rax, rbx
	call	f_prn_hex_rax_dd	; } print ADDR_3
	cld				; TRANSFER {
	sub	rcx, rdi		; RCX: count ADDR_2 - ADDR_1
	inc	rcx			; ++ byte_00
	mov	rsi, rdi		; ADDR_1 - source
	mov	rdi, rbx		; ADDR_3 - destination
rep	movsb				; } TRANSFER
	jmp	.j_sh_wait		; -->
.j_cmd_transfer_next:			; } mode: transfer
; Search Ascii
	cmp	al, 'A'			; found: Search Ascii
	jz	.j_mode_sa
	cmp	al, 'a'			; found: Search Ascii
	jnz	.j_cmd_sa_next
.j_mode_sa:				; mode: sa {
	call	f_buffer_addr		; RBX: get ADDR_1
	or	rax, rax
	jnz	.j_sh_wait_msg		; --> ERROR: *
	cmp	[ rsi - 1 ], al		; check last byte as end {
	mov	rax, msg_error_shaddr	; ERROR: addr_incorrect
	jz	.j_sh_wait_msg		; --> } check last byte as end
	mov	R_FREE_0, rax		; save_addr_incorrect
	mov	rdi, rbx		; RDI: = ADDR_1
	call	f_buffer_addr		; RBX: get ADDR_2
	or	rax, rax
	jnz	.j_sh_wait_msg		; --> ERROR: *
	cmp	[ rsi - 1 ], al		; check last byte as end {
	mov	rax, msg_error_shsain	; ERROR: text_incorrect
	jz	.j_sh_wait_msg		; --> } check last byte as end
	xor	cl, cl
	cmp	[ rsi ], cl		; check last byte as end {
;)	mov	rax, msg_error_shsain	; ERROR: text_incorrect; see up
	jz	.j_sh_wait_msg		; --> } check last byte as end
	cmp	rdi, rbx		; ADDR_1  vs  ADDR_2
	mov	rax, R_FREE_0		; ERROR: addr_incorrect
	jnb	.j_sh_wait_msg		; >= -->
;	nop				; RBX: = ADDR_2
	mov	rdx, rsi		; RDX: = TEXT
	call	f_prn_msg_nl		; print ADDR_1 {
	mov	rax, rdi
	call	f_prn_hex_rax		; } print ADDR_1
	mov	rax, rbx
	call	f_prn_hex_rax_dd	; } print ADDR_2
	mov	rdx, rsi
	mov	rax, msg_dd		; print [TEXT] {
	call	libasm_efl_prn_msg
	mov	al, '['
	call	libasm_efl_prn
	xor	rcx, rcx		; RCX: = text_length
.j_sa_text:				; print TEXT[] & count {
	lodsb
	call	libasm_efl_prn
	inc	rcx
	or	al, al
	jnz	.j_sa_text		; } print TEXT[] & count
	dec	rcx
.j_sa_from_sb:
	mov	al, ']'
	call	libasm_efl_prn		; } print [TEXT]
	sub	rbx, rcx		; ADDR_2 - text_length
	cmp	rdi, rbx		; ADDR_1  vs  ADDR_2 - text_length
	mov	rax, msg_error_shsawow	; ERROR: Wow...
	jnbe	.j_sh_wait_msg		; --> ERROR: Wow...
	mov	rsi, rdx
.j_sa_cmpsb:
	mov	R_FREE_0, rsi
	mov	R_FREE_1, rdi
	mov	R_FREE_2, rcx
repz	cmpsb
	mov	rcx, R_FREE_2
	mov	rdi, R_FREE_1
	mov	rsi, R_FREE_0
	jnz	.j_no			; ==
.j_yes:
	call	f_prn_msg_nl		; print addr_found {
	mov	rax, rdi
	call	f_prn_hex_rax		; } print addr found
	call	libasm_efl_key		; key: ESC-Break {
	cmp	edx, 0x17
	jz	.j_mode_sa_end		; } key: ESC-Break
.j_no:
	inc	rdi
	cmp	rdi, rbx		; ADDR_1++  vs  ADDR_2
	jbe	.j_sa_cmpsb		; <=
.j_mode_sa_end:
	jmp	.j_sh_wait		; --> } mode: sa
.j_cmd_sa_next:				; } mode: Search Ascii
; Search Byte
	cmp	al, 'B'			; found: Search Byte
	jz	.j_mode_sb
	cmp	al, 'b'			; found: Search Byte
	jnz	.j_cmd_sb_next
.j_mode_sb:				; mode: sb {
	call	f_buffer_addr		; RBX: get ADDR_1
	or	rax, rax
	jnz	.j_sh_wait_msg		; --> ERROR: *
	cmp	[ rsi - 1 ], al		; check last byte as end {
	mov	rax, msg_error_shaddr	; ERROR: addr_incorrect
	jz	.j_sh_wait_msg		; --> } check last byte as end
	mov	R_FREE_0, rax		; save_addr_incorrect
	mov	rdi, rbx		; RDI: = ADDR_1
	call	f_buffer_addr		; RBX: get ADDR_2
	or	rax, rax
	jnz	.j_sh_wait_msg		; --> ERROR: *
	cmp	[ rsi - 1 ], al		; check last byte as end {
	mov	rax, msg_error_shsbin	; ERROR: Byte incorrect
	jz	.j_sh_wait_msg		; --> } check last byte as end
	xor	cl, cl
	cmp	[ rsi ], cl		; check last byte as end {
;)	mov	rax, msg_error_shsbin	; ERROR: Byte incorrect; see up
	mov	R_FREE_1, rax		; save_byte_incorrect
	jz	.j_sh_wait_msg		; --> } check last byte as end
	cmp	rdi, rbx		; ADDR_1  vs  ADDR_2
	mov	rax, R_FREE_0		; ERROR: Addr incorrect
	jnb	.j_sh_wait_msg		; >= -->
	mov	rdx, rbx		; RDX: = ADDR_2
	call	f_prn_msg_nl		; print ADDR_1 {
	mov	rax, rdi
	call	f_prn_hex_rax		; } print ADDR_1
	mov	rax, rdx
	call	f_prn_hex_rax_dd	; } print ADDR_2
	mov	rax, msg_dd		; print [BYTES] {
	call	libasm_efl_prn_msg
	mov	al, '['
	call	libasm_efl_prn
	xor	rcx, rcx		; RCX: = bytes_length
	mov	R_FREE_2, R_ADDR_BUF		; R10 = buffer_index_out {
.j_sb_text:				; print text & count {
	call	f_buffer_addr		; RBX: BYTE
	jnc	.j_sb_text_end		; 0 - nothing
	or	rax, rax
	mov	rax, R_FREE_1		; ERROR: Byte incorrect
	jnz	.j_sh_wait_msg		; -->; see up
	mov	[ R_FREE_2 ], bl
	inc	R_FREE_2
	inc	rcx
	mov	al, bl
	call	libasm_hex_08b
	jmp	.j_sb_text
.j_sb_text_end:				; } print bytes & count
	mov	rbx, rdx		; set: RBX - ADDR_2
	mov	rdx, R_ADDR_BUF		; set: RDX - addr_buffer_out {
;	nop				; set: RDI - ADDR_1
;	nop				; set: RCX - length_bytes
	jmp	.j_sa_from_sb		; EsTaFeTa to sa
;)	.j_mode_sb_end:
;)	jmp	.j_sh_wait		; --> } mode: sb
.j_cmd_sb_next:				; } mode: Search Byte
; RUN
	cmp	al, 'R'			; found: RUN
	jz	.j_mode_run
	cmp	al, 'r'			; found: RUN
	jnz	.j_cmd_run_next
.j_mode_run:				; mode: run {
	call	f_buffer_addr		; RBX: get addr_1
	or	rax, rax
	jnz	.j_sh_wait_msg		; --> ERROR *
	mov	rdi, rbx
	cmp	[ rsi - 1 ], al		; check last byte as end {
;	nop				; RAX = 00; see up
	jz	.j_mode_run_call	; } check last byte as end
	call	f_buffer_addr		; RBX: get rax_in_run
	or	rax, rax
	jnz	.j_sh_wait_msg		; --> ERROR *
	mov	rax, rbx		; rax_in
.j_mode_run_call:
;	nop				; RUN {
	push	LIBASM_EFI_X86_64_RC
	push	R_ADDR_RSP
	push	R_ADDR_BUF
; off	push	r15
; off	push	r14
; of	push	r13
; off	push	r12
; off	push	r11
; off	push	r10
; off	push	r9
; off	push	r8
; off	push	rbp
; off	push	rdi
; off	push	rsi
; off	push	rdx
; off	push	rcx
; off	push	rbx
; IN	push	rax
; off	pushfq
	mov	rcx, EFI_HANDLE_INIT
	add	rcx, LIBASM_EFI_X86_64_RC
	mov	rcx, [ rcx ]
	mov	rdx, EFI_SYSTEM_TABLE_INIT
	add	rdx, LIBASM_EFI_X86_64_RC
	mov	rdx, [ rdx ]
	call	rdi			; <-- RUN
; off	popfq
; OUT	pop	rax
; off	pop	rbx
; off	pop	rcx
; off	pop	rdx
; off	pop	rsi
; off	pop	rdi
; off	pop	rbp
; off	pop	r8
; off	pop	r9
; off	pop	r10
; off	pop	r11
; off	pop	r12
; off	pop	r13
; off	pop	r14
; off	pop	r15
	pop	R_ADDR_BUF
	pop	R_ADDR_RSP
	pop	LIBASM_EFI_X86_64_RC
;	nop				; } RUN
	push	rax			; print errno {
	mov	rax, msg_error_shrun
	call	libasm_efl_prn_msg
	pop	rax
	call	f_prn_hex_rax		; } print errno
.j_mode_run_end:
	jmp	.j_sh_wait		; -->
.j_cmd_run_next:			; } mode: run
; CLS
	cmp	al, 'C'			; found: CLS
	jz	.j_mode_cls
	cmp	al, 'c'			; found: CLS
	jnz	.j_cmd_cls_next
.j_mode_cls:				; mode: cls {
	call	f_buffer_addr		; get color
	jnc	.j_mode_cls_def
	or	rax, rax
	jz	.j_mode_color
	mov	bl, COLOR_DEFAULT
.j_mode_color:
	xor	rdx, rdx
	mov	dl, bl
	call	libasm_efi_text_set_attribute
.j_mode_cls_def:
	call	libasm_efl_cls
	jmp	.j_sh_wait		; -->
.j_cmd_cls_next:			; } mode: cls
; INFO
	cmp	al, 'I'			; found: INFO
	jz	.j_mode_info
	cmp	al, 'i'			; found: INFO
	jnz	.j_cmd_info_next
.j_mode_info:				; mode: info {
	lodsb
	or	al, al
	jnz	.j_cmd_error
	mov	rax, msg_info_beg		; ADDR_BEGIN {
	call	libasm_efl_prn_msg
	mov	rax, LIBASM_EFI_X86_64_RC
	call	f_prn_hex_rax_dd		; } ADDR_BEGIN
	mov	rax, msg_info_end		; ADDR_END {
	call	libasm_efl_prn_msg
	mov	rax, ADDR_END
	dec	rax				; correct o_O
	add	rax, LIBASM_EFI_X86_64_RC
	call	f_prn_hex_rax_dd		; } ADDR_END
	mov	rax, msg_info_rflags		; RFLAGS {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 0 ]
	call	f_prn_hex_rax_dd		; RFLAGS
	mov	rax, msg_info_cs		; CS {
	call	libasm_efl_prn_msg
	mov	ax, cs
	call	libasm_hex_16b			; } CS
	mov	rax, msg_info_ds		; DS {
	call	libasm_efl_prn_msg
	mov	ax, ds
	call	libasm_hex_16b			; } DS
	mov	rax, msg_info_rip		; RIP {
	call	libasm_efl_prn_msg
	mov	rax, LIBASM_EFI_X86_64_RC
	call	f_prn_hex_rax_dd		; } RIP
	mov	rax, msg_info_es		; ES {
	call	libasm_efl_prn_msg
	mov	ax, es
	call	libasm_hex_16b			; } ES
	mov	rax, msg_info_ss		; SS {
	call	libasm_efl_prn_msg
	mov	ax, ss
	call	libasm_hex_16b			; } SS
	mov	rax, msg_info_fs		; FS {
	call	libasm_efl_prn_msg
	mov	ax, fs
	call	libasm_hex_16b			; } FS
	mov	rax, msg_info_rsp		; RSP {
	call	libasm_efl_prn_msg
	mov	rax, R_ADDR_RSP
	call	f_prn_hex_rax_dd		; } RSP
	mov	rax, msg_info_gs		; GS {
	call	libasm_efl_prn_msg
	mov	ax, gs
	call	libasm_hex_16b			; } GS
	mov	rax, msg_info_rbp		; RBP {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 7 ]
	call	f_prn_hex_rax_dd		; } RBP
	mov	rax, msg_info_rax		; RAX {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 1 ]
	call	f_prn_hex_rax_dd		; } RAX
	mov	rax, msg_info_rbx		; RBX {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 2 ]
	call	f_prn_hex_rax_dd		; } RBX
	mov	rax, msg_info_rcx		; RCX {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 3 ]
	call	f_prn_hex_rax_dd		; } RCX
	mov	rax, msg_info_rdx		; RDX {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 4 ]
	call	f_prn_hex_rax_dd		; } RDX
	mov	rax, msg_info_rsi		; RSI {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 5 ]
	call	f_prn_hex_rax_dd		; } RSI
	mov	rax, msg_info_rdi		; RDI {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 6 ]
	call	f_prn_hex_rax_dd		; } RDI
	mov	rax, msg_info_r8		; R8 {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 8 ]
	call	f_prn_hex_rax_dd		; } R8
	mov	rax, msg_info_r9		; R9 {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 9 ]
	call	f_prn_hex_rax_dd		; } R9
	mov	rax, msg_info_r10		; R10 {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 10 ]
	call	f_prn_hex_rax_dd		; } R10
	mov	rax, msg_info_r11		; R11 {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 11 ]
	call	f_prn_hex_rax_dd		; } R11
	mov	rax, msg_info_r12		; R12 {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 12 ]
	call	f_prn_hex_rax_dd		; } R12
	mov	rax, msg_info_r13		; R13 {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 13 ]
	call	f_prn_hex_rax_dd		; } R13
	mov	rax, msg_info_r14		; R14 {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 14 ]
	call	f_prn_hex_rax_dd		; } R14
	mov	rax, msg_info_r15		; R15 {
	call	libasm_efl_prn_msg
	mov	rax, [ R_ADDR_RSP + 8 * 15 ]
	call	f_prn_hex_rax_dd		; } R15
	jmp	.j_sh_wait			; -->
.j_cmd_info_next:			; } mode: info
; HELP
	cmp	al, '?'			; found: HELP
	jz	.j_mode_help
	cmp	al, 'H'			; found: HELP
	jz	.j_mode_help
	cmp	al, 'h'			; found: HELP
	jnz	.j_cmd_help_next
.j_mode_help:				; mode: help {
	lodsb
	or	al, al
	jnz	.j_cmd_error
	mov	rax, msg_mode_help
	jmp	.j_sh_wait_msg		; --> *
.j_cmd_help_next:			; } mode: help
; QUIT
	cmp	al, 'Q'			; found: QUIT
	jz	.j_mode_quit
	cmp	al, 'q'			; found: QUIT
	jnz	.j_cmd_quit_next
.j_mode_quit:				; mode: quit {
	lodsb
	or	al, al
	jz	.j_mode_quit_end
.j_cmd_quit_next:			; } mode: quit
; COMMAND_ERROR
.j_cmd_error:				; found: END
	mov	rax, msg_error_shcnf	; ERROR: Command not found
	jmp	.j_sh_wait_msg		; --> *
;	nop				; } buffer_read
; QUIT_END
.j_mode_quit_end:			; mode: quit_end {
	mov	rax, msg_mode_quit	; sh: quit_pak{
	call	libasm_efl_prn_msg
	call	libasm_efl_key_wait	; } sh: quit_pak
	call	libasm_efl_cls
;	nop				; } mode: quit_end
; END
	mov	rsp, R_ADDR_RSP
;ret_pop_all_rax_00:
	popfq
	pop	rax
	pop	rbx
	pop	rcx
	pop	rdx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r8
	pop	r9
	pop	r10
	pop	r11
	pop	r12
	pop	r13
	pop	r14
	pop	r15
;ret_rax_00:
	xor	rax, rax
;ret:
	ret				; exit to OS
	hlt
;	} monitor

; off	GPLv3+:				; GPLv3+ {
	db	"DavydovMA GPLv3+"	; } GPLv3+

; ------------- ---- ------
; function:	libasm_efl_cls {
; rem:		clear screen
; date:		2010-01-12
; in:
; out:
;
; off	section .data
; off	section .bss
section	.text
libasm_efl_cls:
	push	LIBASM_EFI_X86_64_RC
	push	R_ADDR_RSP
	push	R_ADDR_BUF
;	push	r15
;)	push	r14
;)	push	r13
;)	push	r12
;)	push	r11
;)	push	r10
;)	push	r9
;	push	r8
;	push	rbp
;)	push	rdi
;)	push	rsi
	push	rdx
;)	push	rcx
;)	push	rbx
;.!.	push	rax
;.!.	pushfq
	xor	rdx, rdx
	push	rdx
	call	libasm_efi_text_enable_cursor
	call	libasm_efi_text_clear_screen
	pop	rdx
	inc	rdx
	call	libasm_efi_text_enable_cursor
;.!.	popfq
;.!.	pop	rax
;)	pop	rbx
;)	pop	rcx
	pop	rdx
;)	pop	rsi
;)	pop	rdi
;	pop	rbp
;	pop	r8
;)	pop	r9
;)	pop	r10
;)	pop	r11
;)	pop	r12
;)	pop	r13
;)	pop	r14
;	pop	r15
	pop	R_ADDR_BUF
	pop	R_ADDR_RSP
	pop	LIBASM_EFI_X86_64_RC
	ret
;	} libasm_efl_cls
; ------------- ---- ------
; function:	libasm_efl_prn {
; rem:		print byte
; date:		2010-01-11
; in:
;	al	: byte
; out:
;
; off	section .data
; off	section .bss
section	.text
libasm_efl_prn:
	push	LIBASM_EFI_X86_64_RC
	push	R_ADDR_RSP
	push	R_ADDR_BUF
;	push	r15
;)	push	r14
;)	push	r13
;)	push	r12
;)	push	r11
;)	push	r10
;)	push	r9
;	push	r8
;	push	rbp
;)	push	rdi
;)	push	rsi
	push	rdx
;)	push	rcx
;)	push	rbx
	push	rax
	pushfq
	xor	rdx, rdx			; buffer_init {
	mov	dl, al
	push	rdx
	mov	rdx, rsp			; } buffer_init
	call	libasm_efi_text_string
	pop	rdx				; buffer_delete
	popfq
	pop	rax
;)	pop	rbx
;)	pop	rcx
	pop	rdx
;)	pop	rsi
;)	pop	rdi
;	pop	rbp
;	pop	r8
;)	pop	r9
;)	pop	r10
;)	pop	r11
;)	pop	r12
;)	pop	r13
;)	pop	r14
;	pop	r15
	pop	R_ADDR_BUF
	pop	R_ADDR_RSP
	pop	LIBASM_EFI_X86_64_RC
	ret
;	} libasm_efl_prn
; ------------- ---- ------
; function:	libasm_efl_prn_msg {
; rem:		print message
; date:		2020-01-06
; in:
;	rax	: addr message
; out:
;
; off	section .data
; off	section .bss
section	.text
libasm_efl_prn_msg:
	push	rbx
	push	rax
	pushfq
	add	rax, LIBASM_EFI_X86_64_RC
	mov	rbx, rax
.j_next:
	mov	al, [ rbx ]
	inc	rbx
	call	libasm_efl_prn
	or	al, al
	jnz	.j_next
	popfq
	pop	rax
	pop	rbx
	ret
;	} libasm_efl_prn_msg
; ------------- ---- ------
; function:	libasm_efl_key_reset {
; rem:		key reset
; date:		2010-01-12
; in:
; out:
;
; off	section .data
; off	section .bss
section	.text
libasm_efl_key_reset:
	push	LIBASM_EFI_X86_64_RC
	push	R_ADDR_RSP
	push	R_ADDR_BUF
;	push	r15
;)	push	r14
;)	push	r13
;)	push	r12
;)	push	r11
;)	push	r10
;)	push	r9
;	push	r8
;	push	rbp
;)	push	rdi
;)	push	rsi
	push	rdx
;)	push	rcx
;)	push	rbx
;.!.	push	rax
;.!.	pushfq
	xor	rdx, rdx
	inc	rdx
	call	libasm_efi_input_reset
;.!.	popfq
;.!.	pop	rax
;)	pop	rbx
;)	pop	rcx
	pop	rdx
;)	pop	rsi
;)	pop	rdi
;	pop	rbp
;	pop	r8
;)	pop	r9
;)	pop	r10
;)	pop	r11
;)	pop	r12
;)	pop	r13
;)	pop	r14
;	pop	r15
	pop	R_ADDR_BUF
	pop	R_ADDR_RSP
	pop	LIBASM_EFI_X86_64_RC
	ret
;	} libasm_efl_key_reset
; ------------- ---- ------
; function:	libasm_efl_key {
; date:		2020-01-07
; rem:		keyboard input
; in:
; out:
;	rdx	: scancode
;
; off	section	.data
; off	section	.bss
section	.text
libasm_efl_key:
	push	LIBASM_EFI_X86_64_RC
	push	R_ADDR_RSP
	push	R_ADDR_BUF
;	push	r15
;)	push	r14
;)	push	r13
;)	push	r12
;)	push	r11
;)	push	r10
;)	push	r9
;	push	r8
;)	push	rbp
;)	push	rdi
;)	push	rsi
; OUT	push	rdx
;)	push	rcx
;)	push	rbx
; OUT	push	rax
	pushfq
	push	rdx				; buffer_init {
	mov	rdx, rsp			; } buffer_init
	call	libasm_efi_input_read_key
	pop	rdx				; from buffer
	popfq
; OUT	pop	rax
;)	pop	rbx
;)	pop	rcx
; OUT	pop	rdx
;)	pop	rsi
;)	pop	rdi
;)	pop	rbp
;	pop	r8
;)	pop	r9
;)	pop	r10
;)	pop	r11
;)	pop	r12
;)	pop	r13
;)	pop	r14
;	pop	r15
	pop	R_ADDR_BUF
	pop	R_ADDR_RSP
	pop	LIBASM_EFI_X86_64_RC
	ret
;	} libasm_efl_key
; ------------- ---- ------
; function:	libasm_efl_key_wait {
; date:		2020-01-07
; rem:		keyboard wait input
; in:
; out:
;	rdx	: scancode
;
; off	section	.data
; off	section	.bss
section	.text
libasm_efl_key_wait:
	push	rax
	pushfq
.j_wait:
	call	libasm_efl_key
	test	rax, rax
	jnz	.j_wait
	popfq
	pop	rax
	ret
;	} libasm_efl_key_wait

; ------------- ---- ------
; function:	f_prn_msg_nl {
; rem:		print message - new line
; date:		2020-01-12
; in:
; out:
;
f_prn_msg_nl:
	push	rax
;)	pushfq
	mov	rax, msg_nl
	call	libasm_efl_prn_msg
;)	popfq
	pop	rax
	ret
;	} f_prn_msg_nl
;
; ------------- ---- ------
; function:	f_prn_msg_dd {
; rem:		print message - ' :  '
; date:		2020-01-12
; in:
; out:
;
f_prn_msg_dd:
	push	rax
;)	pushfq
	mov	rax, msg_dd
	call	libasm_efl_prn_msg
;)	popfq
	pop	rax
	ret
;	} f_prn_msg_nl
;
; ------------- ---- ------
; function:	f_prn_hex_rax {
; rem:		print hex - RAX
; date:		2019-12-31
; in:
;	RAX
; out:
;
f_prn_hex_rax:
	push	rbx
	push	rax
	pushfq
	mov	rbx, rax
	ror	rax, 48			; print addr 63 - 48
	call	libasm_hex_16b
	mov	al, '.'
	call	libasm_efl_prn
	mov	rax, rbx		; print addr 47 - 32
	ror	rax, 32
	call	libasm_hex_16b
	mov	al, '.'
	call	libasm_efl_prn
	mov	rax, rbx		; print addr 31 - 16
	ror	rax, 16
	call	libasm_hex_16b
	mov	al, '.'
	call	libasm_efl_prn
	mov	rax, rbx		; print addr 15 - 0
	call	libasm_hex_16b
	popfq
	pop	rax
	pop	rbx
	ret
;	} f_prn_hex_rax
;
; ------------- ---- ------
; function:	f_prn_hex_rax_dd {
; rem:		print hex - ' : 'RAX
; date:		2020-01-12
; in:
;	RAX
; out:
;
f_prn_hex_rax_dd:
;)	pushfq
	call	f_prn_msg_dd
	call	f_prn_hex_rax
;)	popfq
	ret
;	} f_prn_hex_rax_dd
;
; ------------- ---- ------
; function:	f_buffer_edit {
; rem:		buffer edit
; date:		2020-01-12
; in:
;	rbx	buffer size
; out:
;	rbx	buffer addr begin
;
f_buffer_edit:
	push	rdi
	push	rsi
	push	rdx
	push	rcx
; out	push	rbx
	push	rax
	pushfq
	call	libasm_efl_key_reset
	mov	rsi, BUFFER_SH_SIZE
	mov	rdx, R_ADDR_BUF		; addr buffer
	mov	rdi, rdx		; buffer_clear {
	mov	rcx, rsi
	xor	al, al
	cld
rep	stosb				; } buffer_clear
	cmp	rbx, rsi		; size_in  vs  BUFFER_SH_SIZE
	jnbe	.j_sizebig		; >
	mov	rsi, rbx		; set: BUFFER_SIZE from in_rbx
.j_sizebig:
	mov	rbx, rdx		; restore buffer_sh
	xor	rcx, rcx		; RCX: buffer_index
.j_edit:				; buffer_edit {
	call	libasm_efl_key_wait
	cmp	edx, 0x17		; key: ESC
	jnz	.j_esc_next
	or	rcx, rcx		; protect
	jz	.j_esc_next
	mov	rax, msg_backspace	; mode: ESC_BACKSPACE {
.j_esc_backspace:
	call	libasm_efl_prn_msg
	dec	rcx
	jnz	.j_esc_backspace
	jmp	.j_edit			; } mode: ESC_BACKSPACE
.j_esc_next:
	ror	rdx, 16
	cmp	dl, 20h			; key: 0x20
	jb	.j_1f			; <
	cmp	dl, 7fh			; key: 0x7f
	jnb	.j_7f			; >=
	cmp	rcx, rsi		; BUFFER_SIZE
	jnb	.j_edit			; >= buffer_end
	mov	al, dl
	call	libasm_efl_prn		; mode: save {
	mov	[ rbx + rcx ], dl
	inc	rcx
	jmp	.j_edit			; } mode: save
.j_1f:
.j_7f:
	cmp	dl, 8			; key: BACKSPACE
	jnz	.j_08
	or	rcx, rcx
	jz	.j_edit			; == buffer_begin
	dec	rcx			; mode: BACKSPACE {
	mov	rax, msg_backspace
	call	libasm_efl_prn_msg
	jmp	.j_edit			; } mode: BACKSPACE
.j_08:
	cmp	dl, 0dh			; key: ENTER
	jnz	.j_edit			; } buffer_edit
.j_end:
	xor	al, al			; mode: ENTER {
	mov	[ rbx + rcx ], al
	popfq
	pop	rax
; out	pop	rbx
	pop	rcx
	pop	rdx
	pop	rsi
	pop	rdi
	ret
;	} f_buffer_edit
;
; ------------- ---- ------
; function:	f_buffer_addr {
; rem:		get addr from buffer
; date:		2020-01-11
; in:
;	rsi	buffer index
; out:
;	rsi	buffer index
;	rbx	addr
;	rax	errno: 0 - norm; 1 - addr_bad; 2 - addr_size
;	CF	enter: 0 - false; 1 - true
;
f_buffer_addr:
	push	rdx
	push	rcx
; out	push	rbx
; out	push	rax
; out	pushfq
	mov	rdx, R_ADDR_BUF		; RDX: buffer
	add	rdx, BUFFER_SH_SIZE
	xor	rbx, rbx		; set: ADDR
	xor	ah, ah			; set: ADDR-size control
	cld
.j_found:
	cmp	rsi, rdx		; check buffer_index {
	jnb	.j_error_1		; >= } check buffer_index
	lodsb
	or	al, al
	jz	.j_norm
	cmp	al, ','
	jz	.j_norm
	cmp	al, 20h
	jz	.j_found
	cmp	al, '0'
	jb	.j_error_1		; <
	cmp	al, '9'
	jbe	.j_addr			; <=
	cmp	al, 'A'
	jb	.j_error_1		; <
	cmp	al, 'F'
	jbe	.j_addr_s		; <=
	cmp	al, 'a'
	jb	.j_error_1		; <
	cmp	al, 'f'
	jnbe	.j_error_1		; >
	sub	al, 20h
.j_addr_s:
	sub	al, 7
.j_addr:
	and	al, 0xf			; al = hex
	cmp	ah, 64			; addr_size_check {
	jnb	.j_error_2		; >= 64
	add	ah, 4			; } addr_size_check
	shl	rbx, 4
	xor	rcx, rcx
	mov	cl, al
	add	rbx, rcx
	jmp	.j_found
.j_error_2:
	mov	rcx, msg_error_shadrs	; ERROR: Addr size large
	jmp	.j_true
.j_error_1:
	mov	rcx, msg_error_shaddr	; ERROR: Addr incorrect
	jmp	.j_true
.j_norm:
	xor	rcx, rcx
	or	ah, ah
	clc
	jz	.j_false		; false
.j_true:
	stc				; true
.j_false:
	mov	rax, rcx
; out	popfq
; out	pop	rax
; out	pop	rbx
	pop	rcx
	pop	rdx
	ret
; } f_buffer_addr


%endif				; } ASM_MONITOR_X86_64
; } DavydovMA 2020011200