#!/bin/sh
# starts purpur, restarts it on crash / /restart
# stops for real when `mc stop` made a .stop file (or ctrl+c)
# ram: 11gb pc, velocity gets 1, os needs some ∴ 6
cd "$(dirname "$0")" || exit 1
# ∅ jar / java = the loop below restarts it every 5 sec forever ∴ check first
if [ ! -f purpur.jar ]; then
	echo "start.sh: no purpur.jar in $PWD" >&2
	exit 1
fi
if ! command -v java >/dev/null 2>&1; then
	echo "start.sh: no java (needs 25+)" >&2
	exit 1
fi
trap 'rm -f .stop; exit 0' INT TERM
rm -f .stop

while :; do
	java -Xms6G -Xmx6G \
		-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 \
		-XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch \
		-XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M \
		-XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 \
		-XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 \
		-XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 \
		-XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 \
		-Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true \
		-jar purpur.jar --nogui
	if [ -e .stop ]; then
		rm -f .stop
		exit 0
	fi
	echo "purpur stopped, restarting in 5 sec (ctrl+c to cancel)"
	sleep 5
done
