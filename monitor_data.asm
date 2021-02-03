; DavydovMA 2013040600 {
%ifndef	ASM_MONITOR_DATA	; ASM_MONITOR_DATA {
%define	ASM_MONITOR_DATA

%define	ASM_MONITOR_DATA_FILE		"monitor_data.asm"
%define	ASM_MONITOR_DATA_NAME		"monitor_data"
%define	ASM_MONITOR_DATA_VERSION	"20.01"
%define	ASM_MONITOR_DATA_COPYRIGHT	"Copyright 1990-2019"
%define	ASM_MONITOR_DATA_AUTHOR		"DavydovMA"
%define	ASM_MONITOR_DATA_URL		"http://domain"
%define	ASM_MONITOR_DATA_EMAIL		"dev-asm@domain"


; ------------- ---- ------
; block:	data
; rem:		
; date:		2020-01-12
;

;info_1:		db	"2013.04.06 - geHb korga cekTaHTbi y6uBaJiu MeH9, a noJiuu,u9, npokypaTypa, ck, cygbi, fsb - ckpbiBaiOT npecTynHukoB"
;info_2:		db	"2018.07.26 - geHb korga FSB u36uJiu MeH9"
;info_3:		db	"2018.09.25 - geHb korga FSB coBepwuJiu Moe noxuweHue"

msg_title:
	db	0dh, 0ah, SOFT_NAME, " version ", SOFT_VERSION,0
msg_title_2:
	db	", ", SOFT_COPYRIGHT, " Free Software ", SOFT_AUTHOR, ", Inc"
	db	0dh, 0ah, "URL:     ", SOFT_URL
	db	0dh, 0ah, "e-mail:  ", SOFT_EMAIL
msg_nl:
	db	0dh, 0ah, 0
msg_shell:
	db	0dh, 0ah, "-->", 0
msg_backspace:
	db	8, ' ', 8, 0

msg_info_beg:
	db	0dh, 0ah, "Beg",0
msg_info_end:
	db	" / end", 0
msg_info_rflags:
	db	0dh, 0ah, "FLG", 0
msg_info_cs:
	db	0dh, 0ah, " CS : ", 0
msg_info_ss:
	db	0dh, 0ah, " SS : ", 0
msg_info_ds:
	db	"                   DS : ", 0
msg_info_es:
	db	"    ES : ", 0
msg_info_fs:
	db	"                   FS : ", 0
msg_info_gs:
	db	"    GS : ", 0
msg_info_rip:
	db	0dh, 0ah, "RIP", 0
msg_info_rsp:
	db	0dh, 0ah, "RSP", 0
msg_info_rax:
	db	0dh, 0ah, "RAX", 0
msg_info_rbx:
	db	0dh, 0ah, "RBX", 0
msg_info_rcx:
	db	0dh, 0ah, "RCX", 0
msg_info_rdx:
	db	0dh, 0ah, "RDX", 0
msg_info_rsi:
	db	0dh, 0ah, "RSI", 0
msg_info_rdi:
	db	0dh, 0ah, "RDI", 0
msg_info_rbp:
	db	0dh, 0ah, "RBP", 0
msg_info_r8:
	db	0dh, 0ah, " R8", 0
msg_info_r9:
	db	0dh, 0ah, " R9", 0
msg_info_r10:
	db	0dh, 0ah, "R10", 0
msg_info_r11:
	db	0dh, 0ah, "R11", 0
msg_info_r12:
	db	0dh, 0ah, "R12", 0
msg_info_r13:
	db	0dh, 0ah, "R13", 0
msg_info_r14:
	db	0dh, 0ah, "R14", 0
msg_info_r15:
	db	0dh, 0ah, "R15", 0

msg_error_shcnf:
	db	0dh, 0ah, "ERROR: Command not found",0
msg_error_shaddr:
	db	0dh, 0ah, "ERROR: Addr incorrect",0
msg_error_shadrs:
	db	0dh, 0ah, "ERROR: Addr size large",0
msg_error_shfill:
	db	0dh, 0ah, "ERROR: Fill incorrect",0
msg_error_shsain:
	db	0dh, 0ah, "ERROR: Text incorrect",0
msg_error_shsawow:
	db	0dh, 0ah, "ERROR: Wow...",0
msg_error_shsbin:
	db	0dh, 0ah, "ERROR: Byte incorrect",0
msg_error_shrun:
	db	0dh, 0ah, "RETURN RAX"
msg_dd:
	db	" : ",0

msg_mode_help:
	db	0dh, 0ah, "A{scii search} addr,addr,text : ESC   - break"
	db	0dh, 0ah, "B{yte  search} addr,addr,byte : ESC   - break"
	db	0dh, 0ah, "D{ump}         addr           : ESC|. - exit"
	db	0dh, 0ah, "M{odify}       addr           : ESC/0..F/ENTER * - exit"
	db	0dh, 0ah, "F{ill}         addr,addr,fill"
	db	0dh, 0ah, "T{ransfer}     addr,addr,addr"
	db	0dh, 0ah, "R{un}          addr,RAX"
	db	0dh, 0ah, "C{lear screen} color"
	db	0dh, 0ah, "I{nfo register}"
	db	0dh, 0ah, "H{elp}"
	db	0dh, 0ah, "Q{uit}"
	db	0
msg_mode_quit:
	db	0dh, 0ah, "Quit."
msg_mode_pak:
	db	0dh, 0ah, "Press any key...",0

; off	GPLv3+:					; GPLv3+ {
	db	"DavydovMA GPLv3+"		; } GPLv3+


%endif				; } ASM_MONITOR_DATA
; } DavydovMA 2020011200