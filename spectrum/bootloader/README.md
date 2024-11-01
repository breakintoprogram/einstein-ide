# bootloader

The bootloader is a small piece of code that runs on the target machine. It waits for data (the assembled binary) from Mike Webb's editor/assembler, and writes it to the target machine's memory.

I wrote two versions, an initial proof-of-concept in Sinclair BASIC, and the final version in Z80.

## Ports on the Spectrum PIO board

The decoding is extremely lazy, with address lines A5 to A7 being used:

- A5: Connected to BA of the PIO - set to 0 to select port A, 1 to select port B
- A6: Connected to CD of the PIO - set to 0 to select the data register, 1 to select control
- A7: Connected to CE of the PIO - set to 0 to enable (write to the registers)

This maps to the following ports on the Spectrum:

- `0011111b (0x1F): Port A (Data)`
- `0101111b (0x5F): Port A (Control)`
- `0011111b (0x3F): Port B (Data)`
- `0111111b (0x7F): Port B (Control)`

This project uses all 8 bits of Port B for transferring bytes between the Tatung Einstein and the Spectrum, and the bottom two bits of Port A for handshaking.

- Bit 0: Connected to the Ready line (read from the Tatung Einstein)
- Bit 1: Connected to the Strobe line (written from the Spectrum)

It will be the responsibility of the Spectrum bootloader code to handle the handshaking in code as follows:

```
Wait until Ready is high (bit 0 of Port A)
Read the data in from Port B.
Write a 0 to Strobe, then a 1 to Strobe (bit 1 of Port A)
```

## Configuring the ports

The Z80 PIO has four operating modes:

- Mode 0: Output
- Mode 1: Input
- Mode 2: Bidirectional
- Mode 3: Bit control

I’m not going to go into details on how to use each of the modes as the Z80 transfer software on the Spectrum will use Mode 3 on both ports.

The top two bits of the control register are used to set the port, and the bottom nibble must be set to 1111 for set mode. When using Mode 3, a second write to the control register is required to set the indivdual bits of the port to input or output.

- 0: The pin is output
- 1: The pin is input

For more information on the Z80 PIO, I suggest reading the Z80 PIO manual.

## Building

### BASIC bootloader

The BASIC proof-of-concept can be found [here](./bootloader.bas)

This can be converted to a tap file using the utility [bas2tap](https://github.com/speccyorg/bas2tap)

`bas2tap bootloader.bas`

### Z80 bootloader

The Z80 bootloader can be found [here](./bootloader.z80)

This can be assembled using the assembler [sjasmplus](https://github.com/sjasmplus/sjasmplus) into a tap file using the command

`sjasmplus bootloader.z80`