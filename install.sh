#!/bin/bash

# Installation script for Music No Bother
# This script sets up the environment and creates necessary directories

echo "Setting up Music No Bother..."

# Create music directories
MUSIC_DIR="/home/jorge/Videos/music"
VOICE_DIR="/home/jorge/Videos/music/voice"

echo "Creating music directories..."
mkdir -p "$MUSIC_DIR"
mkdir -p "$VOICE_DIR"

# Check if required tools are installed
echo "Checking dependencies..."

MISSING_DEPS=()

if ! command -v mpv &> /dev/null; then
    MISSING_DEPS+=("mpv")
fi

if ! command -v yt-dlp &> /dev/null; then
    MISSING_DEPS+=("yt-dlp")
fi

if ! command -v socat &> /dev/null; then
    MISSING_DEPS+=("socat")
fi

if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
    echo "Missing dependencies: ${MISSING_DEPS[*]}"
    echo ""
    echo "Please install them:"
    echo "Ubuntu/Debian: sudo apt install ${MISSING_DEPS[*]}"
    echo "Arch Linux: sudo pacman -S ${MISSING_DEPS[*]}"
    echo "Or install yt-dlp with: pip install yt-dlp"
    exit 1
fi

echo "All dependencies found!"

# Make scripts executable
echo "Making scripts executable..."
chmod +x scripts/*.sh

# Create config directory
CONFIG_DIR="$HOME/.config/music-no-bother"
mkdir -p "$CONFIG_DIR"

# Copy example config if it doesn't exist
if [ ! -f "$CONFIG_DIR/config" ]; then
    cp config.example "$CONFIG_DIR/config"
    echo "Created config file at $CONFIG_DIR/config"
fi

# Get the absolute path to scripts
SCRIPT_DIR="$(pwd)/scripts"

echo ""
echo "Installation complete!"
echo ""
echo "Add these aliases to your ~/.bashrc or ~/.zshrc:"
echo "alias voice='$SCRIPT_DIR/start-music.sh voice'"
echo "alias music='$SCRIPT_DIR/start-music.sh music'"
echo "alias music-pause='$SCRIPT_DIR/music-control.sh pause'"
echo "alias music-stop='$SCRIPT_DIR/music-control.sh stop'"
echo "alias music-next='$SCRIPT_DIR/music-control.sh next'"
echo "alias music-prev='$SCRIPT_DIR/music-control.sh prev'"
echo ""
echo "Then reload your shell with: source ~/.bashrc"
echo ""
echo "Usage:"
echo "  voice                 - Start voice/podcast playback"
echo "  music                 - Start music playback"
echo "  music-pause           - Pause/resume playback"
echo "  music-stop            - Stop playback"
echo "  $SCRIPT_DIR/download-playlist.sh <url> [voice|music] - Download playlist"
