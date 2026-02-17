---
name: gr-iqbal
description: Blind IQ imbalance estimator and correction for GNU Radio. Use to suppress symmetrical images caused by IQ imbalance in the RX path of quadrature receivers during SDR (Software Defined Radio) operations, signal analysis, or wireless communication testing.
---

# gr-iqbal

## Overview
gr-iqbal is a GNU Radio module designed to detect and correct IQ imbalance in quadrature receivers. IQ imbalance typically manifests as "ghost" or "mirror" images of signals mirrored across the center frequency. This tool provides two primary functional components: "IQ Bal Fix" for applying corrections and "IQ Bal Optimize" for blind detection of imbalance parameters. Category: Wireless Attacks / SDR.

## Installation (if not already installed)
Assume gr-iqbal is already installed. If the blocks are missing from GNU Radio Companion:

```bash
sudo apt update
sudo apt install gr-iqbal
```

## Common Workflows

### Automated Blind Correction in GNU Radio Companion
1. Place the **IQ Bal Optimize** block after your SDR Source (e.g., RTL-SDR, HackRF).
2. Connect the output of the SDR Source to the input of **IQ Bal Optimize**.
3. Connect the message output port of **IQ Bal Optimize** to the message input port of an **IQ Bal Fix** block.
4. The optimizer will continuously calculate magnitude and phase corrections and update the fixer block.

### Manual IQ Correction
If you have pre-determined calibration values for your specific hardware:
1. Place the **IQ Bal Fix** block in your flowgraph.
2. Manually enter the `Magnitude` and `Phase` correction values in the block properties.
3. Run the flowgraph to apply static correction to the complex stream.

## Complete Command Reference

gr-iqbal is primarily used as a set of blocks within **GNU Radio Companion (GRC)** or via Python API. It consists of two main subblocks:

### 1. IQ Bal Fix
Applies the actual correction to a complex signal stream. The algorithm used is identical to the hardware correction applied in USRP devices.

| Parameter | Description |
|-----------|-------------|
| **Magnitude** | The magnitude correction factor to apply to the I/Q components. |
| **Phase** | The phase correction factor (in radians) to apply. |
| **Message Port** | Accepts asynchronous message pairs to update correction parameters dynamically. |

### 2. IQ Bal Optimize
Blindly detects IQ imbalance by minimizing the correlation between the positive and negative parts of the signal spectrum.

| Parameter | Description |
|-----------|-------------|
| **Period** | The number of samples to process before updating the estimation. |
| **Alpha** | The learning rate or gain for the optimization algorithm (determines how fast it adapts). |
| **Message Port** | Outputs calculated correction parameters as messages for the "IQ Bal Fix" block. |

## Notes
- **Symmetrical Images**: This tool is essential when you see a strong signal at `+f` also appearing at `-f` relative to the center frequency.
- **Hardware vs. Software**: While some SDRs have hardware-level correction, `gr-iqbal` provides a software-based "blind" approach that works regardless of the frontend hardware.
- **Dependencies**: This module relies on `libgnuradio-runtime` and `libfftw3`. If you encounter shared library errors, ensure `libgnuradio-iqbalance` is correctly installed.