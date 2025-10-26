if [[ ! -f "$STATE_PATH/installed" ]]; then
    STATE_FLAG="first-install"
else
    STATE_FLAG="update"
fi
