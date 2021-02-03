# DavydovMA 2013040600 {
# file		: Makefile
# COPYRIGHT	: "Copyright (C) 1990-2019 DavydovMA <dev@gmail.com>"
# URL		: "http://google.com" */
# MAIL		: dev@domain

SOFT=monitor

# ------------- ---- ------
.PHONY: all clean install uninstall debug
#
# DavydovMA GPLv3+
#
CASMx32=nasm
CASMx64=nasm
ASM=$(CASMx64)
#
# off	FLAGS_ASM_OPT= -O0
# off	FLAGS_ASM_LIST= -l $(SOFT)$(EXT).lst
FLAGS_ASM=       -f bin -O0 -d x86_64 -d OS_EFI
FLAGS_ASM_DEBUG= -f bin -O0 -d x86_64 -d OS_EFI -d DEBUG
#
# off	EXT_Ex32=.efi.bin
# off	EXT_Ex64=.efi.bin
# off	EXT=.efi
#
# info	EFI_HEAD_INFL=00000000	locate in file offset
# info	EFI_HEAD_SIZE=00020000	size
# info	EFI_HRAD_LRAM=00000000	load in ram offset
EFI_TEXT_INFL=00020000
EFI_TEXT_SIZE=00100000
EFI_TEXT_LRAM=00020000
# info	EFI_DATA_INFL=00120000
# info	EFI_DATA_SIZE=00100000
# info	EFI_DATA_LRAM=00200000
# info	EFI_IRAM_SIZE = EFI_HEAD_LRAM + EFI_HEAD_SIZE + EFI_TEXT_LRAM + EFI_TEXT_SIZE
EFI_IRAM_SIZE=00120000
#
# ------------- ---- ------

all:	bin_all efi_all
#	see top
bin_all:
	$(ASM) $(FLAGS_ASM) main.asm -o $(SOFT).bin -l $(SOFT).lst
efi_all:
	cp -v -f source.efi $(SOFT).efi
# efi: inject .bin to .efi
	xxd $(SOFT).bin | xxd -r -s 0x200 - $(SOFT).efi
# efi: [0086] Number of sections
	echo "00000086: 0100" | xxd -r - $(SOFT).efi
# efi: [0088] DateTime
	echo "00000088: 461d6051" | xxd -r - $(SOFT).efi
# efi: [008c] .symb Symbol Table offset
	echo "0000008c: 00000000" | xxd -r - $(SOFT).efi
# efi: [0090] .symb Number of Symbol
	echo "00000090: 00000000" | xxd -r - $(SOFT).efi
# efi: [00b8] Aligment of sections
	echo "000000b8: 00100000" | xxd -r - $(SOFT).efi
# efi: [00bc] Aligment factor
	echo "000000bc: 00020000" | xxd -r - $(SOFT).efi
# efi: [00d0] Size of image
	echo "000000d0: $(EFI_IRAM_SIZE)" | xxd -r - $(SOFT).efi
# efi: [00d8] Checksum
	echo "000000d8: 20130406" | xxd -r - $(SOFT).efi
# efi: .text
# efi: [009c] .text size of section, see [0198]
	echo "0000009c: $(EFI_TEXT_SIZE)" | xxd -r - $(SOFT).efi
# efi: [00a8] .text EntryPoint
	echo "000000a8: $(EFI_TEXT_LRAM)" | xxd -r - $(SOFT).efi
# efi: [00ac] .text addr of section
	echo "000000ac: $(EFI_TEXT_LRAM)" | xxd -r - $(SOFT).efi
# efi: [0190] .text size real load to ram
	echo "00000190: $(EFI_TEXT_SIZE)" | xxd -r - $(SOFT).efi
# efi: [0194] .text addr virtual, offset in ram
	echo "00000194: $(EFI_TEXT_LRAM)" | xxd -r - $(SOFT).efi
# efi: [0198] .text size align, see [00b8]
	echo "00000198: $(EFI_TEXT_SIZE)" | xxd -r - $(SOFT).efi
# efi: [019c] .text offset in file (size: head)
	echo "0000019c: $(EFI_TEXT_INFL)" | xxd -r - $(SOFT).efi
# efi: .data
# efi: [01b0] .data     0 1 2 3 4 5 6 7 8 9 a b c d e f  CLEAR
	echo "000001b0: 00000000000000000000000000000000" | xxd -r - $(SOFT).efi
	echo "000001c0: 00000000000000000000000000000000" | xxd -r - $(SOFT).efi
	echo "000001d0: 0000000000000000" | xxd -r - $(SOFT).efi
# efi: [00a0] .data size of section, see [01c0]
	echo "000000a0: 00000000" | xxd -r - $(SOFT).efi
# efi: .bss
# efi: [01e0] .bss      0 1 2 3 4 5 6 7 8 9 a b c d e f  CLEAR
	echo "000001d8: 0000000000000000" | xxd -r - $(SOFT).efi
	echo "000001e0: 00000000000000000000000000000000" | xxd -r - $(SOFT).efi
	echo "000001f0: 00000000000000000000000000000000" | xxd -r - $(SOFT).efi
# efi: [00a4] .bss size of section
	echo "000000a4: 00000000" | xxd -r - $(SOFT).efi
# efi: [0100] IMAGE*     0 1 2 3 4 5 6 7 8 9 a b c d e f  CLEAR
	echo "00000108: 0000000000000000" | xxd -r - $(SOFT).efi
	echo "00000110: 00000000000000000000000000000000" | xxd -r - $(SOFT).efi
	echo "00000120: 00000000000000000000000000000000" | xxd -r - $(SOFT).efi
	echo "00000130: 00000000000000000000000000000000" | xxd -r - $(SOFT).efi
	echo "00000140: 00000000000000000000000000000000" | xxd -r - $(SOFT).efi
	echo "00000150: 00000000000000000000000000000000" | xxd -r - $(SOFT).efi
	echo "00000160: 00000000000000000000000000000000" | xxd -r - $(SOFT).efi
	echo "00000170: 00000000000000000000000000000000" | xxd -r - $(SOFT).efi
	echo "00000180: 0000000000000000" | xxd -r - $(SOFT).efi
# efi: [007a] "GPLv3+"
	echo "0000007a: 47504c76332b" | xxd -r - $(SOFT).efi
# efi: [01f0] "DavydovMA GPLv3+"
	echo "000001f0: 6d4164617679646f762047504c76332b" | xxd -r - $(SOFT).efi
# efi: version
	cp -v -f $(SOFT).efi $(SOFT).v40.0200.efi
	mv -v -f $(SOFT).efi $(SOFT).v10.0200.efi
# efi: [00b0] ImageBase load to ram, minimal 10 0000
	echo "000000b0: 0000100000000000" | xxd -r - $(SOFT).v10.0200.efi
	echo "000000b0: 0000400000000000" | xxd -r - $(SOFT).v40.0200.efi

clean:	efi_clean
#	see top
efi_clean:
	rm -v -f $(SOFT)*.bin
	rm -v -f $(SOFT)*.lst
	rm -v -f $(SOFT)*.efi

install:	install_efi
#	see top
install_efi:
	@echo "Not use"

uninstall:	uninstall_efi
#	see top
uninstall_efi:
	@echo "Not use"

debug:	debug_bin efi_all debug_efi
#	see top
debug_bin:
	$(ASM) $(FLAGS_ASM_DEBUG) main.asm -o $(SOFT).bin -l $(SOFT).lst
debug_efi:
	mv -v -f $(SOFT).v10.0200.efi $(SOFT).v10.0200.debug.efi
	mv -v -f $(SOFT).v40.0200.efi $(SOFT).v40.0200.debug.efi


# } DavydovMA 2020011800