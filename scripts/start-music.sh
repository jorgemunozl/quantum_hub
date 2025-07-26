#!/bin/bash

# Music Player Startup Script
# Starts mpv in background with shuffle mode

# Load configuration
CONFIG_FILE="$HOME/.config/music-no-bother/config"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    # Default configuration
    MUSIC_DIR="/home/jorge/Videos/music"
    VOICE_DIR="/home/jorge/Videos/music/voice"
    SOCKET_PATH="/tmp/mpvsocket"
fi

# Function to start music playback
start_music() {
    local music_path="$1"
    local category="${2:-music}"
    
    # Create directory if it doesn't exist
    if [ ! -d "$music_path" ]; then
        echo "📁 Creating music directory: $music_path"
        mkdir -p "$music_path"
    fi
    
    # Check if there are any audio files
    local audio_files=(
        "$music_path"/*.mp3
        "$music_path"/*.m4a
        "$music_path"/*.flac
        "$music_path"/*.ogg
        "$music_path"/*.wav
    )
    
    local found_files=()
    for pattern in "${audio_files[@]}"; do
        if ls $pattern >/dev/null 2>&1; then
            found_files+=($pattern)
            break
        fi
    done
    
    if [ ${#found_files[@]} -eq 0 ]; then
        echo "❌ No audio files found in '$music_path'"
        echo "💡 Download some music first with:"
        echo "   $(dirname "$0")/download-playlist.sh <playlist_url> $category"
        exit 1
    fi
    
    # Kill existing mpv instance if running
    if [ -S "$SOCKET_PATH" ]; then
        echo "🔄 Stopping existing mpv instance..."
        echo 'quit' | socat - "$SOCKET_PATH" 2>/dev/null
        sleep 1
        # Clean up socket if it still exists
        [ -S "$SOCKET_PATH" ] && rm -f "$SOCKET_PATH"
    fi
    
    echo "🎵 Starting $category playback from: $music_path"
    echo "🔀 Shuffle mode: ON"
    
    # Start mpv with better options
    nohup mpv \
        --shuffle \
        --input-ipc-server="$SOCKET_PATH" \
        --no-video \
        --volume=70 \
        --playlist-start=random \
        --loop-playlist=inf \
        --really-quiet \
        "$music_path"/*{.mp3,.m4a,.flac,.ogg,.wav} \
        >/dev/null 2>&1 & disown
    
    sleep 2
    
    # Verify mpv started successfully
    if [ -S "$SOCKET_PATH" ]; then
        echo "✅ Music started successfully!"
        echo "🎛️  Use 'music-control.sh status' to check playback"
        echo "⏯️  Use 'music-control.sh pause' to pause/resume"
    else
        echo "❌ Failed to start mpv. Check if mpv is installed."
        exit 1
    fi
}

# Function to start voice/podcast playback
start_voice() {
    start_music "$VOICE_DIR" "voice"
}

# Function to start regular music playback
start_all_music() {
    start_music "$MUSIC_DIR" "music"
}

# Function to show currently playing
show_current() {
    if [ -S "$SOCKET_PATH" ]; then
        "$(dirname "$0")/music-control.sh" status
    else
        echo "❌ No music currently playing"
        echo "💡 Start music with: $0 {voice|music}"
    fi
}

case "$1" in
    "voice")
        start_voice
        ;;
    "music"|"all")
        start_all_music
        ;;
    "status"|"current")
        show_current
        ;;
    *)
        echo "🎵 Music Player Startup"
        echo ""
        echo "Usage: $0 <command>"
        echo ""
        echo "Commands:"
        echo "  voice          - Start voice/podcast playback"
        echo "  music, all     - Start music playback"
        echo "  status, current - Show what's currently playing"
        echo ""
        echo "Examples:"
        echo "  $0 voice       # Start podcasts/voice content"
        echo "  $0 music       # Start music"
        echo "  $0 status      # Check what's playing"
        exit 1
        ;;
esac
