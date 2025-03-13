#!/bin/bash

# Check if we have enough arguments
if [ "$#" -lt 2 ] || [ "$1" != "-s" ]; then
    echo "Usage: tmux-8pane.sh -s SESSION_NAME [additional tmux options]"
    exit 1
fi

# Extract session name
SESSION_NAME="$2"
shift 2  # Remove -s and SESSION_NAME from arguments

# Get terminal height
TERM_HEIGHT=$(tput lines)

# Check if terminal is tall enough (need at least 50 lines for 8 panes)
MIN_HEIGHT=50
if [ "$TERM_HEIGHT" -lt "$MIN_HEIGHT" ]; then
    echo "Error: Terminal height of $TERM_HEIGHT lines is insufficient."
    echo "Need at least $MIN_HEIGHT lines for 8 evenly spaced panes."
    exit 1
fi

# Create new tmux session
tmux new-session -d -s "$SESSION_NAME" $@

# Create 7 horizontal splits (giving 8 equal rows)
for i in {1..7}; do
    # Calculate percentage based on remaining space
    # For example: 1/7, 1/6, 1/5, 1/4, 1/3, 1/2, 1/1
    percentage=$((100 / (9 - i)))
    tmux split-window -v -t "$SESSION_NAME:0.0" -p $percentage
done

# Select the first pane to start at the top
tmux select-pane -t "$SESSION_NAME:0.0"

# Attach to the session
tmux attach-session -t "$SESSION_NAME"
