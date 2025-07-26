# Music No Bother

A simple music player setup using mpv for background music playback with playlist management.

## Overview

This project provides scripts and aliases to play music downloaded from YouTube playlists using `yt-dlp`, with background playback using `mpv` and convenient keyboard controls.

## Features

- 📥 Download music from YouTube playlists using `yt-dlp`
- 🎵 Background music playback with `mpv`
- 🔀 Shuffle mode and infinite playlist loop
- 🎛️ Remote control via IPC socket
- ⌨️ Keyboard remapping support
- 📁 Separate directories for music and voice content
- 🎚️ Volume control and mute functionality
- 📊 Playback status and current track display
- 🔄 Easy restart and playlist management
- ⚙️ Configurable settings

## Requirements

- `mpv` - Media player
- `socat` - Socket communication tool  
- `yt-dlp` - YouTube downloader (optional, for downloading)
- `ffmpeg` - Audio processing (optional, for downloading)
- `nohup` - Run commands immune to hangups (usually pre-installed)

## Installation

1. Clone the repository:
```bash
git clone git@github.com:jorgemunozl/musicNoBother.git
cd musicNoBother
```

2. Run the installation script:
```bash
./install.sh
```

3. Install dependencies if not already installed:
```bash
# Ubuntu/Debian
sudo apt install mpv socat ffmpeg
pip install yt-dlp

# Arch Linux
sudo pacman -S mpv socat ffmpeg
pip install yt-dlp
```

## Usage

### Quick Start

After installation, use these simple commands:

```bash
# Start music playback
music

# Start voice/podcast playback  
voice

# Control playback
music-pause      # Pause/resume
music-next       # Next track
music-prev       # Previous track
music-stop       # Stop playback
music-status     # Show current status
```

### Download Music

Download YouTube playlists or individual videos:

```bash
# Download to music directory
./scripts/download-playlist.sh "https://youtube.com/playlist?list=..." music

# Download to voice directory (for podcasts)
./scripts/download-playlist.sh "https://youtube.com/playlist?list=..." voice

# Download with custom folder name
./scripts/download-playlist.sh "https://youtube.com/playlist?list=..." music "My Playlist"
```

### Manual Commands

If you haven't set up aliases, use the scripts directly:

```bash
# Start playback
./scripts/start-music.sh music
./scripts/start-music.sh voice

# Control playback
./scripts/music-control.sh pause
./scripts/music-control.sh next
./scripts/music-control.sh status
```

## Configuration

### Automatic Setup

The installation script automatically:
- Creates music directories
- Sets up configuration files
- Makes scripts executable
- Provides shell aliases for easy use

### Custom Configuration

Edit `~/.config/music-no-bother/config` to customize:
- Music directory paths
- Audio quality and format for downloads
- Default volume settings
- MPV playback options

### Shell Aliases

Add these to your `~/.bashrc` or `~/.zshrc` for quick access:

```bash
# Basic control
alias music='~/path/to/scripts/start-music.sh music'
alias voice='~/path/to/scripts/start-music.sh voice'
alias music-pause='~/path/to/scripts/music-control.sh pause'
alias music-status='~/path/to/scripts/music-control.sh status'

# Advanced control
alias music-next='~/path/to/scripts/music-control.sh next'
alias music-prev='~/path/to/scripts/music-control.sh prev'
alias music-vol-up='~/path/to/scripts/music-control.sh vol+'
alias music-vol-down='~/path/to/scripts/music-control.sh vol-'
```

### Keyboard Shortcuts

Map these commands to function keys or custom shortcuts:
- `F9`: music-pause (pause/resume)
- `F10`: music-prev (previous track)
- `F11`: music-next (next track)  
- `F12`: music-status (show status)

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
