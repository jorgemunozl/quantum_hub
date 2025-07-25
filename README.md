# Music No Bother

A simple music player setup using mpv for background music playback with playlist management.

## Overview

This project provides scripts and aliases to play music downloaded from YouTube playlists using `yt-dlp`, with background playback using `mpv` and convenient keyboard controls.

## Features

- Download music from YouTube playlists using `yt-dlp`
- Background music playback with `mpv`
- Shuffle mode support
- Remote control via IPC socket
- Keyboard remapping for easy control

## Requirements

- `mpv` - Media player
- `yt-dlp` - YouTube downloader
- `socat` - Socket communication tool
- `nohup` - Run commands immune to hangups

## Installation

1. Install required dependencies:
```bash
# Ubuntu/Debian
sudo apt install mpv yt-dlp socat

# Arch Linux
sudo pacman -S mpv yt-dlp socat
```

## Usage

### Playing Music

Use the alias to start playing music in shuffle mode:

```bash
alias voice='nohup mpv --shuffle --input-ipc-server=/tmp/mpvsocket /home/jorge/Videos/music/voice/*.mp3 >/dev/null 2>&1 & disown; sleep 1; exit'
```

### Controlling Playback

To pause/unpause the music:

```bash
echo 'cycle pause' | socat - /tmp/mpvsocket
```

### Alternative Playback Command

For foreground playback:

```bash
mpv --input-ipc-server=/tmp/mpvsocket /home/jorge/Videos/music/*.mp3
```

## Configuration

### Setting up Aliases

Add this to your `~/.bashrc` or `~/.zshrc`:

```bash
alias voice='nohup mpv --shuffle --input-ipc-server=/tmp/mpvsocket /home/jorge/Videos/music/voice/*.mp3 >/dev/null 2>&1 & disown; sleep 1; exit'
```

### Keyboard Remapping

The commands can be remapped to keyboard shortcuts using your desktop environment's keyboard settings or tools like `xbindkeys`.

## Scripts

The project includes utility scripts for:
- Starting background music playback
- Controlling playback (pause/resume)
- Managing playlists

## Directory Structure

```
/home/jorge/Videos/music/
├── voice/           # Voice/podcast content
└── *.mp3           # Music files
```

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is open source and available under the [MIT License](LICENSE).
