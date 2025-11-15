#!/usr/bin/env bash

set -e

osascript - <<EOF
tell application id "com.apple.SystemEvents"
    set IS_RUNNING to count (processes whose name is "iTerm2")
end tell

tell application id "com.googlecode.iTerm2"
    if IS_RUNNING > 0 then
        try
            create window with default profile command ""
        on error
            activate
            create window with default profile command ""
        end try
    else
        activate
    end if
    activate
end tell
EOF
