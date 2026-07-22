[bits 16]

kernel_entry:
    ; Clear the interrupt flag
    cli                 
    
    ; Setup the segment registers
    mov ax, 0x0800    
    mov ds, ax
    mov es, ax

    ; Setup the stack
    mov ss, ax
    mov sp, 0x9000

    ; Having some fun printing stuff
    mov si, strKernelSeparator
    call print
    ; Announce entry into the kernel
    mov si, strKernelEntry
    call print
    
    ; Set the interrupt flag back
    sti                  

    ; Kernel's main infinite loop
    jmp $

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
strKernelSeparator  db  '|---------------------------------------------|', 0x0d, 0x0a, 0
strKernelEntry  db  '[*] Greetings from the kernel!', 0x0d, 0x0a, 0
