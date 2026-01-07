#!/usr/bin/env bash
# Quick resource snapshot with portable fallbacks.
set -euo pipefail

echo "== Uptime / load =="
uptime || true

echo -e "\n== CPU top 5 by CPU =="
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6

echo -e "\n== CPU top 5 by MEM =="
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6

echo -e "\n== Memory =="
free -h || true

echo -e "\n== Disk usage =="
df -hT || df -h || true

echo -e "\n== IO stats (iostat) =="
if command -v iostat >/dev/null 2>&1; then
  iostat -xz 1 3
else
  echo "iostat not installed (install sysstat). Showing vmstat instead:"
  vmstat 1 3 || true
fi

echo -e "\n== Network listeners =="
if command -v ss >/dev/null 2>&1; then
  ss -tulpn | head -20
else
  netstat -tulpn | head -20 || true
fi

echo -e "\n== Tail of syslog (if present) =="
if [ -f /var/log/syslog ]; then
  tail -n 20 /var/log/syslog
elif [ -f /var/log/messages ]; then
  tail -n 20 /var/log/messages
else
  echo "No syslog/messages available or permission denied."
fi

