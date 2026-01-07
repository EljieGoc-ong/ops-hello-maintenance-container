#!/usr/bin/env bash
# Simple housekeeping script: collect logs, compress old ones, and report disk usage.
set -euo pipefail

TARGET_DIR="${1:-$PWD}"
LOG_DIR="${TARGET_DIR%/}/logs"
ARCHIVE_DIR="${TARGET_DIR%/}/archive"

mkdir -p "$LOG_DIR" "$ARCHIVE_DIR"

echo "[*] Moving *.log files in $TARGET_DIR to $LOG_DIR"
find "$TARGET_DIR" -maxdepth 1 -type f -name "*.log" -print -exec mv {} "$LOG_DIR"/ \;

echo "[*] Compressing logs older than 7 days in $LOG_DIR"
find "$LOG_DIR" -type f -mtime +7 -print -exec gzip -f {} \;

echo "[*] Pruning archives older than 30 days in $ARCHIVE_DIR"
find "$ARCHIVE_DIR" -type f -mtime +30 -print -delete

echo "[*] Disk usage for target dir:"
du -sh "$TARGET_DIR"

echo "[*] Largest files under target (top 5):"
find "$TARGET_DIR" -type f -printf "%s %p\n" 2>/dev/null | sort -nr | head -5 | awk '{printf "%8.1f MB  %s\n", $1/1024/1024, $2}'

echo "[*] Done."

