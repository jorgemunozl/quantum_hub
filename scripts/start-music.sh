#!/bin/bash

# Music Player Startup Script
# Starts mpv in background with shuffle mode

MUSIC_DIR="/home/jorge/Videos/music"
VOICE_DIR="/home/jorge/Videos/music/voice"
SOCKET_PATH="/tmp/mpvsocket"

# Function to start music playback
start_music() {
    local music_path="$1"
    
    # Check if music directory exists
    if [ ! -d "$music_path" ]; then
        echo "Error: Music directory '$music_path' not found"
        exit 1
    fi
    
    # Check if there are any mp3 files
    if ! ls "$music_path"/*.mp3 >/dev/null 2>&1; then
        echo "Error: No MP3 files found in '$music_path'"
        exit 1
    fi
    
    # Kill existing mpv instance if running
    if [ -S "$SOCKET_PATH" ]; then
        echo "Stopping existing mpv instance..."
        echo 'quit' | socat - "$SOCKET_PATH" 2>/dev/null
        sleep 1
    fi
    
    echo "Starting music playback from: $music_path"
    nohup mpv --shuffle --input-ipc-server="$SOCKET_PATH" "$music_path"/*.mp3 >/dev/null 2>&1 & disown
    
    sleep 1
    echo "Music started in background. Use music-control.sh to control playback."
}

# Function to start voice/podcast playback
start_voice() {
    start_music "$VOICE_DIR"
}

# Function to start regular music playback
start_all_music() {
    start_music "$MUSIC_DIR"
}

case "$1" in
    "voice")
        start_voice
        ;;
    "music"|"all")
        start_all_music
        ;;
    *)
        echo "Usage: $0 {voice|music|all}"
        echo ""
        echo "Commands:"
        echo "  voice    - Start voice/podcast playback"
        echo "  music    - Start music playback from main directory"
        echo "  all      - Start all music playback"
        exit 1
        ;;
esac
