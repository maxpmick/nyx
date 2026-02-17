---
name: hackrf
description: A suite of utilities for the HackRF Software Defined Radio (SDR) peripheral, capable of transmitting and receiving signals from 30 MHz to 6 GHz. Use these tools for signal sniffing, RF replay attacks, frequency sweeping, device configuration, and firmware management during wireless security assessments or SDR research.
---

# hackrf

## Overview
HackRF is an open-source SDR platform. This suite provides command-line tools to interact with the hardware for data transfer, frequency sweeping, and device maintenance. Category: Wireless Attacks / Sniffing & Spoofing.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install hackrf
```

## Common Workflows

### Device Information and Testing
```bash
hackrf_info
```
Probes connected HackRF devices and displays serial numbers and firmware versions.

### Receiving RF Data to a File
```bash
hackrf_transfer -r capture.iq -f 433920000 -s 2000000 -g 20 -l 16
```
Captures signals at 433.92 MHz with a 2MHz sample rate and specific gain settings.

### Transmitting RF Data from a File
```bash
hackrf_transfer -t capture.iq -f 433920000 -s 2000000 -x 30 -a 1
```
Replays a captured signal at 433.92 MHz with the RF amplifier enabled.

### Fast Frequency Sweep
```bash
hackrf_sweep -f 2400:2500 -l 16 -g 20 -w 100000 -r sweep_results.csv
```
Sweeps the 2.4GHz ISM band and saves the power levels to a CSV file.

## Complete Command Reference

### hackrf_info
Probes the device and shows configuration. No options.

### hackrf_transfer
File-based transmit and receive utility.

| Flag | Description |
|------|-------------|
| `-h` | Display help |
| `-d <serial>` | Specify serial number of desired HackRF |
| `-r <file>` | Receive data into file (use '-' for stdout) |
| `-t <file>` | Transmit data from file (use '-' for stdin) |
| `-w` | Receive into WAV file (SDR# compatibility) |
| `-f <hz>` | Frequency in Hz (1MHz to 6000MHz) |
| `-i <hz>` | Intermediate Frequency (IF) in Hz |
| `-o <hz>` | Front-end Local Oscillator (LO) frequency in Hz |
| `-m <0/1/2>` | Image rejection filter: 0=bypass, 1=low pass, 2=high pass |
| `-a <0/1>` | RX/TX RF amplifier: 1=Enable, 0=Disable |
| `-p <0/1>` | Antenna port power (Bias-T): 1=Enable, 0=Disable |
| `-l <db>` | RX LNA (IF) gain: 0-40dB, 8dB steps |
| `-g <db>` | RX VGA (baseband) gain: 0-62dB, 2dB steps |
| `-x <db>` | TX VGA (IF) gain: 0-47dB, 1dB steps |
| `-s <hz>` | Sample rate in Hz (2-20MHz, default 10MHz) |
| `-F` | Force use of parameters outside supported ranges |
| `-n <num>` | Number of samples to transfer (default: unlimited) |
| `-S <size>` | Enable receive streaming with buffer size `size` |
| `-B` | Print buffer statistics during transfer |
| `-c <amp>` | CW signal source mode, amplitude 0-127 |
| `-R` | Repeat TX mode (loop file) |
| `-b <hz>` | Set baseband filter bandwidth in Hz |
| `-C <ppm>` | Set internal crystal clock error in ppm |
| `-H` | Synchronize RX/TX to external trigger input |

### hackrf_sweep
High-speed frequency sweep utility.

| Flag | Description |
|------|-------------|
| `-h` | Display help |
| `-d <serial>` | Specify serial number |
| `-a <0/1>` | RX RF amplifier: 1=Enable, 0=Disable |
| `-f <min:max>` | Frequency range in MHz |
| `-p <0/1>` | Antenna port power: 1=Enable, 0=Disable |
| `-l <db>` | RX LNA gain: 0-40dB, 8dB steps |
| `-g <db>` | RX VGA gain: 0-62dB, 2dB steps |
| `-w <hz>` | FFT bin width (resolution): 2445-5000000 |
| `-W <file>` | Use/create FFTW wisdom file |
| `-P <type>` | FFTW plan: estimate, measure, patient, exhaustive |
| `-1` | One-shot mode (single sweep) |
| `-N <num>` | Number of sweeps to perform |
| `-B` | Binary output |
| `-I` | Binary inverse FFT output |
| `-n` | Keep same timestamp within a sweep |
| `-r <file>` | Output filename |

### hackrf_biast
Antenna power (Bias-T) utility.

| Flag | Description |
|------|-------------|
| `-h` | Display help |
| `-R` | Reset all bias tee settings to device default |
| `-b <0/1>` | Enable (1) or disable (0) bias tee immediately |
| `-r <mode>` | Default bias tee in RX mode (leave, on, off) |
| `-t <mode>` | Default bias tee in TX mode (leave, on, off) |
| `-o <mode>` | Default bias tee in OFF mode (leave, on, off) |
| `-d <serial>` | Specify serial number |

### hackrf_spiflash
Read and write flash data (firmware).

| Flag | Description |
|------|-------------|
| `-h` | Display help |
| `-a <addr>` | Starting address (default: 0) |
| `-l <len>` | Number of bytes to read (default: 1048576) |
| `-r <file>` | Read data into file |
| `-w <file>` | Write data from file |
| `-i` | Skip firmware compatibility check |
| `-d <serial>` | Specify serial number |
| `-s` | Read SPI flash status registers |
| `-c` | Clear SPI flash status registers |
| `-R` | Reset HackRF after operations |
| `-v` | Verbose output |

### hackrf_debug
Chip register manipulation tool.

| Flag | Description |
|------|-------------|
| `-h` | Display help |
| `-n <reg>` | Set register number |
| `-r` | Read register (specified by -n or all) |
| `-w <val>` | Write value to register (specified by -n) |
| `-c` | Print SI5351C multisynth configuration |
| `-d <serial>` | Specify serial number |
| `-m` | Target MAX2837 |
| `-s` | Target SI5351C |
| `-f` | Target RFFC5072 |
| `-S` | Display M0 state |
| `-T <n>` | Set TX underrun limit in bytes |
| `-R <n>` | Set RX overrun limit in bytes |
| `-u <1/0>` | Enable/disable UI |
| `-l <state>` | Configure LED state (0=off, 1=default) |

### hackrf_clock
Clock configuration utility.

| Flag | Description |
|------|-------------|
| `-h` | Display help |
| `-r <num>` | Read settings for clock_num |
| `-a` | Read settings for all clocks |
| `-i` | Get CLKIN status |
| `-o <0/1>` | Enable/disable CLKOUT |
| `-d <serial>` | Specify serial number |

### hackrf_operacake
Control of Opera Cake antenna switching board.

| Flag | Description |
|------|-------------|
| `-h` | Display help |
| `-d <serial>` | Specify serial number |
| `-o <addr>` | Specify Opera Cake address (default: 0) |
| `-m <mode>` | Switching mode: manual, frequency, time |
| `-a <port>` | Set port connected to port A0 |
| `-b <port>` | Set port connected to port B0 |
| `-f <p:min:max>` | Assign port for MHz range (repeatable) |
| `-t <p:dwell>` | Dwell on port for X samples (repeatable) |
| `-w <n>` | Set default dwell time in samples |
| `-l` | List available Opera Cake boards |
| `-g` | Test GPIO functionality |

### hackrf_cpldjtag
Program the CPLD.

| Flag | Description |
|------|-------------|
| `-h` | Display help |
| `-x <file>` | XSVF file to be written to CPLD |
| `-d <serial>` | Specify serial number |

## Notes
- **Safety**: Ensure antennas are connected before transmitting to avoid hardware damage.
- **Firmware**: Firmware images are typically located in `/usr/share/hackrf/firmware/`.
- **Permissions**: You may need `sudo` or appropriate udev rules to access the USB device.