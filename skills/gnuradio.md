---
name: gnuradio
description: A software development toolkit that provides signal processing blocks to implement software-defined radios (SDR). Use when designing, simulating, or deploying radio systems, performing RF analysis, signal decoding, or wireless security research involving hardware like USRP, RTL-SDR, or HackRF.
---

# gnuradio

## Overview
GNU Radio is a framework for signal processing and software-defined radio. It includes a graphical editor (GNU Radio Companion), command-line utilities for plotting and analysis, and hardware interface tools for UHD-compatible devices. Category: Wireless Attacks / SDR.

## Installation (if not already installed)
Assume gnuradio is already installed. If missing:
```bash
sudo apt install gnuradio
```

## Common Workflows

### Launch Graphical Flowgraph Editor
```bash
gnuradio-companion
```

### Plot a Captured Binary Signal File
```bash
gr_plot -d complex64 -R 2000000 capture.bin
```

### Live FFT Spectrum Analysis (USRP)
```bash
uhd_fft -f 2.4G -s 5M -g 30
```

### Record RF Data to File
```bash
uhd_rx_cfile -f 433.9M -r 1M -g 20 capture.complex
```

## Complete Command Reference

### gnuradio-companion
Graphical tool for creating signal flowgraphs.
```bash
gnuradio-companion [options] [flow_graphs ...]
```
| Flag | Description |
|------|-------------|
| `-h, --help` | Show help message |
| `--log {debug,info,warning,error,critical}` | Set logging level |
| `--qt` | Use QT framework |
| `--gtk` | Use GTK framework |

### gr_plot
Display time series of samples from a file.
| Flag | Description |
|------|-------------|
| `-d, --data-type` | {complex64, float32, uint32, int32, uint16, int16, uint8, int8} |
| `-B, --block` | Specify block size [default=1000] |
| `-s, --start` | Specify start position in file [default=0] |
| `-R, --sample-rate` | Set sample rate of the data [default=1.0] |

### gr_plot_psd
GNU Radio power spectrum plotting.
| Flag | Description |
|------|-------------|
| `--psd-size` | Set size of PSD FFT [default=1024] |
| `--spec-size` | Set size of spectrogram FFT [default=256] |
| `-S, --enable-spec` | Turn on plotting the spectrogram |

### gr_modtool
Tool for editing out-of-tree modules.
| Command | Description |
|---------|-------------|
| `add` | Adds a block to the module |
| `bind` | Generate Python bindings |
| `disable` | Disable selected block |
| `info` | Return module information |
| `makeyaml` | Generate YAML for GRC bindings |
| `newmod` | Create new empty module |
| `rm` | Remove a block |

### uhd_fft
Display spectrum from UHD receiver.
| Flag | Description |
|------|-------------|
| `-a, --args` | UHD device address args |
| `-f, --freq` | Set carrier frequency |
| `-s, --samp-rate` | Sample rate |
| `-g, --gain` | Gain in dB |
| `-A, --antenna` | Select Rx antenna |
| `--fft-size` | Set number of FFT bins |
| `--fft-average` | {off, low, medium, high} |

### uhd_rx_cfile
Save UHD received data to a file.
| Flag | Description |
|------|-------------|
| `-f, --freq` | Set frequency |
| `-r, --samp-rate` | Set sample rate [default=1M] |
| `-N, --nsamples` | Number of samples to collect [default=+inf] |
| `-s, --output-shorts` | Output interleaved shorts instead of complex floats |
| `-m, --metafile` | Output metadata to file |

### uhd_siggen / uhd_siggen_gui
Signal Generator using UHD hardware.
| Flag | Description |
|------|-------------|
| `-m, --amplitude` | Set output amplitude (0.0-1.0) |
| `-x, --waveform-freq` | Set baseband waveform frequency |
| `--sine` | Generate complex sine wave |
| `--const` | Generate constant carrier |
| `--gaussian` | Generate Gaussian random output |
| `--sweep` | Generate swept sine wave |
| `-q` | Show QT Frequency Widget (uhd_siggen_gui only) |

### gnuradio-config-info
| Flag | Description |
|------|-------------|
| `--print-all` | Print all system info |
| `--prefix` | Print installation prefix |
| `--enabled-components` | Print build-time enabled components |
| `-v, --version` | Print version |

### grcc
Compile GRC files into Python programs.
| Flag | Description |
|------|-------------|
| `-o, --output` | Output directory |
| `-r, --run` | Run program after compiling |

### Other Utilities
- **gr-ctrlport-monitor**: `gr-ctrlport-monitor [host] port` - Control port GUI.
- **gr-perf-monitorx**: `gr-perf-monitorx [host] port` - Performance monitor.
- **gr_filter_design**: GUI for creating filters.
- **gr_read_file_metadata**: `gr_read_file_metadata [-D] FILE` - Read GRC metadata headers.
- **polar_channel_construction**: `-c {BEC,AWGN} -b BLOCK_SIZE -s SNR` - Polar code constructor.

## Notes
- GNU Radio binary files typically use `.bin`, `.dat`, or `.complex` extensions.
- When using UHD tools, ensure your USRP hardware is connected and `uhd_find_devices` can see it.
- Default data type for most plotting tools is `complex64`.