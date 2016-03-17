cpudev=/sys/devices/system/cpu
for CPU in $cpudev/cpu[0-31]*; do
	echo `basename $CPU` : `cat $CPU//topology/core_id`
done

