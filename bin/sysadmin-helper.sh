#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_FILE="$SCRIPT_DIR/../conf/sysadmin-helper.conf"
if [ -f "$CONFIG_FILE" ]; then
	source "$CONFIG_FILE"
else
	echo "Configuration file not found: $CONFIG_FILE" >&2
	exit 1
fi

LIB_DIR="$SCRIPT_DIR/../lib"
for lib in monitor.sh logs.sh backup.sh maintainance.sh; do
	if [ -f "$LIB_DIR/$lib" ]; then
		source "$LIB_DIR/$lib"
	else
		echo "Library file not found: $LIB_DIR/$lib">&2
	fi
done

usage() {
	echo "Usage: $0 {monitor|logs|backup|maintainance|help} [options]"options
	echo ""
	echo "Subcommands:"
	echo "  monitor  - Display system health metrics and alerts"
	echo "  logs     - Manage logs (rotate, analyze)"
	echo "  backup   - Create or restore backups"
	echo "  maintain - Run routine maintainance tasks (update, cleanup)"
	echo "  help     - Displays this same help message"
	exit 1
}

# Requires at least 1 argument
if [ $# -eq 0 ]; then
	usage
fi

# Parse subcommand
COMMAND=$1
shift

case "$COMMAND" in
	monitor)
		monitor_system "$@"
		;;
	logs)
		manage_logs "$@"
		;;
	backup)
		backup_restore "$@"
		;;
	maintain)
		perform_maintenance "$@"
		;;
	help)
		usage
		;;
	*)
		echo "Error: Unknown command '$COMMAND'"
		usage
		;;
esac

