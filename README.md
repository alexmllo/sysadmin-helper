# sysadmin-helper

## Overview

**sysadmin-helper** is a modular CLI tool written in Bash for Linux system maintenance. It provides functions for:
- **Monitoring:** Checking CPU, memory, and disk usage.
- **Logs:** Rotating and analyzing log files.
- **Backup:** Creating and restoring backups of important directories.
- **Maintenance:** Performing system updates and cleaning up temporary files.

## Setup

1. **Clone the repository:**

   ```bash
   git clone <your-repo-url> sysadmin-helper
   cd sysadmin-helper
   ```

2. **Make the main script executable:**
   ```bash
   chmod +x bin/sysadmin-helper.sh
   ```
3. **Configure your environment:**

   Edit `conf/sysadmin-helper.conf` to set your desired thresholds, log file locations, backup directories, and package manager.

4. **Run the help command:**
   ```bash
   ./bin/sysadmin-helper.sh help
   ```
## Usage
Use one of the subcommands to execute a specific task:

### Monitor System Health
Display CPU, memory, and disk usage metrics:
   ```bash
   ./bin/sysadmin-helper.sh monitor
   ```

### Manage Logs
- __Rotate Logs:__
Rotate and compress the log file:
   ```bash
   ./bin/sysadmin-helper.sh logs rotate
   ```

- __Analyze Logs:__
Analyze the log file for errors:
   ```bash
   ./bin/sysadmin-helper.sh logs analyze
   ```

### Backup Operations
- __Create a Backup:__
Create a backup of the directories specified in the configuration:
   ```bash
   ./bin/sysadmin-helper.sh backup create
   ```

- __Restore a Backup:__
Restore from a specified backup file to a destination (default is root):
   ```bash
   ./bin/sysadmin-helper.sh backup restore /path/to/backup.tar.gz /destination/path
   ```

### Perform Maintenance
Run routine maintenance tasks such as updating system packages and cleaning temporary files:
   ```bash
   ./bin/sysadmin-helper.sh maintain
   ```

Alternatively, run specific tasks:
   ```bash
   ./bin/sysadmin-helper.sh maintain update
   ./bin/sysadmin-helper.sh maintain cleanup
   ```

## Configuration
The configuration file (`conf/sysadmin-helper.conf`) includes settings such as:

- __Thresholds for Monitoring:__
   ```bash
   THRESHOLD_CPU=80
   THRESHOLD_MEM=80
   THRESHOLD_DISK=90
   ```

- __Log File Location:__
   ```bash
   LOG_FILE="/var/log/sysadmin-helper.log"
   ```

- __Backup Settings:__
   ```bash
   BACKUP_DIR="/tmp/sysadmin-backups"
   BACKUP_SOURCES="/etc,/var/log"
   ```

- __Maintenance Settings:__
Specify your package manager (e.g., apt, yum):
   ```bash
   PACKAGE_MANAGER="apt"
   ```