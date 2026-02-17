---
name: sleuthkit
description: Analyze disk images and file systems for digital forensics. Use when performing volume system analysis, recovering deleted files, examining file system metadata, or creating timelines of file activity. It supports various partition types (GPT, DOS) and file systems (NTFS, FAT, Ext3/4, HFS+).
---

# sleuthkit

## Overview
The Sleuth Kit (TSK) is a collection of command-line tools for forensic analysis of disk images. It allows for non-intrusive examination of file systems, showing deleted and hidden content by bypassing the operating system's file system processing. Category: Digital Forensics / Respond.

## Installation (if not already installed)
Assume the tools are installed. If missing:
```bash
sudo apt install sleuthkit
```

## Common Workflows

### List Partitions in a Disk Image
```bash
mmls evidence.img
```

### List Files in a Specific Partition
Use the offset found from `mmls` (e.g., 2048):
```bash
fls -o 2048 -r evidence.img
```

### Recover All Files from a Partition
```bash
tsk_recover -e -o 2048 evidence.img ./recovered_files
```

### Create a Timeline of File Activity
```bash
tsk_gettimes -o 2048 evidence.img > bodyfile.txt
mactime -b bodyfile.txt -y > timeline.csv
```

## Complete Command Reference

### Volume System Tools

#### mmls
Display the partition layout.
- `-t vstype`: Volume system type (use `-t list` for types)
- `-i imgtype`: Image format (use `-i list` for types)
- `-b dev_sector_size`: Sector size in bytes
- `-o imgoffset`: Offset to start of volume system (in sectors)
- `-B`: Print rounded length in bytes
- `-r`: Recurse into partition tables (DOS only)
- `-a`: Show allocated volumes
- `-A`: Show unallocated volumes
- `-m`: Show metadata volumes
- `-M`: Hide metadata volumes
- `-v`: Verbose
- `-V`: Version

#### mmcat
Output partition contents.
- `-t vstype`, `-i imgtype`, `-b dev_sector_size`, `-o imgoffset`, `-v`, `-V`: (Same as mmls)
- `part_num`: Partition number to extract

#### mmstat
Display volume system details.
- `-t vstype`, `-i imgtype`, `-b dev_sector_size`, `-o imgoffset`, `-v`, `-V`: (Same as mmls)

### File System Tools

#### fls
List file and directory names.
- `-a`: Display "." and ".." entries
- `-d`: Deleted entries only
- `-D`: Directories only
- `-F`: Files only
- `-l`: Long version
- `-m dir/`: Mactime input format
- `-h`: Include MD5 in mactime output
- `-p`: Display full path
- `-r`: Recursive
- `-u`: Undeleted entries only
- `-z ZONE`: Time zone
- `-s seconds`: Time skew
- `-k password`: Decryption password
- `-f fstype`: File system type (use `-f list`)
- `-o imgoffset`: Offset into image (in sectors)
- `-P pooltype`, `-B pool_volume_block`, `-S snap_id`: Pool/Snapshot options

#### icat
Output file contents by inode.
- `-h`: Skip holes in sparse files
- `-r`: Recover deleted file
- `-R`: Recover and suppress errors
- `-s`: Display slack space
- `-i`, `-b`, `-f`, `-o`, `-P`, `-B`, `-S`, `-v`, `-V`, `-k`: (Standard FS options)

#### fcat
Output file contents by name.
- `-h`, `-R`, `-s`, `-i`, `-b`, `-f`, `-o`, `-P`, `-B`, `-v`, `-V`: (Standard FS options)

#### fsstat
Display general file system details.
- `-t`: Display type only
- `-k password`: Decryption password
- `-i`, `-b`, `-f`, `-o`, `-P`, `-B`, `-v`, `-V`: (Standard FS options)

#### istat
Display inode details.
- `-N num`: Force display of block pointers
- `-r`: Display run list
- `-z zone`, `-s seconds`: Time settings
- `-i`, `-b`, `-f`, `-o`, `-P`, `-B`, `-S`, `-v`, `-V`, `-k`: (Standard FS options)

#### ifind
Find inode for a data unit or filename.
- `-a`: Find all inodes
- `-d unit_addr`: Find inode given data unit
- `-n file`: Find inode given filename
- `-p par_addr`: Find unallocated MFT entries (NTFS)
- `-l`: Long format
- `-z ZONE`: Time zone

#### ils
List inode information.
- `-e`: All inodes
- `-m`: Mactime format
- `-O`: Unallocated but open (UFS/ExtX)
- `-p`: Orphan inodes
- `-a`/`-A`: Allocated/Unallocated
- `-l`/`-L`: Linked/Unlinked
- `-z`/`-Z`: Unused/Used

### Data Unit Tools

#### blkcat
Display data unit contents.
- `-a`: ASCII
- `-h`: Hexdump
- `-w`: HTML
- `-s`: Block stats
- `-u usize`: Unit size

#### blkls
List/output data units.
- `-e`: Every block
- `-l`: Time machine list format
- `-a`/`-A`: Allocated/Unallocated
- `-s`: Slack space only

#### blkstat
Display data unit details.
- `-f`, `-i`, `-b`, `-o`, `-P`, `-B`, `-v`, `-V`: (Standard FS options)

#### blkcalc
Convert unit numbers.
- `-d`: From 'dd' image
- `-s`: From 'blkls -s' (slack)
- `-u`: From 'blkls' (unallocated)

### Timeline & Database Tools

#### tsk_gettimes
Collect MAC times into a body file.
- `-m`: Calculate MD5 (slow)
- `-z zone`, `-s seconds`: Time settings

#### mactime
Create timeline from body file.
- `-b body_file`: Input file (default STDIN)
- `-d`: CSV format
- `-h`: Header
- `-y`: ISO 8601 dates
- `-m`: Numeric months
- `-z zone`: Timezone
- `-g group_file`, `-p password_file`: GID/UID mapping

#### tsk_loaddb
Populate SQLite database from image.
- `-a`: Add to existing DB
- `-k`: No block data table
- `-h`: Calculate hashes
- `-d database`: DB path
- `-z ZONE`: Time zone

### Recovery & Comparison

#### tsk_recover
Export files to local directory.
- `-a`: Allocated only
- `-e`: All files (allocated + unallocated)
- `-d dir_inum`: Start from specific directory

#### tsk_comparedir
Compare local directory with image.
- `-n start_inum`: Starting inode in image

### Miscellaneous Tools

#### fiwalk
Print FS statistics and metadata.
- `-n pattern`: Match filename
- `-I`: Ignore NTFS system files
- `-g`: Report objects only (no data)
- `-O`: Allocated only
- `-z`: No MD5/SHA1
- `-M`/`-1`: Report MD5/SHA1 (default on)
- `-f`: Run 'file' command
- `-m`: Body file output
- `-X file`: XML output

#### hfind
Lookup hash in database.
- `-e`: Extended mode
- `-q`: Quick mode (1/0)
- `-c db_name`: Create new DB
- `-a`: Add hashes to DB
- `-f lookup_file`: File with hashes
- `-i db_type`: Index type (nsrl-md5, nsrl-sha1, md5sum, encase, hk)

#### sorter
Categorize files by type.
- `-s`: Save files to category dirs
- `-h`: HTML format
- `-md5`/`-sha1`: Print hashes
- `-a hash_alert`: Alert DB
- `-x hash_exclude`: Exclude DB
- `-n nsrl_db`: NSRL DB

#### sigfind
Find binary signature.
- `-b bsize`: Block size
- `-o offset`: Offset in block
- `-l`: Little endian
- `-t template`: Structure template (ntfs, fat, ext4, etc.)

#### srch_strings
Display printable strings.
- `-a`: Scan entire file
- `-f`: Print filename
- `-n number`: Min string length
- `-t {o,x,d}`: Radix (octal, hex, decimal)
- `-e {s,S,b,l,B,L}`: Encoding (7-bit, 8-bit, 16-bit, 32-bit)

#### jpeg_extract
Extract/manipulate JPEG EXIF data.
- `-e`: Extract thumbnail
- `-l`: List tags
- `-t tag`: Select tag
- `-o FILE`: Output file

#### jls / jcat
Journal tools.
- `jls`: List journal contents
- `jcat`: View specific journal block

#### usnjls
List NTFS USN journal.
- `-l`: Long format
- `-m`: Time machine format

## Notes
- Always identify the partition offset using `mmls` before running file system tools like `fls` or `icat`.
- Use `-f list` and `-i list` to see supported file systems and image formats.
- Forensic analysis should be performed on a copy of the evidence image, never the original.