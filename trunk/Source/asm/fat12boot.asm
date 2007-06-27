;;;;;;;;;;;;;;;;;;;;;;;;;FAT12BOOT;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;	FAT12 Bootloader for Phoenix OS -- Onyx Kernel			;;
;;	Last Modified: May 29, 2007								;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


[BITS 16]					; We need 16-bit intructions for Real mode

[ORG 0x7C00]				; The BIOS loads the boot sector into memory location 0x7C00

jmp word load_kernel		; Load the OS Kernel

;----------Fat 12 Header junk----------;

	db "ONYXDISK"			; OEM Label String
	dw 512					; Bytes per sector
	db 1                    ; Sectors per FAT cluster
	dw 36                   ; Resered sector count
	db 2                    ; number of FATs
	dw 224					; Root dir entries
	dw 2880					; Total Sectors
	db 240                  ; Double sided, 18 sectors per track
	dw 9                    ; Sectors per FAT
	dw 18                   ; Sectors per track
	dw 2                    ; Head count (double sided)
	dd 0                    ; Hidden sector count 
	
drive db 0					; Used to store boot device
ramsz db 0					; Ram size
	
;----------Bootsector Code----------;
  
load_kernel:
	jmp enable_A20
	jmp read_disk			; Load the OS into memory
	jmp get_ram				; Get ram amount
	jmp enter_pm			; Enter Protected Mode
	
enable_A20:
        in al, 0x92
		or al, 2
		out 0x92, al

read_disk:
	mov ah, 0               ; RESET-command
	int 13h                 ; Call interrupt 13h
	mov [drive], dl			; Store boot disk
	or ah, ah               ; Check for error code
	jnz read_disk	        ; Try again if ah != 0
	mov ax, 0
	mov ax, 0				
	mov es, ax				
	mov bx, 0x1000          ; Destination address = 0000:1000

	mov ah, 02h             ; READ SECTOR-command
	mov al, 22h				; Number of sectors to read (0x24 = 36 sectors)
	mov dl, [drive]			; Load boot disk
	mov ch, 0               ; Cylinder = 0
	mov cl, 2	            ; Starting Sector = 3
	mov dh, 0               ; Head = 1
	int 13h                 ; Call interrupt 13h
	or ah, ah               ; Check for error code
	jnz load_kernel         ; Try again if ah != 0
	cli						; Disable interrupts, we want to be alone
	
get_ram:
	mov ah, 88h			; Detect amount of ram 0e801h or 88h
	int 15
	xor bx, bx
	mov [ramsz], ax
	xchg ax, bx
	add ebp, ramsz
	
	
;set_vmode:
	;sti
	;mov ah, 12h
	;int 10h

enter_pm:
	xor ax, ax
	mov ds, ax              ; Set DS-register to 0 - used by lgdt

	lgdt [gdt_desc]         ; Load the GDT descriptor 
	
;----------Entering Protected Mode----------;
		
	mov eax, cr0            ; Copy the contents of CR0 into EAX
	or eax, 1               ; Set bit 0	(0xFE = Real Mode)
	mov cr0, eax            ; Copy the contents of EAX into CR0
	
	jmp 08h:kernel_segments ; Jump to code segment, offset kernel_segments
	

[BITS 32]                   ; We now need 32-bit instructions
kernel_segments:
	mov ax, 10h             ; Save data segment identifyer
	mov ds, ax              ; Move a valid data segment into the data segment register
	mov ss, ax              ; Move a valid data segment into the stack segment register
	mov esp, 090000h        ; Move the stack pointer to 090000h
	
	jmp 08h:0x1000         ; Jump to section 08h (code), offset 01000h
	
;----------Global Descriptor Table----------;

gdt:						; Address for the GDT

gdt_null:					; Null Segment
	dd 0
	dd 0
	
	
KERNEL_CODE		equ $-gdt
gdt_kernel_code:
	dw 0FFFFh				; Limit 0xFFFF
	dw 0					; Base 0:15
	db 0					; Base 16:23
	db 09Ah					; Present, Ring 0, Code, Non-conforming, Readable
	db 0CFh					; Page-granular
	db 0					; Base 24:31

KERNEL_DATA		equ $-gdt
gdt_kernel_data:			
	dw 0FFFFh				; Limit 0xFFFF
	dw 0					; Base 0:15
	db 0					; Base 16:23
	db 092h					; Present, Ring 0, Data, Expand-up, Writable
	db 0CFh					; Page-granular
	db 0					; Base 24:32

gdt_interrupts:
	dw 0FFFFh
	dw 01000h
	db 0
	db 10011110b
	db 11001111b
	db 0

gdt_end:					; Used to calculate the size of the GDT

gdt_desc:                   ; The GDT descriptor
	dw gdt_end - gdt - 1    ; Limit (size)
	dd gdt                  ; Address of the GDT

times 510-($-$$) db 0       ; Fill up the file with zeros

dw 0AA55h					; Boot sector identifyer

