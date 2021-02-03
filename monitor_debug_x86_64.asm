; DavydovMA 2013040600 {
%ifndef	ASM_MONITOR_DEBUG	; ASM_MONITOR_DEBUG {
%define	ASM_MONITOR_DEBUG

%define	ASM_MONITOR_DEBUG_FILE		"monitor_debag_x86_64.asm"
%define	ASM_MONITOR_DEBUG_NAME		"monitor_debug_x86_64"
%define	ASM_MONITOR_DEBUG_VERSION	"20.01"
%define	ASM_MONITOR_DEBUG_COPYRIGHT	"Copyright 1990-2019"
%define	ASM_MONITOR_DEBUG_AUTHOR	"DavydovMA"
%define	ASM_MONITOR_DEBUG_URL		"http://domain"
%define	ASM_MONITOR_DEBUG_EMAIL		"dev-asm@domain"


section	.text
	DB	'!'
	inc	rax
	ret
	DB	'!'


%endif				; } ASM_MONITOR_DEBUG
; } DavydovMA 2020011200