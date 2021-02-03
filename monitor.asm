; DavydovMA 2013040600 {
%ifndef	ASM_MONITOR	; ASM_MONITOR {
%define	ASM_MONITOR

%define	ASM_MONITOR_FILE	"monitor.asm"
%define	ASM_MONITOR_NAME	"monitor"
%define	ASM_MONITOR_VERSION	"19.12"
%define	ASM_MONITOR_COPYRIGHT	"Copyright 1990-2019"
%define	ASM_MONITOR_AUTHOR	"DavydovMA"
%define	ASM_MONITOR_URL		"http://domain"
%define	ASM_MONITOR_EMAIL	"dev-asm@domain"

; ------------- ---- ------
; block:	preset {
; date:		2019-12-26
;
%define	OS_EFI
%define	x86_64
;
BITS 64
;
; } preset

; ------------- ---- ------
; block:	equ {
; date:		2019-12-29
;
TEXT_SIZE	equ	0x1000			; 4096 .text in file
;
; } equ

; ------------- ---- ------
; section:	.text {
; date:		2019-12-26
;
section	.text	align=16
;
; } .text

; ------------- ---- ------
; block:	include {
; date:		2019-12-31
;
%include	"monitor_x86_64.asm"
;
%include	"libasm_hex_x86_64.asm"
;
%include	"libasm_efi_x86_64.asm"
;
%include	"monitor_data.asm"
;
%ifdef	DEBUG
;
%include	"monitor_debug_x86_64.asm"
;
%endif
;
; } include

; ------------- ---- ------
; section:	.text_size_fill {
; date:		2019-12-26
;
section	.text
TIMES	TEXT_SIZE-($-$$)	ret
;
; } .text_size_fill

ADDR_END:

%endif			; } ASM_MONITOR
; } DavydovMA 2019123000