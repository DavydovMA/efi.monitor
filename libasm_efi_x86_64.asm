; DavydovMA 2013040600 {
%ifndef	LIBASM_EFI_X86_64	; LIBASM_EFI_X86_64 {
%define	LIBASM_EFI_X86_64

%define	LIBASM_EFI_X86_64_FILE		"libasm_efi_x86_64.asm"
%define	LIBASM_EFI_X86_64_NAME		"libasm_efi_x86_64"
%define	LIBASM_EFI_X86_64_VERSION	"20.01"
%define	LIBASM_EFI_X86_64_COPYRIGHT	"Copyright 1990-2020"
%define	LIBASM_EFI_X86_64_AUTHOR	"DavydovMA"
%define	LIBASM_EFI_X86_64_URL		"http://domain"
%define	LIBASM_EFI_X86_64_EMAIL		"dev-asm@domain"

BITS 64

; ------------- ---- ------
; block:	define all
; rem:		all_function ON
; data:		2020-01-11
;
%ifdef		_libasm_efi_all				; <-key
%define		_libasm_efi_input_reset			; function:	libasm_efi_input_reset
%define		_libasm_efi_input_read_key		; function:	libasm_efi_input_read_key
%define		_libasm_efi_simple_text_input_protocol	; function:	libasm_efi_simple_text_input_protocol
%define		_libasm_efi_text_reset			; function:	libasm_efi_text_reset
%define		_libasm_efi_text_string			; function:	libasm_efi_text_string
%define		_libasm_efi_text_test_string		; function:	libasm_efi_text_test_string
%define		_libasm_efi_text_query_mode		; function:	libasm_efi_text_query_mode
%define		_libasm_efi_text_set_mode		; function:	libasm_efi_text_set_mode
%define		_libasm_efi_text_set_attribute		; function:	libasm_efi_text_set_attribute
%define		_libasm_efi_text_clear_screen		; function:	libasm_efi_text_clear_screen
%define		_libasm_efi_text_set_cursor_position	; function:	libasm_efi_text_set_cursor_position
%define		_libasm_efi_text_enable_cursor		; function:	libasm_efi_text_enable_cursor
%define		_libasm_efi_simple_text_output_protocol	; function:	libasm_efi_simple_text_output_protocol
%define		_libasm_efi_simple_protocol		; function:	libasm_efi_simple_protocol
%define		_libasm_efi_scrcxrax			; function:	libasm_efi_scrcxrax
%define		_libasm_efi_strerror			; function:	libasm_efi_strerror
%define		_libasm_efi_init			; function:	libasm_efi_init
%endif
;
; ------------- ---- ------
; block:	info
; rem:		need
; date:		2020-01-12
; need:
;	%define		LIBASM_EFI_X86_64_RC	RBP
;	DON'T USE	LIBASM_EFI_X86_64_RC
;	libasm_efi_init
; in:
;	rcx	: *
;	rdx	: *
;	r8	: *
;	r9	: *
;	stack	: * ++
; out:
;	rax	: EFI_STATUS
;	rcx	: *
;	rdx	: *
;	r8	: *
;	r9	: *
;	stack	: * ++
;
; off	section	.data
; off	GPLv3+:					; GPLv3+ {
	db	"DavydovMA GPLv3+"		; } GPLv3+
; off	section	.bss
section	.text
;
; ------------- ---- ------
; block:	equ
; rem:		need
; date:		2020-01-11
;


; ------------- ---- ------
; function:	libasm_efi_input_reset {
; rem:		Reset() - Resets the input device hardware.
; date:		2020-01-07
; in:
;	rdx	: BOOLEAN ExtendedVerification - Indicates that the driver may perform a more exhaustive verification operation of the device during reset. [0|1]
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_input_reset		; <-key _libasm_efi_input_reset {
global	libasm_efi_input_reset
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_input_reset:
; OUT	push	rax
	pushfq
	xor	rax, rax			; f: 0x00
	call	libasm_efi_simple_text_input_protocol
	popfq
; OUT	pop	rax
	ret
%define	_libasm_efi_simple_text_input_protocol	; + need
%endif						; } _libasm_efi_input_reset
;
; ------------- ---- ------
; function:	libasm_efi_input_read_key {
; rem:		ReadKeyStroke() - Reads the next keystroke from the input device.
; date:		2020-01-07
; in:
;	rdx	: UINT64 - A pointer to a buffer that is filled in with the keystroke information for the key that was pressed. (UINT16 ScanCode; CHAR16 UnicodeChar)
; out:
;	rax	: EFI_STATUS
;	rdx	: UINT64 - A pointer to a buffer that is filled in with the keystroke information for the key that was pressed. (UINT16 ScanCode; CHAR16 UnicodeChar)
;
%ifdef	_libasm_efi_input_read_key		; <-key _libasm_efi_input_read_key {
global	libasm_efi_input_read_key
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_input_read_key:
; OUT	push	rax
	pushfq
	xor	rax, rax
	mov	al, 0x08			; f: 0x08
	call	libasm_efi_simple_text_input_protocol
	popfq
; OUT	pop	rax
	ret
%define	_libasm_efi_simple_text_input_protocol	; + need
%endif						; } _libasm_efi_input_read_key
;
; ------------- ---- ------
; function:	libasm_efi_simple_text_input_protocol {
; rem:		This protocol is used to obtain input from the ConsoleIn device.
; date:		2020-01-07
; in:
;	rax	: function
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_simple_text_input_protocol		; <-key _libasm_efi_simple_text_input_protocol {
global	libasm_efi_simple_text_intput_protocol
; off	section	.data
; FIXME	define EFI_SIMPLE_TEXT_INPUT_PROTOCOL_GUID {0x387477c1,0x69c7,0x11d2,{0x8e,0x39,0x00,0xa0,0xc9,0x69,0x72,0x3b}}
; off	section	.bss
section	.text
libasm_efi_simple_text_input_protocol:
	push	rbx
; OUT	push	rax
	pushfq
	mov	rbx, 0x30			; EFI_SIMPLE_TEXT_INPUT_PROTOCOL  as  *This
	call	libasm_efi_simple_protocol
	popfq
; OUT	pop	rax
	pop	rbx
	ret
%define	_libasm_efi_simple_protocol		; + need
%endif						; } _libasm_efi_simple_text_input_protocol
;
; ------------- ---- ------
; function:	libasm_efi_text_reset {
; rem:		Reset() - Resets the text output device hardware.
; date:		2020-01-06
; in:
;	rdx	: BOOLEAN ExtendedVerification - Indicates that the driver may perform a more exhaustive verification operation of the device during reset. [0|1]
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_text_reset		; <-key _libasm_efi_text_reset {
global	libasm_efi_text_reset
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_text_reset:
; OUT	push	rax
	pushfq
	xor	rax, rax			; f: 0x00
	call	libasm_efi_simple_text_output_protocol
	popfq
; OUT	pop	rax
	ret
%define	_libasm_efi_simple_text_output_protocol	; + need
%endif						; } _libasm_efi_text_reset
;
; ------------- ---- ------
; function:	libasm_efi_text_string {
; rem:		OutputString() - Displays the string on the device at the current cursor location.
; date:		2020-01-06
; in:
;	rdx	: The Null-terminated string to be displayed on the output device(s).
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_text_string			; <-key _libasm_efi_text_string {
global	libasm_efi_text_string
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_text_string:
; OUT	push	rax
	pushfq
	xor	rax, rax
	mov	al, 0x08			; f: 0x08
	call	libasm_efi_simple_text_output_protocol
	popfq
; OUT	pop	rax
	ret
%define	_libasm_efi_simple_text_output_protocol	; + need
%endif						; } _libasm_efi_text_string
;
; ------------- ---- ------
; function:	libasm_efi_text_test_string {
; rem:		TestString() - Verifies that all characters in a string can be output to the target device.
; date:		2020-01-06
; in:
;	rdx	: The Null-terminated string to be examined for the output device(s).
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_text_test_string	; <-key _libasm_efi_text_test_string {
global	libasm_efi_text_test_string
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_text_test_string:
; OUT	push	rax
	pushfq
	xor	rax, rax
	mov	al, 0x10			; f: 0x10
	call	libasm_efi_simple_text_output_protocol
	popfq
; OUT	pop	rax
	ret
%define	_libasm_efi_simple_text_output_protocol	; + need
%endif						; } _libasm_efi_text_test_string
;
; ------------- ---- ------
; function:	libasm_efi_text_query_mode {
; rem:		QueryMode() - Returns information for an available text mode that the output device(s) supports.
; date:		2020-01-06
; in:
;	rdx	: UINTN ModeNumber - The mode number to return information on.
; out:
;	rax	: EFI_STATUS
;	r8	: UINTN *Columns - Returns the geometry of the text output device for the request ModeNumber.
;	r9	: UINTN *Rows    - Returns the geometry of the text output device for the request ModeNumber.
;
%ifdef	_libasm_efi_text_query_mode	; <-key _libasm_efi_text_query_mode {
global	libasm_efi_text_query_mode
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_text_query_mode:
; OUT	push	rax
	pushfq
	xor	rax, rax
	mov	al, 0x18			; f: 0x18
	call	libasm_efi_simple_text_output_protocol
	popfq
; OUT	pop	rax
	ret
%define	_libasm_efi_simple_text_output_protocol	; + need
%endif						; } _libasm_efi_text_query_mode
;
; ------------- ---- ------
; function:	libasm_efi_text_set_mode {
; rem:		SetMode() - Sets the output device(s) to a specified mode.
; date:		2020-01-06
; in:
;	rdx	: UINTN ModeNumber - The text mode to set.
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_text_set_mode	; <-key _libasm_efi_text_set_mode {
global	libasm_efi_text_set_mode
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_text_set_mode:
; OUT	push	rax
	pushfq
	xor	rax, rax
	mov	al, 0x20			; f: 0x20
	call	libasm_efi_simple_text_output_protocol
	popfq
; OUT	pop	rax
	ret
%define	_libasm_efi_simple_text_output_protocol	; + need
%endif						; } _libasm_efi_text_set_mode
;
; ------------- ---- ------
; function:	libasm_efi_text_set_attribute {
; rem:		SetAttribute() - Sets the background and foreground colors for the OutputString() and ClearScreen() functions.
; date:		2020-01-06
; in:
;	rdx	: UINTN Attribute - The attribute to set. Bits 0..3 are the foreground color, and bits 4..6 are the background color. All other bits are reserved.
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_text_set_attribute	; <-key _libasm_efi_text_set_attribute {
global	libasm_efi_text_set_attribute
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_text_set_attribute:
; OUT	push	rax
	pushfq
	xor	rax, rax
	mov	al, 0x28			; f: 0x28
	call	libasm_efi_simple_text_output_protocol
	popfq
; OUT	pop	rax
	ret
%define	_libasm_efi_simple_text_output_protocol	; + need
%endif						; } _libasm_efi_text_set_attribute
;
; ------------- ---- ------
; function:	libasm_efi_text_clear_screen {
; rem:		ClearScreen() - Clears the output device(s) display to the currently selected background color.
; date:		2020-01-06
; in:
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_text_clear_screen	; <-key _libasm_efi_text_clear_screen {
global	libasm_efi_text_clear_screen
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_text_clear_screen:
; OUT	push	rax
	pushfq
	xor	rax, rax
	mov	al, 0x30			; f: 0x30
	call	libasm_efi_simple_text_output_protocol
	popfq
; OUT	pop	rax
	ret
%define	_libasm_efi_simple_text_output_protocol	; + need
%endif						; } _libasm_efi_text_clear_screen
;
; ------------- ---- ------
; function:	libasm_efi_text_set_cursor_position {
; rem:		SetCursorPosition() - Sets the current coordinates of the cursor position.
; date:		2020-01-06
; in:
;	rdx	: UINTN Column - The position to set the cursor to. Must greater than or equal to zero and less than the number of columns and rows returned by QueryMode().
;	r8	: UINTN Row    - The position to set the cursor to. Must greater than or equal to zero and less than the number of columns and rows returned by QueryMode().
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_text_set_cursor_position	; <-key _libasm_efi_text_set_cursor_position {
global	libasm_efi_text_set_cursor_position
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_text_set_cursor_position:
; OUT	push	rax
	pushfq
	xor	rax, rax
	mov	al, 0x38			; f: 0x38
	call	libasm_efi_simple_text_output_protocol
	popfq
; OUT	pop	rax
	ret
%define	_libasm_efi_simple_text_output_protocol	; + need
%endif						; } _libasm_efi_text_set_cursor_position
;
; ------------- ---- ------
; function:	libasm_efi_text_enable_cursor {
; rem:		EnableCursor() - Makes the cursor visible or invisible.
; date:		2020-01-06
; in:
;	rdx	: BOOLEAN Visible -If TRUE, the cursor is set to be visible. If FALSE, the cursor is set to be invisible. [0|1]
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_text_enable_cursor		; <-key _libasm_efi_text_enable_cursor {
global	libasm_efi_text_enable_cursor
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_text_enable_cursor:
; OUT	push	rax
	pushfq
	xor	rax, rax
	mov	al, 0x40			; f: 0x40
	call	libasm_efi_simple_text_output_protocol
	popfq
; OUT	pop	rax
	ret
%define	_libasm_efi_simple_text_output_protocol	; + need
%endif						; } _libasm_efi_text_enable_cursor
;
; ------------- ---- ------
; function:	libasm_efi_simple_text_output_protocol {
; rem:		This protocol is used to control text-based output devices.
; date:		2020-01-07
; in:
;	rax	: function
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_simple_text_output_protocol		; <-key _libasm_efi_simple_text_output_protocol {
global	libasm_efi_simple_text_output_protocol
; off	section	.data
; FIXME	%define	EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL_GUID	equ		;{0x387477c2,0x69c7,0x11d2,{0x8e,0x39,0x00,0xa0,0xc9,0x69,0x72,0x3b}}
; UNICODE DRAWING CHARACTERS
%define	BOXDRAW_HORIZONTAL			0x2500
%define	BOXDRAW_VERTICAL			0x2502
%define	BOXDRAW_DOWN_RIGHT			0x250c
%define	BOXDRAW_DOWN_LEFT			0x2510
%define	BOXDRAW_UP_RIGHT			0x2514
%define	BOXDRAW_UP_LEFT				0x2518
%define	BOXDRAW_VERTICAL_RIGHT			0x251c
%define	BOXDRAW_VERTICAL_LEFT			0x2524
%define	BOXDRAW_DOWN_HORIZONTAL			0x252c
%define	BOXDRAW_UP_HORIZONTAL			0x2534
%define	BOXDRAW_VERTICAL_HORIZONTAL		0x253c
%define	BOXDRAW_DOUBLE_HORIZONTAL		0x2550
%define	BOXDRAW_DOUBLE_VERTICAL			0x2551
%define	BOXDRAW_DOWN_RIGHT_DOUBLE		0x2552
%define	BOXDRAW_DOWN_DOUBLE_RIGHT		0x2553
%define	BOXDRAW_DOUBLE_DOWN_RIGHT		0x2554
%define	BOXDRAW_DOWN_LEFT_DOUBLE		0x2555
%define	BOXDRAW_DOWN_DOUBLE_LEFT		0x2556
%define	BOXDRAW_DOUBLE_DOWN_LEFT		0x2557
%define	BOXDRAW_UP_RIGHT_DOUBLE			0x2558
%define	BOXDRAW_UP_DOUBLE_RIGHT			0x2559
%define	BOXDRAW_DOUBLE_UP_RIGHT			0x255a
%define	BOXDRAW_UP_LEFT_DOUBLE			0x255b
%define	BOXDRAW_UP_DOUBLE_LEFT			0x255c
%define	BOXDRAW_DOUBLE_UP_LEFT			0x255d
%define	BOXDRAW_VERTICAL_RIGHT_DOUBLE		0x255e
%define	BOXDRAW_VERTICAL_DOUBLE_RIGHT		0x255f
%define	BOXDRAW_DOUBLE_VERTICAL_RIGHT		0x2560
%define	BOXDRAW_VERTICAL_LEFT_DOUBLE		0x2561
%define	BOXDRAW_VERTICAL_DOUBLE_LEFT		0x2562
%define	BOXDRAW_DOUBLE_VERTICAL_LEFT		0x2563
%define	BOXDRAW_DOWN_HORIZONTAL_DOUBLE		0x2564
%define	BOXDRAW_DOWN_DOUBLE_HORIZONTAL		0x2565
%define	BOXDRAW_DOUBLE_DOWN_HORIZONTAL		0x2566
%define	BOXDRAW_UP_HORIZONTAL_DOUBLE		0x2567
%define	BOXDRAW_UP_DOUBLE_HORIZONTAL		0x2568
%define	BOXDRAW_DOUBLE_UP_HORIZONTAL		0x2569
%define	BOXDRAW_VERTICAL_HORIZONTAL_DOUBLE	0x256a
%define	BOXDRAW_VERTICAL_DOUBLE_HORIZONTAL	0x256b
%define	BOXDRAW_DOUBLE_VERTICAL_HORIZONTAL	0x256c
; EFI Required Block Elements Code Chart
%define	BLOCKELEMENT_FULL_BLOCK			0x2588
%define	BLOCKELEMENT_LIGHT_SHADE		0x2591
; EFI Required Geometric Shapes Code Chart
%define	GEOMETRICSHAPE_UP_TRIANGLE		0x25b2
%define	GEOMETRICSHAPE_RIGHT_TRIANGLE		0x25ba
%define	GEOMETRICSHAPE_DOWN_TRIANGLE		0x25bc
%define	GEOMETRICSHAPE_LEFT_TRIANGLE		0x25c4
; EFI Required Arrow shapes
%define	ARROW_UP				0x2191
%define	ARROW_DOWN				0x2193
; Attributes
%define	EFI_BLACK			0x00
%define	EFI_BLUE			0x01
%define	EFI_GREEN			0x02
%define	EFI_CYAN			0x03
%define	EFI_RED				0x04
%define	EFI_MAGENTA			0x05
%define	EFI_BROWN			0x06
%define	EFI_LIGHTGRAY			0x07
%define	EFI_BRIGHT			0x08
%define	EFI_DARKGRAY			0x08
%define	EFI_LIGHTBLUE			0x09
%define	EFI_LIGHTGREEN			0x0A
%define	EFI_LIGHTCYAN			0x0B
%define	EFI_LIGHTRED			0x0C
%define	EFI_LIGHTMAGENTA		0x0D
%define	EFI_YELLOW			0x0E
%define	EFI_WHITE			0x0F
%define	EFI_BACKGROUND_BLACK		0x00
%define	EFI_BACKGROUND_BLUE		0x10
%define	EFI_BACKGROUND_GREEN		0x20
%define	EFI_BACKGROUND_CYAN		0x30
%define	EFI_BACKGROUND_RED		0x40
%define	EFI_BACKGROUND_MAGENTA		0x50
%define	EFI_BACKGROUND_BROWN		0x60
%define	EFI_BACKGROUND_LIGHTGRAY	0x70
; off	section	.bss
section	.text
libasm_efi_simple_text_output_protocol:
	push	rbx
; OUT	push	rax
	pushfq
	mov	rbx, 0x40			; EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL  as  *This
	call	libasm_efi_simple_protocol
	popfq
; OUT	pop	rax
	pop	rbx
	ret
%define	_libasm_efi_simple_protocol		; + need
%endif						; } _libasm_efi_simple_text_output_protocol
;
; ------------- ---- ------
; function:	libasm_efi_simple_protocol {
; rem:		fantik
; date:		2020-01-07
; in:
;	rbx	; protocol
;	rax	: function
; out:
;	rax	: EFI_STATUS
;
%ifdef	_libasm_efi_simple_protocol		; <-key _libasm_efi_simple_protocol {
global	libasm_efi_simple_protocol
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_simple_protocol:
	push	rcx
; off	push	rbx
; OUT	push	rax
	pushfq
	mov	rcx, EFI_SYSTEM_TABLE_INIT	; load in_RDX {
	add	rcx, LIBASM_EFI_X86_64_RC
	mov	rcx, [ rcx ]			; } load in_RDX
	mov	rcx, [ rcx + rbx ]		; EFI_SIMPLE_PROTOCOL  as  *This
	call	libasm_efi_scrcxrax
	popfq
; OUT	pop	rax
; off	pop	rbx
	pop	rcx
	ret
%define	_libasm_efi_init			; + need
%define	_libasm_efi_scrcxrax			; + need
%endif						; } _libasm_efi_simple__protocol
;
; ------------- ---- ------
; function:	libasm_efi_scrcxrax {
; rem:		efi system call rcxrax
; date:		2020-02-21
; in:
;	rax	; function
;	rcx	: *This
;	rdx	: *
;	r8	: *
;	r9	: *
;	stack	: * ++
; out:
;	rax	: EFI_STATUS
;	rdx	: *
;	r8	: *
;	r9	: *
;	stack	: * +++
;
%ifdef		_libasm_efi_scrcxrax		; <-key _libasm_efi_scrcxrax {
; off	global	libasm_efi_scrcxrax
; off	section	.data
; off	section	.bss
section	.text
libasm_efi_scrcxrax:
	test	rsp, 0x8
	jz	.j_0x8				; The stack must be 16-byte aligned. Stack may be marked as non-executable in identity mapped page tables.
;o_O	jnz	.j_0x8				; The stack must be 16-byte aligned. Stack may be marked as non-executable in identity mapped page tables.
	call	.j_sc
	ret
.j_0x8:
	push	rbx				; The stack must be 16-byte aligned. Stack may be marked as non-executable in identity mapped page tables.
	call	.j_sc
	pop	rbx				; The stack must be 16-byte aligned. Stack may be marked as non-executable in identity mapped page tables.
	ret
.j_sc:
	pushfq					; } x64 Platforms: Other general purpose flag registers are undefined
; OUT	push	rax
	push	rbx
	push	rcx
	push	rdx
	push	rsi
	push	rdi
	push	rbp
	push	r8
	push	r9
	push	r10
	push	r11
	push	r12
	push	r13
	push	r14
	push	r15				; x64 Platforms: Other general purpose flag registers are undefined {
	sub	rsp, 4*8
	cld					; x64 Platforms: Direction flag in EFLAGs is clear
	call	[ rcx + rax ]
	add	rsp, 4*8
	pop	r15				; } x64 Platforms: Other general purpose flag registers are undefined
	pop	r14
	pop	r13
	pop	r12
	pop	r11
	pop	r10
	pop	r9
	pop	r8
	pop	rbp
	pop	rdi
	pop	rsi
	pop	rdx
	pop	rcx
	pop	rbx
; OUT	pop	rax
	popfq					; x64 Platforms: Other general purpose flag registers are undefined {
	ret
%endif						; } _libasm_efi_scrcxrax
;
; ------------- ---- ------
; function:	libasm_efi_strerror {
; rem:		return string error
; date:		2020-01-06
; in:
;	rax	: EFI_STATUS
; out:
;	rax	: string error
;
%ifdef		_libasm_efi_strerror		; <-key _libasm_efi_strerror {
global	libasm_efi_strerror
; off	section	.data
EFI_ERROR_UNKNOW:
	db	"o_O ERROR unknow.",0
EFI_SUCCESS:
	db	"The operation completed successfully."		;) ,0
EFI_STATUS_HBC:		; High Bit Clear
	db	0
EFI_WARN_UNKNOWN_GLYPH:
	db	1, "The string contained one or more characters that the device could not render and were skipped.",0
EFI_WARN_DELETE_FAILURE:
	db	2, "The handle was closed, but the file was not deleted.",0
EFI_WARN_WRITE_FAILURE:
	db	3, "The handle was closed, but the data to the file was not flushed properly.",0
EFI_WARN_BUFFER_TOO_SMALL:
	db	4, "The resulting buffer was too small, and the data was truncated to the buffer size.",0
EFI_WARN_STALE_DATA:
	db	5, "The data has not been updated within the timeframe set by local policy for this type of data.",0
EFI_WARN_FILE_SYSTEM:
	db	6, "The resulting buffer contains UEFI-compliant file system.",0
EFI_WARN_RESET_REQUIRED:
	db	7, "The operation will be processed across a system reset.",0
	db	0	;) ,"",0
EFI_STATUS_HBS:		; High Bit Set
	db	0
EFI_LOAD_ERROR:
	db	1, "The image failed to load.",0
EFI_INVALID_PARAMETER:
	db	2, "A parameter was incorrect.",0
EFI_UNSUPPORTED:
	db	3, "The operation is not supported.",0
EFI_BAD_BUFFER_SIZE:
	db	4, "The buffer was not the proper size for the request.",0
EFI_BUFFER_TOO_SMALL:
	db	5, "The buffer is not large enough to hold the requested data. The required buffer size is returned in the appropriate parameter when this error occurs.",0
EFI_NOT_READY:
	db	6, "here is no data pending upon return.",0
EFI_DEVICE_ERROR:
	db	7, "The physical device reported an error while attempting the operation.",0
EFI_WRITE_PROTECTED:
	db	8, "The device cannot be written to.",0
EFI_OUT_OF_RESOURCES:
	db	9, "A resource has run out.",0
EFI_VOLUME_CORRUPTED:
	db	10, "An inconstancy was detected on the file system causing the operating to fail.",0
EFI_VOLUME_FULL:
	db	11, "There is no more space on the file system.",0
EFI_NO_MEDIA:
	db	12, "The device does not contain any medium to perform the operation.",0
EFI_MEDIA_CHANGED:
	db	13, "The medium in the device has changed since the last access.",0
EFI_NOT_FOUND:
	db	14, "The item was not found.",0
EFI_ACCESS_DENIED:
	db	15, "Access was denied.",0
EFI_NO_RESPONSE:
	db	16, "The server was not found or did not respond to the request.",0
EFI_NO_MAPPING:
	db	17, "A mapping to a device does not exist.",0
EFI_TIMEOUT:
	db	18, "The timeout time expired.",0
EFI_NOT_STARTED:
	db	19, "The protocol has not been started.",0
EFI_ALREADY_STARTED:
	db	20, "The protocol has already been started.",0
EFI_ABORTED:
	db	21, "The operation was aborted.",0
EFI_ICMP_ERROR:
	db	22, "An ICMP error occurred during the network operation.",0
EFI_TFTP_ERROR:
	db	23, "A TFTP error occurred during the network operation.",0
EFI_PROTOCOL_ERROR:
	db	24, "A protocol error occurred during the network operation.",0
EFI_INCOMPATIBLE_VERSION:
	db	25, "The function encountered an internal version that was incompatible with a version requested by the caller.",0
EFI_SECURITY_VIOLATION:
	db	26, "The function was not performed due to a security violation.",0
EFI_CRC_ERROR:
	db	27, "A CRC error was detected.",0
EFI_END_OF_MEDIA:
	db	28, "Beginning or end of media was reached.",0
EFI_END_OF_FILE:
	db	31, "The end of the file was reached.",0
EFI_INVALID_LANGUAGE:
	db	32, "The language specified was invalid.",0
EFI_COMPROMISED_DATA:
	db	33, "The security status of the data is unknown or compromised and the data must be updated or replaced to restore a valid security status.",0
EFI_IP_ADDRESS_CONFLICT:
	db	34, "There is an address conflict address allocation.",0
EFI_HTTP_ERROR:
	db	35, "A HTTP error occurred during the network operation.",0
	db	0,"",0
; off	section	.bss
section	.text
libasm_efi_strerror:
	push	rsi
; off	push	rdx
; off	push	rcx
; off	push	rbx
; OUT	push	rax
	pushfq
	mov	rsi, EFI_SUCCESS		; errno == 0 {
	or	rax, rax
	jz	.j_ok_add			; } errno == 0
	mov	rsi, EFI_STATUS_HBC		; High Bit Clear
	jns	.j_hbc
	mov	rsi, EFI_STATUS_HBS		; Hogh Bit Set
.j_hbc:
	add	rsi, LIBASM_EFI_X86_64_RC
	mov	ah, al
	cld
.j_notzero:					; found_end_of_message {
	lodsb
	or	al, al
	jnz	.j_notzero			; } found_end_of_message
.j_next_errno:
	lodsb					; al <= [ rsi ]; rsi++
	cmp	al, ah
	jz	.j_ok_sub			; found_errno
	or	al, al
	jnz	.j_notzero			; next_errno
	cmp	al, [ rsi ]			; next 0 ?
	jnz	.j_notzero			; not end
	mov	rsi, EFI_ERROR_UNKNOW
.j_ok_add:
	add	rsi, LIBASM_EFI_X86_64_RC
.j_ok_sub:
	mov	rax, rsi
	sub	rax, LIBASM_EFI_X86_64_RC
	popfq
; OUT	pop	rax
; off	pop	rbx
; off	pop	rcx
; off	pop	rdx
	pop	rsi
	ret
%endif						; } _libasm_efi_strerror
;
; ------------- ---- ------
; function:	libasm_efi_init {
; rem:		efi init
; date:		2020-01-06
; in:
;	rcx	: in_RCX - EFI_HANDLE		ImageHandle  The firmware allocated handle for the UEFI image.
;	rdx	: in_RDX - EFI_SYSTEM_TABLE	SystemTable  A pointer to the EFI System Table.
; out:
;	LIBASM_EFI_X86_64_RC	: .text_addr_begin
;
%ifdef		_libasm_efi_init		; <-key _libasm_efi_init {
global	libasm_efi_init
; off	section	.data
EFI_HANDLE_INIT:
	db	0,0,0,0,0,0,0,0
EFI_SYSTEM_TABLE_INIT:
	db	0,0,0,0,0,0,0,0
; off	section	.bss
section	.text
libasm_efi_init:
; OUT	push	rbp
	push	rax
	pushfq
	call	.j_noxyu			; init LIBASM_EFI_X86_64_RC as .text_addr_begin {
.j_noxyu:
	pop	LIBASM_EFI_X86_64_RC
	sub	LIBASM_EFI_X86_64_RC, .j_noxyu	; } init LIBASM_EFI_X86_64_RC as .text_addr_begin
	mov	rax, EFI_HANDLE_INIT
	add	rax, LIBASM_EFI_X86_64_RC
	mov	[ rax ], rcx
	mov	rax, EFI_SYSTEM_TABLE_INIT
	add	rax, LIBASM_EFI_X86_64_RC
	mov	[ rax ], rdx
	popfq
	pop	rax
; OUT	pop	rbp
	ret
%endif						; } _libasm_efi_init


%endif						; } LIBASM_EFI_X86_64
; } DavydovMA 2020022100