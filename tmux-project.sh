#!/bin/sh

if [ -z $1 ]; then
    echo "Wrong usage!"
    exit 1
fi

# Simplify the session-name
WORKING_DIR="$1"
NEW_SESSION=$(basename "$WORKING_DIR")

# tmux open new session (detach immediately since the script isn't finish yet)
tmux new -d -c $WORKING_DIR -s $NEW_SESSION

# create 4 windows: code | terminal | docs | help
tmux rename-window -t $NEW_SESSION code
tmux new-window -c $WORKING_DIR -t $NEW_SESSION -n terminal
tmux new-window -c $WORKING_DIR -t $NEW_SESSION -n docs
tmux new-window -c $WORKING_DIR -t $NEW_SESSION -n help

# Select the code window
tmux select-window -t code

# Now you can attach the session
tmux attach -t $NEW_SESSION
