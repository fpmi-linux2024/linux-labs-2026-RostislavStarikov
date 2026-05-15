#!/bin/bash
user_name="${PAM_USER:-$(id -un)}"
if [ -z "$user_name" ]; then
    echo "$0: my user could not be identified" >&2
    exit 1
fi

user_id=$(id -u "$user_name" 2>/dev/null)
if [ -z "$user_id" ]; then
    echo "$0: user $user_name not found" >&2
    exit 1
fi

if ! command -v notify-send >/dev/null 2>&1; then
    echo "$0: notify-send not installed" >&2
    echo "$0: install the libnotify-bin package" >&2
    exit 1
fi

export DISPLAY="${DISPLAY:-:0}"
export XDG_RUNTIME_DIR="/run/user/$user_id"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$user_id/bus"

message_title="I am logged in"
message_text="User $user_name for authorization"

if [ "$(id -u)" -eq 0 ] && [ "$user_name" != "root" ]; then
    sudo -u "$user_name" env \
        DISPLAY="$DISPLAY" \
        XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
        DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS" \
        notify-send "$message_title" "$message_text"
else
    notify-send "$message_title" "$message_text"
fi