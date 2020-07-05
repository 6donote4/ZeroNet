#!/bin/bash
SCRIPT_DIR=$( cd ${0%/*} && pwd -P )
cd "$SCRIPT_DIR"
if [ x$DISPLAY != x ] || [[ "$OSTYPE" == "darwin"* ]]; then
    # Has gui, open browser
    SCRIPT="start.py"
else
    # No gui
    SCRIPT="zeronet.py"
fi

python3 "$SCRIPT_DIR/$SCRIPT" --dist_type bundle_linux64 "$@"
