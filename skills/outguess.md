---
name: outguess
description: Universal steganographic tool that allows the insertion and extraction of hidden information within redundant bits of data sources like JPEG, PPM, and PNM. Use when performing steganography, digital forensics, or secure communication by hiding data in images while optionally foiling statistical steganalysis.
---

# outguess

## Overview
OutGuess is a universal steganographic tool that identifies redundant bits in data sources to hide information. It features a data-handler system to support various formats (JPEG, PPM, PNM) and includes a mechanism to foil statistical steganalysis by preserving the original frequency distribution of bits. Category: Digital Forensics / Steganography.

## Installation (if not already installed)
Assume outguess is already installed. If you get a "command not found" error:

```bash
sudo apt install outguess
```

## Common Workflows

### Hiding a message in a JPEG image
```bash
outguess -k "secret-passphrase" -d message.txt input.jpg output.jpg
```
Hides the contents of `message.txt` inside `input.jpg` using a key, saving the result to `output.jpg`.

### Extracting a hidden message
```bash
outguess -k "secret-passphrase" -r output.jpg extracted.txt
```
Retrieves the hidden message from the image using the provided key.

### Hiding data with error correction and statistical foiling
```bash
outguess -e -F+ -k "mykey" -d secret.zip cover.jpg stego.jpg
```
Uses error-correcting encoding and explicitly enables statistical steganalysis foiling.

### Finding the best image for embedding
```bash
seek_script <image_directory> <message_file>
```
Uses the provided script to iterate through images to find the one that yields the best embedding results.

## Complete Command Reference

### outguess / outguess-extract
Both binaries share the same command-line interface for embedding and extracting data.

```
outguess [options] [<input file> [<output file>]]
```

| Flag | Description |
|------|-------------|
| `-h` | Print usage help text and exit |
| `-s <n>` | Iteration start for the first dataset |
| `-S <n>` | Iteration start for the second dataset |
| `-i <n>` | Iteration limit for the first dataset |
| `-I <n>` | Iteration limit for the second dataset |
| `-k <key>` | Key used for embedding or retrieving data |
| `-K <key>` | Key used for the second dataset |
| `-d <name>` | Filename of the dataset to be hidden |
| `-D <name>` | Filename of the second dataset to be hidden |
| `-e` | Use error correcting encoding for the first dataset |
| `-E` | Use error correcting encoding for the second dataset |
| `-p <param>` | Parameter passed to the destination data handler |
| `-r` | Retrieve message from the data (Extraction mode) |
| `-x <n>` | Number of key derivations to be tried |
| `-m` | Mark pixels that have been modified |
| `-t` | Collect statistic information during processing |
| `-F+` | Explicitly turn statistical steganalysis foiling ON (Default) |
| `-F-` | Turn statistical steganalysis foiling OFF |

### seek_script
A utility script used to automate the search for an optimal cover image.

```bash
seek_script <directory> <data_file>
```

## Notes
- **Supported Formats**: JPEG, PPM, and PNM.
- **Statistical Foiling**: OutGuess is unique because it attempts to preserve the frequency count of the redundant bits, making it harder for statistical tools to detect that steganography has occurred.
- **Two Datasets**: The tool supports embedding two different datasets (using lowercase vs. uppercase flags) to provide plausible deniability or multi-layered hiding.
- **Error Correction**: Using the `-e` flag increases the robustness of the hidden data but reduces the available embedding capacity.