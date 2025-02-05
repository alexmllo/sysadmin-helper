#!/bin/bash

monitor_system() {
	echo "Gathering system metrics..."

	# Get CPU usage
	CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)
	CPU_USAGE=$(( 100 - $CPU_IDLE ))
	
	# Get memory usage
	MEM_USAGE=$(free | awk '/Mem/ {printf("%d", $3/$2)}')

	# Get disk usage
	DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

	echo "---------------------"
	echo "System Health Report:"
	echo "CPU Usage:     $CPU_USAGE"
	echo "Memory Usage:  $MEM_USAGE"
	echo "Disk Usage:    $DISK_USAGE"
	echo "---------------------"

	if [ "$CPU_USAGE -gt $THRESHOLD_CPU" ]; then
		echo "Warning: CPU usage exceeds threshold of $THRESHOLD_CPU%!"
  fi
  if [ "$MEM_USAGE" -gt "$THRESHOLD_MEM" ]; then
    echo "Warning: Memory usage exceeds threshold of $THRESHOLD_MEM%!"
  fi
  if [ "$DISK_USAGE" -gt "$THRESHOLD_DISK" ]; then
    echo "Warning: Disk usage exceeds threshold of $THRESHOLD_DISK%!"
  fi
}

