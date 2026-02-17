---
name: aflplusplus
description: Perform instrumentation-driven fuzzing for binary formats using genetic algorithms to discover interesting test cases and trigger new internal states. Use when performing vulnerability research, security testing of parsers/libraries, or automated bug discovery in C/C++, Rust, and Go applications. Includes tools for corpus minimization, test case analysis, and distributed fuzzing.
---

# aflplusplus

## Overview
AFL++ is a superior fork of American Fuzzy Lop (AFL), an instrumentation-driven fuzzer that uses genetic algorithms to improve code coverage. It belongs to the Vulnerability Analysis and Fuzzing domains.

## Installation (if not already installed)
Assume AFL++ is installed. If not:
```bash
sudo apt install afl++
```

## Common Workflows

### 1. Instrument and Fuzz (Source Available)
```bash
# Compile with instrumentation
afl-clang-fast target.c -o target
# Start fuzzing
afl-fuzz -i in_dir -o out_dir -- ./target @@
```

### 2. Fuzzing a Binary-Only Target (QEMU Mode)
```bash
afl-fuzz -Q -i in_dir -o out_dir -- ./target_bin @@
```

### 3. Corpus Minimization
```bash
afl-cmin -i large_corpus -o minimized_corpus -- ./target @@
```

### 4. Test Case Minimization (Shrink a specific crash)
```bash
afl-tmin -i crash_file -o small_crash -- ./target @@
```

## Complete Command Reference

### afl-fuzz
The main fuzzer engine.
- `-i dir`: Input directory with test cases (use `-` to resume).
- `-o dir`: Output directory for findings.
- `-P strategy`: Mutation strategy: `explore` or `exploit`.
- `-p schedule`: Power schedule: `explore`, `fast`, `exploit`, `seek`, `rare`, `mmopt`, `coe`, `lin`, `quad`.
- `-f file`: Location read by fuzzed program (default: stdin or `@@`).
- `-t msec`: Timeout per run (add `+` for auto-calc).
- `-m megs`: Memory limit (default: 0, no limit).
- `-O`: FRIDA mode (binary-only).
- `-Q`: QEMU mode (binary-only).
- `-U`: Unicorn mode.
- `-W`: Wine mode.
- `-X`/`-Y`: Nyx mode (standalone/multiple).
- `-a type`: Input format: `text` or `binary`.
- `-g min`: Min generated input length.
- `-G max`: Max generated input length.
- `-x dict`: Dictionary file (up to 4).
- `-n`: Non-instrumented mode.
- `-M`/`-S id`: Distributed mode (Master/Secondary).
- `-V sec`: Fuzz for specific time.
- `-E execs`: Fuzz for specific execution count.
- `-C`: Crash exploration mode.

### afl-cc / afl-c++ / afl-clang-fast
Drop-in compiler replacements for instrumentation.
- Supports LLVM, LTO, and GCC_PLUGIN modes.
- Use `AFL_LLVM_CMPLOG=1` for comparison logging.
- Use `AFL_LLVM_LAF_ALL=1` for comparison splitting.

### afl-cmin
Corpus minimization tool.
- `-i dir`: Input corpus.
- `-o dir`: Output directory.
- `-T tasks`: Parallel processes.
- `-A`: Allow crashes/timeouts.
- `-C`: Keep only crashing inputs.
- `-e`: Edge coverage only.

### afl-tmin
Test case minimizer.
- `-i file`: Input test case.
- `-o file`: Output file.
- `-x`: Treat non-zero exit as crash.
- `-H`: Hang mode.

### afl-analyze
Tool to investigate the structure of a file and how the target reacts to it.
- `-i file`: Input test case.
- `-e`: Edge coverage only.

### afl-showmap
Displays coverage map for a specific input.
- `-o file`: Trace data output.
- `-C`: Collect coverage summary.
- `-r`: Show real tuple values.

### afl-whatsup
Status check for active fuzzing campaigns.
- `-d`: Include dead fuzzers.
- `-m`: Minimal stats.
- `-s`: Summary only.

### afl-plot
Generates progress graphs.
- `afl_state_dir`: Path to fuzzer output dir.
- `graph_output_dir`: Target directory for HTML/PNG files.

### afl-addseeds
Adds new seeds to a running campaign.
- `-o dir`: Active fuzzing output directory.
- `-i seed`: File or directory to add.

### System Configuration
- `afl-system-config`: Reconfigures system for high-performance fuzzing (CPU scaling, core dumps).
- `afl-persistent-config`: Permanent high-performance configuration.
- `afl-gotcpu`: Checks for available CPU resources.

## Notes
- **Performance**: Always run `afl-system-config` before fuzzing to ensure the CPU governor is set to `performance`.
- **Instrumentation**: Source-based instrumentation (`afl-clang-fast`) is significantly faster than binary-only modes (`-Q`, `-O`).
- **Memory**: Use `-m none` if the target is a modern heavy application to avoid OOM issues.