#!/bin/bash

# Thresshold for monitoring
THRESHOLD_CPU=80
THRESHOLD_MEM=80
THRESHOLD_DISK=80

# Log file locaiton
LOG_FILE="var/log/sysadmin-helper.log"

# Backup configuration
BACKUP_DIR="tmp/sysadmin-backups"
BACKUP_SOURCES="/etc/,/var/log"

# Maintenance configuration
# Supported values for PACKAGE_MANAGER: apt, yum, etc.
PACKAGE_MANAGER="apt"
