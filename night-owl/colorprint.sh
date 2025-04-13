#!/bin/bash

# Function to convert hex to RGB
hex_to_rgb() {
    hex=$1
    hex=${hex#"#"} # Remove # if present

    if [ ${#hex} -eq 3 ]; then
        # Convert 3-digit hex to 6-digit
        r=$(printf "%d" 0x${hex:0:1}${hex:0:1})
        g=$(printf "%d" 0x${hex:1:1}${hex:1:1})
        b=$(printf "%d" 0x${hex:2:1}${hex:2:1})
    else
        r=$(printf "%d" 0x${hex:0:2})
        g=$(printf "%d" 0x${hex:2:2})
        b=$(printf "%d" 0x${hex:4:2})
    fi

    echo "$r $g $b"
}

# Check if hex color is provided
if [ $# -eq 0 ]; then
    echo "Please provide a hex color code"
    exit 1
fi

hex_color=$1
rgb=$(hex_to_rgb $hex_color)
r=$(echo $rgb | cut -d' ' -f1)
g=$(echo $rgb | cut -d' ' -f2)
b=$(echo $rgb | cut -d' ' -f3)

# Print the hex color using ANSI escape sequences
echo -e "\x1b[38;2;${r};${g};${b}m${hex_color}\x1b[0m"
