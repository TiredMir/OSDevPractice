# OSDevPractice
A repository for uploading my practice files regarding [OS Dev Tutorials](https://wiki.osdev.org/Babystep1). <br>
This is a work in progress.
The biggest of shoutouts to the absolute GOATS: [The Daedalus Community](https://www.youtube.com/@DaedalusCommunity)
Check out their [MellOS](https://github.com/mell-o-tron/MellOs/tree/main)

### Why?
Why not? Motivation for writing code again, etc.

### How to run this?
You can assemble the bootloader and the kernel using the following commands: <br>
`nasm -f bin .\boot.asm -o .\boot.bin` <br>
`nasm -f bin .\kernel.asm -o .\kernel.bin` <br>

Afterwards, you need to merge them into one file. You can do that through either: <br>
Windows:
`cmd /c copy /b boot.bin+kernel.bin os.img`
<br>or <br>
Linux:
`cat boot.bin kernel.bin > os.img`

And then run it with an emulator like QEMU with the following command: <br>
`qemu-system-i386 -fda os.img`

### Further resources
The following are invaluable resources in the matter: <br>
https://wiki.osdev.org/ <br>
http://github.com/cfenollosa/os-tutorial/ <br>
https://www.youtube.com/@DaedalusCommunity <br>

### To Do
- Use LBA instead of CHS
- Add maybe a shell to the kernel
- Keyboard and video drivers
