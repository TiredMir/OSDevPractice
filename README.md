# OSDevPractice
A repository for uploading my practice files regarding [OS Dev Tutorials](https://wiki.osdev.org/Babystep1). <br>
This is a work in progress.

### Why?
Why not? Motivation for writing code again, etc.

### How to run this?
This repo will mostly be a BIOS bootloader for a while until I figure stuff out. And the way to run it would be to assemble the file into binary with: <br>
`nasm -f bin .\boot.asm -o .\boot.bin` <br>
and then run in with an emulator like QEMU with the following command: <br>
`qemu-system-x86_64 .\boot.bin`

### Further resources
The following are invaluable resources in the matter: <br>
https://wiki.osdev.org/ <br>
http://github.com/cfenollosa/os-tutorial/ <br>
https://www.youtube.com/@OALABS <br>
https://www.youtube.com/@OpenSecurityTraining <br>
