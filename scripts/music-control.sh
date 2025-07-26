#!/bin/bash

# Music Player Control Script
# Controls mpv player via IPC socket

# Load configuration
CONFIG_FILE="$HOME/.config/music-no-bother/config"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    # Default configuration
    SOCKET_PATH="/tmp/mpvsocket"
fi

# Function to check if mpv is running
check_mpv() {
    if [ ! -S "$SOCKET_PATH" ]; then
        echo "❌ mpv is not running or socket not found"
        echo "Start music with: $(basename "$(dirname "$0")")/start-music.sh"
        return 1
    fi
    return 0
}

# Function to send command to mpv
send_command() {
    local command="$1"
    echo "$command" | socat - "$SOCKET_PATH" 2>/dev/null
}

# Function to get mpv property
get_property() {
    local property="$1"
    echo "{ \"command\": [\"get_property\", \"$property\"] }" | socat - "$SOCKET_PATH" 2>/dev/null
}

# Function to show current status
show_status() {
    if ! check_mpv; then
        return 1
    fi
    
    echo "🎵 Music Player Status:"
    
    # Get pause status
    local pause_status=$(echo '{ "command": ["get_property", "pause"] }' | socat - "$SOCKET_PATH" 2>/dev/null)
    if [[ "$pause_status" == *"true"* ]]; then
        echo "   ⏸️  Paused"
    else
        echo "   ▶️  Playing"
    fi
    
    # Get current filename
    local filename=$(echo '{ "command": ["get_property", "filename"] }' | socat - "$SOCKET_PATH" 2>/dev/null)
    if [[ "$filename" != *"error"* ]]; then
        echo "   🎶 Current: $(echo "$filename" | grep -o '"data":"[^"]*"' | cut -d'"' -f4 | sed 's/.*\///' | sed 's/\.[^.]*$//')"
    fi
    
    # Get volume
    local volume=$(echo '{ "command": ["get_property", "volume"] }' | socat - "$SOCKET_PATH" 2>/dev/null)
    if [[ "$volume" != *"error"* ]]; then
        local vol_num=$(echo "$volume" | grep -o '"data":[0-9]*' | cut -d':' -f2)
        echo "   🔊 Volume: ${vol_num}%"
    fi
}

case "$1" in
    "pause"|"play"|"toggle")
        if check_mpv; then
            send_command "cycle pause"
            echo "⏯️  Toggled pause/play"
        fi
        ;;
    "stop")
        if check_mpv; then
            send_command "quit"
            echo "⏹️  Stopped playback"
        fi
        ;;
    "next")
        if check_mpv; then
            send_command "playlist-next"
            echo "⏭️  Next track"
        fi
        ;;
    "prev"|"previous")
        if check_mpv; then
            send_command "playlist-prev"
            echo "⏮️  Previous track"
        fi
        ;;
    "volume-up"|"vol+")
        if check_mpv; then
            send_command "add volume 5"
            echo "🔊 Volume up (+5%)"
        fi
        ;;
    "volume-down"|"vol-")
        if check_mpv; then
            send_command "add volume -5"
            echo "🔉 Volume down (-5%)"
        fi
        ;;
    "mute")
        if check_mpv; then
            send_command "cycle mute"
            echo "🔇 Toggled mute"
        fi
        ;;
    "shuffle")
        if check_mpv; then
            send_command "playlist-shuffle"
            echo "🔀 Shuffled playlist"
        fi
        ;;
    "status"|"info")
        show_status
        ;;
    "restart")
        if check_mpv; then
            echo "🔄 Restarting music..."
            send_command "quit"
            sleep 2
            "$(dirname "$0")/start-music.sh" music
        else
            echo "🔄 Starting music..."
            "$(dirname "$0")/start-music.sh" music
        fi
        ;;
    *)
        echo "🎵 Music Player Control"
        echo ""
        echo "Usage: $0 <command>"
        echo ""
        echo "Playback Control:"
        echo "  pause, play, toggle  - Toggle pause/play"
        echo "  stop                 - Stop playback and quit mpv"
        echo "  next                 - Next track"
        echo "  prev, previous       - Previous track"
        echo "  restart              - Restart music player"
        echo ""
        echo "Audio Control:"
        echo "  volume-up, vol+      - Increase volume by 5%"
        echo "  volume-down, vol-    - Decrease volume by 5%"
        echo "  mute                 - Toggle mute"
        echo ""
        echo "Playlist Control:"
        echo "  shuffle              - Shuffle current playlist"
        echo ""
        echo "Information:"
        echo "  status, info         - Show current status"
        echo ""
        echo "Examples:"
        echo "  $0 pause"
        echo "  $0 next"
        echo "  $0 status"
        exit 1
        ;;
esac
