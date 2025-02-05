#!/bin/bash

backup_restore() {
	if [ $# -eq 0 ]; then
		echo "Usage: backup {create|restore} [options]"
		exit 1
	fi

	ACTION=$1
	shift
	case "$ACTION" in
		create)
			create_backup "$@"
			;;
		restore)
			restore_backup "$@"
			;;
		*)
			echo "Unknown backup command: $ACTION"
			exit 1
			;;
	esac
}

create_backup() {
	IFS=',' read SOURCES "$BACKUP_SOURCES"
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
  BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
  mkdir -p "$BACKUP_DIR"
	
	echo "Creating backup..."
  tar -czf "$BACKUP_FILE" "${SOURCES[@]}"
  if [ $? -eq 0 ]; then
    echo "Backup created successfully at: $BACKUP_FILE"
  else
    echo "Backup failed." >&2
    exit 1
  fi
}

restore_backup() {
  if [ -z "$1" ]; then
    echo "Usage: backup restore <backup_file> [destination]"
    exit 1
  fi

  BACKUP_FILE="$1"
  DESTINATION="${2:-/}"
  if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup file not found: $BACKUP_FILE"
    exit 1
  fi

  echo "Restoring backup from $BACKUP_FILE to $DESTINATION..."
  tar -xzf "$BACKUP_FILE" -C "$DESTINATION"
  if [ $? -eq 0 ]; then
    echo "Restore completed successfully."
  else
    echo "Restore failed." >&2
    exit 1
  fi
}
