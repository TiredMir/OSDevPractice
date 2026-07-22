[org 0x7C00]            ; BIOS loads our bootloader at this address until 511 bytes later (0x7DFF)
[bits 16]               ; Assemble instructions as 16-bit because we're in real mode

; Disabling maskable interrupts and initializing segment registers 
cli                     ; Disable interrupts so that CPU won't push interrupt info on invalid memory

xor ax, ax              ; Zero out the AX register
mov ds, ax              ; Zero out the DS register
mov es, ax              ; Zero out the ES register

mov ss, ax              ; Initializing the stack 
mov sp, 0x7C00          ; Here too

mov [boot_drive], dl    ; Save boot drive number that is stored in the DL register when BIOS passes control to our bootloader

; Print initial welcome string
mov si, strStarting
call print

; Load Kernel from disk
mov ax, 0x0800          ; Load kernel into segment 0x0800 (Physical Address = segment(0x0800) * 16 + offset (0x0000)) 
mov es, ax              ; Set ES to 0x0800 
mov bx, 0x0000          ; ES:BX = 0800:0000, physical address = 0x8000 
                        ; (Technically we could place the kernel at 0x7E00 as it's right after the bootloader but everyone gives it a gap)
mov ch, 0               ; Cylinder 0
mov dh, 0               ; Head 0
mov cl, 2               ; Sector 2 (The sector after our bootloader)

mov dl, [boot_drive]    ; Restore boot drive number from earlier
mov ah, 0x02            ; Read Sectors (from disk) function
mov al, 1               ; Number of Sectors to read
int 0x13                ; BIOS disk read interrupt
jc disk_error           ; The carry flag will be set in case of an error, in which case, jump to the error handler

; Print the Kernel loaded string 
mov si, strKernelLoaded
call print

; Set the interrupt flag again 
sti

; Far Jump to Kernel
jmp far [kernel_jump]                  ; Far jump so that we change both of CS:IP to 0x0800:0x0000 
                                       ; A jmp would only change IP and not CS

; Error handler (Just a message printer for now)
disk_error:
    mov si, strDiskError
    call print
    jmp $                              ; Infinite loop

; Print routine
print:
    pusha                ; Save register states on the stack (Caller saves registers)
.loop:
    lodsb                ; Load character at DS:SI into AL and increment SI
    or al, al            ; Check for the end of string (0 i.e. null terminator)
    jz .done             ; If al is 0, then jump to the .done label
    mov ah, 0x0E         ; BIOS teletype function
    int 0x10             ; Video Interrupt
    jmp .loop            ; Jump to the .loop label
.done:
    popa                 ; Restore the register states from the stack
    ret                  ; Jump to the saved return address on the stack

; Data 
strStarting      db '[*] Bootloader is starting...', 0x0d, 0x0a, 0
strKernelLoaded db '[*] Loaded the kernel. (Blessed be Hermes)', 0x0d, 0x0a, 0
strDiskError    db '[-] Could not read disk.', 0x0d, 0x0a, 0

; Far Jump address storage
kernel_jump:
    dw 0x0000       ; Offset (IP)
    dw 0x0800       ; Segment (CS)

boot_drive          db 0

; Boot Sector Padding & Signature
times 510-($-$$) db 0
dw 0xaa55
