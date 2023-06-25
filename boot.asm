[org 0x7c00]
mov ah, 0x0e
mov bx, intro

print:
    mov al, [bx]
    cmp al, 0
    je end
    int 0x10
    inc bx
    jmp print
    
end:
    jmp $

intro:
    db 0xa, "Beginning of bootloader string.", 0xa, 0xd, "Good day.", 0xa, 0xd, 0
    
times 510-($-$$) db 0
db 0x55, 0xaa
; or we can do dw 0xaa55