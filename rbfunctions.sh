#!/bin/bash

# Convert image to webp using Imagick
towebp() {
    local input_file="$1"
    local output_file="${input_file%.*}.webp"
    magick "$input_file" \
        -quality ${2:-77} \
        -define webp:method=6 \
        -define webp:auto-filter=true \
        -sampling-factor 4:2:0 \
        "$output_file"
}

# Convert all PNG images to web
convert_all_png_to_webp() {
    local folder="${1:-.}"  # Default to current directory if no folder is provided

    for input_file in "$folder"/*.png; do
        if [[ -f "$input_file" ]]; then
		towebp "$input_file"
        fi
    done
}

csvdb() {
	sqlite3 $1".db" ".import --csv '$2' '$1'" && open $1".db"
}

