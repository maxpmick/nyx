---
name: inspectrum
description: Visualize and analyze captured radio signals from software-defined radio (SDR) receivers. Use when performing signal analysis, identifying modulation schemes, measuring symbol rates, or extracting data from RF captures in SigMF, GNURadio, or raw IQ formats.
---

# inspectrum

## Overview
inspectrum is a tool for analyzing captured radio signals, primarily from software-defined radio (SDR) receivers. It provides a high-performance spectrogram capable of handling very large files (100GB+) and includes tools for measuring signal characteristics and demodulating data. Category: Wireless Attacks / SDR.

## Installation (if not already installed)
Assume inspectrum is already installed. If you get a "command not found" error:

```bash
sudo apt update && sudo apt install inspectrum
```

## Common Workflows

### Opening a capture with a specific sample rate
```bash
inspectrum -r 2000000 capture.cu8
```
Opens an RTL-SDR capture (8-bit unsigned) specifying a 2 Msps sample rate.

### Analyzing a SigMF recording
```bash
inspectrum recording.sigmf-meta
```
Automatically loads the data file and metadata (sample rate, frequency, etc.) defined in the SigMF format.

### General Signal Analysis
1. Open the file in `inspectrum`.
2. Use the **Spectrogram** to locate the signal of interest.
3. Right-click to add **Derived Plots** (Amplitude, Frequency, Phase) to identify modulation (e.g., FSK, ASK, PSK).
4. Use **Cursors** to measure the period or symbol rate.
5. Right-click a cursor to **Extract Symbols** or **Export** filtered samples.

## Complete Command Reference

```bash
inspectrum [OPTIONS] [file]
```

### Options

| Flag | Description |
|------|-------------|
| `-r <rate>` | Set the sample rate in Hz (e.g., `-r 1000000` for 1MHz). |
| `file` | Path to the input file. If omitted, the application opens with a blank state. |

### Supported File Formats

| Extension | Description |
|-----------|-------------|
| `.sigmf-meta`, `.sigmf-data` | Signal Metadata Format (SigMF) recordings |
| `.cf32`, `.cfile` | Complex 32-bit floating point (GNURadio, osmocom_fft) |
| `.cf64` | Complex 64-bit floating point samples |
| `.cs16` | Complex 16-bit signed integer (BladeRF) |
| `.cs8` | Complex 8-bit signed integer (HackRF) |
| `.cu8` | Complex 8-bit unsigned integer (RTL-SDR) |
| `.f32` | Real 32-bit floating point samples |
| `.f64` | Real 64-bit floating point samples (MATLAB) |
| `.s16` | Real 16-bit signed integer samples |
| `.s8` | Real 8-bit signed integer samples |
| `.u8` | Real 8-bit unsigned integer samples |

## Notes
- **Performance**: Optimized for large files; it does not load the entire file into RAM, allowing for analysis of 100GB+ captures.
- **Interactivity**: Most analysis features (adding plots, cursors, and exporting) are accessed via right-clicking within the GUI.
- **Sample Rate**: If the file format does not contain metadata (like raw `.cu8` or `.cf32`), you must provide the sample rate via the `-r` flag or set it manually within the GUI for accurate time/frequency measurements.