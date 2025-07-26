#!/bin/bash

# YouTube Playlist Downloader Script
# Downloads music from YouTube playlists using yt-dlp

# Load configuration
CONFIG_FILE="$HOME/.config/music-no-bother/config"
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    # Default configuration
    MUSIC_DIR="/home/jorge/Videos/music"
    VOICE_DIR="/home/jorge/Videos/music/voice"
    AUDIO_QUALITY=0
    AUDIO_FORMAT="mp3"
fi

# Function to show progress
show_progress() {
    echo "⏳ $1"
}

# Function to download playlist
download_playlist() {
    local url="$1"
    local output_dir="$2"
    local category="$3"
    
    if [ -z "$url" ] || [ -z "$output_dir" ]; then
        echo "❌ URL and output directory are required"
        exit 1
    fi
    
    # Validate URL
    if [[ ! "$url" =~ ^https?://(www\.)?(youtube\.com|youtu\.be) ]]; then
        echo "❌ Invalid YouTube URL. Please provide a valid YouTube URL."
        exit 1
    fi
    
    # Create output directory if it doesn't exist
    mkdir -p "$output_dir"
    
    echo "🎵 YouTube Playlist Downloader"
    echo "📂 Output directory: $output_dir"
    echo "🔗 Playlist URL: $url"
    echo "🎚️  Audio quality: $AUDIO_QUALITY (0=best, 9=worst)"
    echo "📁 Format: $AUDIO_FORMAT"
    echo ""
    
    show_progress "Starting download..."
    
    # Check available formats first
    echo "🔍 Checking available formats..."
    
    # Download with yt-dlp with better options
    yt-dlp \
        --extract-audio \
        --audio-format "$AUDIO_FORMAT" \
        --audio-quality "$AUDIO_QUALITY" \
        --output "$output_dir/%(uploader)s - %(title)s.%(ext)s" \
        --ignore-errors \
        --no-playlist-reverse \
        --write-info-json \
        --write-thumbnail \
        --embed-metadata \
        --add-metadata \
        --progress \
        --no-warnings \
        --playlist-end 50 \
        "$url"
    
    local exit_code=$?
    
    if [ $exit_code -eq 0 ]; then
        echo ""
        echo "✅ Download completed successfully!"
        echo "📂 Files saved to: $output_dir"
        
        # Count downloaded files
        local file_count=$(find "$output_dir" -name "*.${AUDIO_FORMAT}" -type f | wc -l)
        echo "📊 Downloaded: $file_count audio files"
        
        # Ask if user wants to start playing
        echo ""
        read -p "🎵 Start playing now? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            "$(dirname "$0")/start-music.sh" "$category"
        fi
        
    else
        echo ""
        echo "❌ Download failed (exit code: $exit_code)"
        echo "💡 Possible issues:"
        echo "   - Invalid URL"
        echo "   - Network connection problems"
        echo "   - Age-restricted or private videos"
        echo "   - yt-dlp needs updating: pip install --upgrade yt-dlp"
        exit 1
    fi
}

# Function to show usage
show_usage() {
    echo "🎵 YouTube Playlist Downloader"
    echo ""
    echo "Usage: $0 <playlist_url> [voice|music] [playlist_name]"
    echo ""
    echo "Arguments:"
    echo "  playlist_url    - YouTube playlist URL"
    echo "  voice|music     - Download to voice or music directory (default: music)"
    echo "  playlist_name   - Optional playlist name for organization"
    echo ""
    echo "Examples:"
    echo "  $0 'https://youtube.com/playlist?list=...' music"
    echo "  $0 'https://youtube.com/playlist?list=...' voice 'Podcasts'"
    echo "  $0 'https://youtu.be/...' music 'Single Song'"
    echo ""
    echo "Configuration:"
    echo "  Edit ~/.config/music-no-bother/config to change default settings"
}

# Function to check dependencies
check_dependencies() {
    local missing=()
    
    if ! command -v yt-dlp &> /dev/null; then
        missing+=("yt-dlp")
    fi
    
    if ! command -v ffmpeg &> /dev/null; then
        missing+=("ffmpeg")
    fi
    
    if [ ${#missing[@]} -ne 0 ]; then
        echo "❌ Missing dependencies: ${missing[*]}"
        echo ""
        echo "Install them with:"
        echo "  yt-dlp: pip install yt-dlp"
        echo "  ffmpeg: sudo apt install ffmpeg (Ubuntu/Debian)"
        echo "         sudo pacman -S ffmpeg (Arch Linux)"
        exit 1
    fi
}

# Main script
main() {
    # Check dependencies first
    check_dependencies
    
    # Parse arguments
    if [ $# -lt 1 ]; then
        show_usage
        exit 1
    fi
    
    PLAYLIST_URL="$1"
    CATEGORY="${2:-music}"
    PLAYLIST_NAME="$3"
    
    # Set output directory based on category
    case "$CATEGORY" in
        "voice")
            OUTPUT_DIR="$VOICE_DIR"
            ;;
        "music")
            OUTPUT_DIR="$MUSIC_DIR"
            ;;
        *)
            echo "❌ Invalid category '$CATEGORY'. Use 'voice' or 'music'"
            exit 1
            ;;
    esac
    
    # Add playlist name to path if provided
    if [ -n "$PLAYLIST_NAME" ]; then
        OUTPUT_DIR="$OUTPUT_DIR/$PLAYLIST_NAME"
    fi
    
    # Download the playlist
    download_playlist "$PLAYLIST_URL" "$OUTPUT_DIR" "$CATEGORY"
}

# Run main function
main "$@"
