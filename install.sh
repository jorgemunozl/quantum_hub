#!/bin/bash

# Installation script for Music No Bother
# This script sets up the environment and creates necessary directories

echo "🎵 Setting up Music No Bother..."
echo ""

# Get the absolute path to the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
SCRIPTS_PATH="$SCRIPT_DIR/scripts"

# Load default configuration
MUSIC_DIR="/home/jorge/Videos/music"
VOICE_DIR="/home/jorge/Videos/music/voice"

echo "📁 Creating music directories..."
mkdir -p "$MUSIC_DIR"
mkdir -p "$VOICE_DIR"
echo "   ✅ Created: $MUSIC_DIR"
echo "   ✅ Created: $VOICE_DIR"

echo ""
echo "🔍 Checking dependencies..."

MISSING_DEPS=()
OPTIONAL_DEPS=()

# Check required dependencies
if ! command -v mpv &> /dev/null; then
    MISSING_DEPS+=("mpv")
fi

if ! command -v socat &> /dev/null; then
    MISSING_DEPS+=("socat")
fi

# Check optional dependencies
if ! command -v yt-dlp &> /dev/null; then
    OPTIONAL_DEPS+=("yt-dlp")
fi

if ! command -v ffmpeg &> /dev/null; then
    OPTIONAL_DEPS+=("ffmpeg")
fi

# Report missing required dependencies
if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
    echo "❌ Missing required dependencies: ${MISSING_DEPS[*]}"
    echo ""
    echo "Install them with:"
    echo "   Ubuntu/Debian: sudo apt install ${MISSING_DEPS[*]}"
    echo "   Arch Linux: sudo pacman -S ${MISSING_DEPS[*]}"
    echo ""
    echo "Installation cannot continue without these dependencies."
    exit 1
fi

# Report missing optional dependencies
if [ ${#OPTIONAL_DEPS[@]} -ne 0 ]; then
    echo "⚠️  Missing optional dependencies: ${OPTIONAL_DEPS[*]}"
    echo "   These are needed for downloading music from YouTube."
    echo ""
    echo "Install them with:"
    for dep in "${OPTIONAL_DEPS[@]}"; do
        case "$dep" in
            "yt-dlp")
                echo "   yt-dlp: pip install yt-dlp"
                ;;
            "ffmpeg")
                echo "   ffmpeg: sudo apt install ffmpeg (Ubuntu/Debian)"
                echo "          sudo pacman -S ffmpeg (Arch Linux)"
                ;;
        esac
    done
    echo ""
fi

echo "✅ All required dependencies found!"

# Make scripts executable
echo ""
echo "🔧 Making scripts executable..."
chmod +x "$SCRIPTS_PATH"/*.sh
echo "   ✅ Scripts are now executable"

# Create config directory and file
CONFIG_DIR="$HOME/.config/music-no-bother"
CONFIG_FILE="$CONFIG_DIR/config"

echo ""
echo "⚙️  Setting up configuration..."
mkdir -p "$CONFIG_DIR"

if [ ! -f "$CONFIG_FILE" ]; then
    cp "$SCRIPT_DIR/config.example" "$CONFIG_FILE"
    echo "   ✅ Created config file: $CONFIG_FILE"
else
    echo "   ℹ️  Config file already exists: $CONFIG_FILE"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "🎵 Quick Start:"
echo "   $SCRIPTS_PATH/start-music.sh music     # Start music"
echo "   $SCRIPTS_PATH/music-control.sh pause   # Pause/resume"
echo "   $SCRIPTS_PATH/music-control.sh status  # Check status"
echo ""
echo "📥 Download music:"
echo "   $SCRIPTS_PATH/download-playlist.sh <youtube-url> music"
echo ""
echo "🔧 Setup shell aliases (recommended):"
echo "Add these lines to your ~/.bashrc or ~/.zshrc:"
echo ""
echo "# Music No Bother aliases"
echo "alias music='$SCRIPTS_PATH/start-music.sh music'"
echo "alias voice='$SCRIPTS_PATH/start-music.sh voice'"
echo "alias music-pause='$SCRIPTS_PATH/music-control.sh pause'"
echo "alias music-stop='$SCRIPTS_PATH/music-control.sh stop'"
echo "alias music-next='$SCRIPTS_PATH/music-control.sh next'"
echo "alias music-prev='$SCRIPTS_PATH/music-control.sh prev'"
echo "alias music-status='$SCRIPTS_PATH/music-control.sh status'"
echo "alias music-vol-up='$SCRIPTS_PATH/music-control.sh vol+'"
echo "alias music-vol-down='$SCRIPTS_PATH/music-control.sh vol-'"
echo "alias download-music='$SCRIPTS_PATH/download-playlist.sh'"
echo ""
echo "Then run: source ~/.bashrc"
echo ""
echo "🎹 Keyboard shortcuts:"
echo "Configure your desktop environment to bind these commands to keys:"
echo "   F9:  music-pause     # Pause/resume"
echo "   F10: music-prev      # Previous track" 
echo "   F11: music-next      # Next track"
echo "   F12: music-status    # Show status"
echo ""
echo "🆘 Need help?"
echo "   Run any script without arguments to see usage information"
echo "   Check the README.md for detailed documentation"
