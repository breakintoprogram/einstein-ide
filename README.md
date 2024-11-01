# einstein-ide

This is a summary of my project to reverse-engineer and recreate the Tatung Einstein cross-development IDE for Z80 and 6502 used by Software Creations in the late 80s.

The original blog posts can be found here on my website:

[http://www.breakintoprogram.co.uk/hardware/recreating-my-80s-dev-system-epilogue](http://www.breakintoprogram.co.uk/hardware/recreating-my-80s-dev-system-epilogue)

## Introduction

My first job after leaving college was as a games developer at Software Creations, a small UK games company based in Manchester.

Up until the early ’90s they were using Tatung Einsteins as the source machine for developing games on the Sinclair Spectrum, Amstrad CPC and Commodore 64.

The workflow was quite simple, yet a massive improvement on my home rig, which was a single 48K ZX Spectrum with an Interface 1, two microdrives, and the Zeus Z80 assembler.

- The source code (Z80 or 6502) was edited and assembled on the Tatung Einstein.
- The resultant binary code was piped to the target machine via a serial or parallel interface.
- A small boot loader on the target machine would receive the binary and write it to memory.
- Once loaded, the code would automatically execute.

On the 8-bit micros memory was at a premium, so not having the assembler and source code resident on the target machine was an advantage. On my home system these would be overwritten every time I assembled and ran the game and I’d have to load them in again. With this workflow, all the developer had to load back in was the boot loader.

I was employed as the Amstrad CPC developer. The first couple of days was spent copying the Spectrum parallel transfer board and making it work on the Amstrad. Mike Webb gave me a bag of components and some Veroboard and basically said: “How’s your soldering?”.

The board was relatively straightfoward to build – an 8255 PIO chip and maybe a single logic chip for lazy address decoding. Needless to say I got it working more or less first time and used it for my Amstrad CPC conversions. I think it may have even survived our move to using PCs as source development machines.

As an aside, I think Mike Webb used 8255 chips because they were cheap and readily available from the Maplins next door to the Software Creations office on Oxford Road in Manchester (opposite the BBC building).

## The plan

The project was split into four main parts.

- [Reverse-engineer Mike Webb's Tatung Einstein Editor/Assembler](./tatung/README.md)
- [Design a parallel I/O board for the Spectrum](./spectrum/pio_board/README.md)
- [Write some tests to check the I/O is working on the Tatung and Spectrum](./tests/README.md)
- [Write a bootloader on the Spectrum to receive the assembled binary from the assembler](./spectrum/bootloader/README.md)