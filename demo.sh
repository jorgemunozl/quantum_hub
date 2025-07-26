#!/bin/bash

# Demo script showing Music No Bother capabilities

echo "🎵 Music No Bother Demo"
echo "======================"
echo ""

SCRIPT_DIR="$(dirname "$0")"
SCRIPTS_PATH="$SCRIPT_DIR/scripts"

echo "This demo shows the main features of Music No Bother:"
echo ""

echo "1. 📥 Download music from YouTube:"
echo "   $SCRIPTS_PATH/download-playlist.sh 'https://youtube.com/playlist?list=...' music"
echo ""

echo "2. 🎵 Start music playback:"
echo "   $SCRIPTS_PATH/start-music.sh music"
echo "   $SCRIPTS_PATH/start-music.sh voice"
echo ""

echo "3. 🎛️  Control playback:"
echo "   $SCRIPTS_PATH/music-control.sh pause    # Pause/resume"
echo "   $SCRIPTS_PATH/music-control.sh next     # Next track"
echo "   $SCRIPTS_PATH/music-control.sh prev     # Previous track"
echo "   $SCRIPTS_PATH/music-control.sh vol+     # Volume up"
echo "   $SCRIPTS_PATH/music-control.sh vol-     # Volume down"
echo "   $SCRIPTS_PATH/music-control.sh status   # Show status"
echo ""

echo "4. ⚙️  Configuration:"
echo "   Edit ~/.config/music-no-bother/config for custom settings"
echo ""

echo "5. 🔧 Setup aliases (add to ~/.bashrc):"
echo "   alias music='$SCRIPTS_PATH/start-music.sh music'"
echo "   alias voice='$SCRIPTS_PATH/start-music.sh voice'"
echo "   alias music-pause='$SCRIPTS_PATH/music-control.sh pause'"
echo "   alias music-status='$SCRIPTS_PATH/music-control.sh status'"
echo ""

echo "🚀 Quick start:"
echo "   1. Run ./install.sh to set up the environment"
echo "   2. Download some music or add MP3 files to /home/jorge/Videos/music/"
echo "   3. Run './scripts/start-music.sh music' to start playing"
echo "   4. Use './scripts/music-control.sh status' to check what's playing"
echo ""

echo "📚 For more information, see README.md"
