#!/bin/bash

manage_logs() {
	if [ $# -eq 0 ]; then
		echo "Usage: logs {rotate|analyze}"
	fi

	case "$1" in
		rotate)
			rotate_logs
			;;
		analyze)
			analyze_logs
			;;
		*)
			echo "Unknown logs commands: $1"
			exit 1
			;;
	esac
}

rotate_logs() {
	if [ ! -f "$LOG_FILE" ]; then
		echo "Log file not found: $LOG_FILE"
		exit 1
	fi

	TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
	ARCHIVE_DIR="$(dirname "$LOG_FILE")/archive"
	mkdir -p "$ARCHIVE_DIR"
	ARCHIVE_FILE="$ARCHIVE_DIR/sysadmin-helper.log.$TIMESTAMP.gz"

	echo "Rotating log file..."
	gzip -c "$LOG_FILE" > "$ARCHIVE_FILE" && : > "$LOG_FILE"
  if [ $? -eq 0 ]; then
    echo "Log rotated successfully: $ARCHIVE_FILE"
  else
    echo "Log rotation failed." >&2
    exit 1
  fi
}

analyze_logs() {
	if [ -f "$LOG_FILE" ]; then
		echo "Log file not found: $LOG_FILE"
    exit 1
  fi

	ERROR_COUNT=$(grep -i "error" "$LOG_FILE" | wc -l)
  echo "Log Analysis:"
  echo "Total errors found: $ERROR_COUNT"
}
