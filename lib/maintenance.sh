#!/bin/bash

perform_maintenance() {
	if [ $# -eq 0 ]; then
		echo "Performing full maintenance"
		update_packages
		clenup_temp
	else
		for option in "$@"; do
			case "$option" in
				update)
					update_packages
					;;
				cleanup)
					cleanup_temp
					;;
				*)
					echo "Unknown maintenance option: $option"
      		;;
    	esac
		done
	fi
}

update_packages() {
	echo "Updating system packages"
	case "$PACKAGE_MANAGER" in
		apt)
			sudo apt update && sudo apt upgrade -y
			;;
		yum)
			sudo yum update -y
			;;
		*)
			echo "Package manager $PACKAGE_MANAGER not supported."
      return 1
      ;;
	esac
	echo "Package update completed"
}

cleanup_temp() {
	echo "Cleanign up temporary files..."
	TEMP_DIRS=("/tmp" "/var/tmp")

	for dir in "${TEMP_DIRS[@]}"; do
		echo "Cleaning up directory: $dir"

		sudo find "$dir" -type f -atime +10 -delete
	done
	echo "Temporary files cleanup complete"
}
