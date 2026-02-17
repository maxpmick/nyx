---
name: instaloader
description: Download photos, videos, stories, highlights, and metadata from Instagram profiles, hashtags, and locations. Use when performing OSINT on Instagram accounts, archiving social media content, or gathering media evidence during investigations. Supports public and private profiles (with login), post filtering, and automatic directory management.
---

# instaloader

## Overview
Instaloader is a powerful Python-based tool for downloading media and metadata from Instagram. It can retrieve posts, stories, highlights, tagged posts, reels, and IGTV videos from profiles, hashtags, or location IDs. It supports session handling to access private content and provides granular filtering for targeted data collection. Category: Reconnaissance / Information Gathering.

## Installation (if not already installed)
Instaloader is typically pre-installed on Kali Linux. If missing:

```bash
sudo apt update && sudo apt install instaloader
```

## Common Workflows

### Download a public profile
```bash
instaloader profile_name
```

### Download a profile with stories and highlights (Requires Login)
```bash
instaloader --login your_username --stories --highlights target_profile
```

### Download a hashtag with a limit
```bash
instaloader --count 100 "#osint"
```

### Update an existing archive (Fast Update)
```bash
instaloader --fast-update --login your_username :feed
```
Stops downloading once it encounters the first already-downloaded picture.

### Filter posts by likes
```bash
instaloader --post-filter="likes > 100" target_profile
```

## Complete Command Reference

### Positional Arguments / Targets
| Target | Description |
|------|-------------|
| `profile` | Download a specific profile. |
| `@profile` | Download all followees of the profile (Requires login). |
| `"#hashtag"` | Download posts with the specified hashtag. |
| `%location_id` | Download posts from a location ID (Requires login). |
| `:feed` | Download pictures from your own feed (Requires login). |
| `:stories` | Download stories of your followees (Requires login). |
| `:saved` | Download your saved posts (Requires login). |
| `-- -shortcode` | Download a specific post by its shortcode. |
| `filename.json[.xz]` | Re-download a specific object from a metadata file. |
| `+args.txt` | Read targets and options from a text file. |

### Post Content Options
| Flag | Description |
|------|-------------|
| `--slide SLIDE` | Set specific image/interval of a sidecar (carousel) to download. |
| `--no-pictures` | Do not download post pictures. Implies `--no-video-thumbnails`. |
| `-V, --no-videos` | Do not download videos. |
| `--no-video-thumbnails` | Do not download thumbnails of videos. |
| `-G, --geotags` | Download geotags (stored as text with Google Maps link). Requires login. |
| `-C, --comments` | Download and update comments for each post. Requires login. |
| `--no-captions` | Do not create .txt files for captions. |
| `--post-metadata-txt TEMPLATE` | Template for the text file written for each Post. |
| `--storyitem-metadata-txt TEMPLATE` | Template for the text file written for each StoryItem. |
| `--no-metadata-json` | Do not create JSON metadata files. |
| `--no-compress-json` | Create pretty-formatted JSONs instead of xz compressed files. |

### Profile Specific Options
| Flag | Description |
|------|-------------|
| `--no-posts` | Do not download regular posts. |
| `--no-profile-pic` | Do not download the profile picture. |
| `-s, --stories` | Download stories of the target profile. Requires login. |
| `--highlights` | Download highlights of the target profile. Requires login. |
| `--tagged` | Download posts where the profile is tagged. |
| `--reels` | Download Reels videos. |
| `--igtv` | Download IGTV videos. |

### Filtering and Selection
| Flag | Description |
|------|-------------|
| `-F, --fast-update` | Stop when encountering the first already-downloaded picture. |
| `--latest-stamps [FILE]` | Store timestamps of latest media to allow updates even if directories are deleted. |
| `--post-filter EXPR` | Python expression to filter posts (e.g., `viewer_has_liked`). |
| `--storyitem-filter EXPR` | Python expression to filter story items. |
| `-c, --count COUNT` | Max number of posts to download (hashtags, locations, feed, saved). |

### Login and Session Options
| Flag | Description |
|------|-------------|
| `-l, --login USER` | Instagram username for login. |
| `-b, --load-cookies BROWSER` | Load cookies from a browser (e.g., chrome, firefox). |
| `-B, --cookiefile FILE` | Load cookies from a specific file. |
| `-f, --sessionfile FILE` | Path to session file. Defaults to `~/.config/instaloader/session-<user>`. |
| `-p, --password PASS` | Password for the account. If omitted, prompt is interactive. |

### Download Configuration
| Flag | Description |
|------|-------------|
| `--dirname-pattern PATTERN` | Directory naming scheme. Default: `{target}`. |
| `--filename-pattern PATTERN` | Filename naming scheme. Default: `{date_utc}_UTC`. |
| `--title-pattern PATTERN` | Filename prefix for profile pics/covers. |
| `--resume-prefix PREFIX` | Prefix for resume information files. |
| `--sanitize-paths` | Ensure filenames are valid on both Windows and Unix. |
| `--no-resume` | Do not resume aborted downloads or save resume info. |
| `--user-agent UA` | Custom HTTP User Agent. |
| `--max-connection-attempts N` | Max retries (Default: 3). Set 0 for infinite. |
| `--request-timeout N` | Connection timeout in seconds (Default: 300). |
| `--abort-on CODES` | Comma-separated HTTP status codes to trigger immediate abort. |
| `--no-iphone` | Do not download iPhone-specific versions of media. |

### Miscellaneous
| Flag | Description |
|------|-------------|
| `-q, --quiet` | Disable user interaction and non-error messages. |
| `-h, --help` | Show help message. |
| `--version` | Show version number. |

## Notes
- **Rate Limiting**: Instagram aggressively rate-limits requests. Using `--fast-update` and avoiding excessive `--comments` or `--geotags` flags helps prevent bans.
- **Private Profiles**: You must follow a private profile with the account used in `--login` to download its content.
- **Session Files**: Instaloader saves session cookies to avoid repeated logins. Protect these files as they grant access to your account.