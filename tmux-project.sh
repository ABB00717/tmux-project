#!/bin/sh


if [ -z $1 ]; then
    echo "Wrong usage!"
    exit;
fi

# Regex is soooo fucking gross
#
# Match the last '/'
# .*/
# Catch all the characters that is not '/'
# \([^/]*\)
# Deal with the tailing '/'
# /\?
# The end
# $
WORKING_DIR=$1
NEW_SESSION=`expr "$WORKING_DIR" : '.*/\([^/]*\)/\?$'`

# tmux open new session (detach immediately since the script isn't finish yet)
tmux new -d -c $WORKING_DIR -s $NEW_SESSION

# create 3 windows: code | terminal | docs
tmux rename-window -t $NEW_SESSION code
tmux new-window -c $WORKING_DIR -t $NEW_SESSION -n terminal
tmux new-window -c $WORKING_DIR -t $NEW_SESSION -n docs

# Now you can attach the session
tmux attach -t $NEW_SESSION
