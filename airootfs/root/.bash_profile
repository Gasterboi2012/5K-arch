# 5K live environment: only auto-start on the primary virtual console (tty1).
if [[ "$(tty)" == "/dev/tty1" ]]; then
    exec 5k-welcome
fi
