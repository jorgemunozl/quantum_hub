#!/bin/bash

# Test script to verify Music No Bother installation

echo "🧪 Testing Music No Bother Installation"
echo ""

SCRIPT_DIR="$(dirname "$0")"
SCRIPTS_PATH="$SCRIPT_DIR/scripts"

# Test 1: Check if scripts exist and are executable
echo "📁 Checking script files..."
scripts=("start-music.sh" "music-control.sh" "download-playlist.sh")
for script in "${scripts[@]}"; do
    if [ -x "$SCRIPTS_PATH/$script" ]; then
        echo "   ✅ $script - executable"
    else
        echo "   ❌ $script - missing or not executable"
    fi
done

# Test 2: Check dependencies
echo ""
echo "🔍 Checking dependencies..."
deps=("mpv" "socat")
opt_deps=("yt-dlp" "ffmpeg")

for dep in "${deps[@]}"; do
    if command -v "$dep" &> /dev/null; then
        echo "   ✅ $dep - installed"
    else
        echo "   ❌ $dep - missing (required)"
    fi
done

for dep in "${opt_deps[@]}"; do
    if command -v "$dep" &> /dev/null; then
        echo "   ✅ $dep - installed"
    else
        echo "   ⚠️  $dep - missing (optional, for downloading)"
    fi
done

# Test 3: Check configuration
echo ""
echo "⚙️  Checking configuration..."
CONFIG_DIR="$HOME/.config/music-no-bother"
CONFIG_FILE="$CONFIG_DIR/config"

if [ -d "$CONFIG_DIR" ]; then
    echo "   ✅ Config directory exists: $CONFIG_DIR"
else
    echo "   ⚠️  Config directory missing: $CONFIG_DIR"
fi

if [ -f "$CONFIG_FILE" ]; then
    echo "   ✅ Config file exists: $CONFIG_FILE"
else
    echo "   ⚠️  Config file missing: $CONFIG_FILE"
fi

# Test 4: Check music directories
echo ""
echo "📁 Checking music directories..."
MUSIC_DIR="/home/jorge/Videos/music"
VOICE_DIR="/home/jorge/Videos/music/voice"

if [ -d "$MUSIC_DIR" ]; then
    echo "   ✅ Music directory exists: $MUSIC_DIR"
else
    echo "   ⚠️  Music directory missing: $MUSIC_DIR"
fi

if [ -d "$VOICE_DIR" ]; then
    echo "   ✅ Voice directory exists: $VOICE_DIR"
else
    echo "   ⚠️  Voice directory missing: $VOICE_DIR"
fi

# Test 5: Test script help output
echo ""
echo "📖 Testing script help output..."
if "$SCRIPTS_PATH/start-music.sh" >/dev/null 2>&1; then
    echo "   ✅ start-music.sh responds to commands"
else
    echo "   ❌ start-music.sh not responding"
fi

if "$SCRIPTS_PATH/music-control.sh" >/dev/null 2>&1; then
    echo "   ✅ music-control.sh responds to commands"
else
    echo "   ❌ music-control.sh not responding"
fi

echo ""
echo "🎵 Test completed!"
echo ""
echo "💡 Quick test commands:"
echo "   $SCRIPTS_PATH/start-music.sh status   # Check if music is playing"
echo "   $SCRIPTS_PATH/music-control.sh status # Show player status"
echo ""
echo "🚀 To start using:"
echo "   ./install.sh                          # Run installation if not done"
echo "   $SCRIPTS_PATH/start-music.sh music    # Start music (if you have audio files)"
