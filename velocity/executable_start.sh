#!/bin/sh
# starts velocity, restarts it on crash
# stops for real when `mc stop` made a .stop file (or ctrl+c)
cd "$(dirname "$0")" || exit 1
# ∅ jar / java = the loop below restarts it every 5 sec forever ∴ check first
if [ ! -f velocity.jar ]; then
    echo "start.sh: no velocity.jar in $PWD" >&2
    exit 1
fi
if ! command -v java >/dev/null 2>&1; then
    echo "start.sh: no java (needs 25+)" >&2
    exit 1
fi
trap 'rm -f .stop; exit 0' INT TERM
rm -f .stop

while :; do
    java -Xms1G -Xmx1G \
        -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions \
        -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -XX:MaxInlineLevel=15 \
        -jar velocity.jar
    if [ -e .stop ]; then
        rm -f .stop
        exit 0
    fi
    echo "velocity stopped, restarting in 5 sec (ctrl+c to cancel)"
    sleep 5
done
