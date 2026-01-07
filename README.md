# DevOps challenge helper

Assets and a step-by-step flow you can demo in a short Loom video to cover the four requested areas: Bash, Docker, SSH, and resource monitoring/optimization.

## Quick demo outline (what to run and what to say)
1) **Bash proficiency**
- Show essentials: `pwd`, `ls -lah`, `grep -R`, `find`, `tail -f file.log`, `du -sh .`, `df -h`, `ps aux --sort=-%mem | head`, `sed`/`awk` one-liner.
- Run the helper script to automate a simple housekeeping task:
  - `chmod +x scripts/*.sh`
  - `./scripts/organize_and_archive.sh ./demo-data`
  - It moves `.log` files into `logs/`, compresses ones older than 7 days, prunes archives older than 30 days, and prints a disk-usage summary plus top-5 largest files.
- What to say: “Here’s me navigating and inspecting the system; then I automate log organization and cleanup with a small, safe script (set -euo pipefail) to show I can script routine ops tasks.”

2) **Dockerized container (hello/maintenance page)**
- Build: `docker build -t demo-flask .`
- Run: `docker run --rm -p 8000:8000 demo-flask`
- Test: `curl http://localhost:8000/` (maintenance HTML) and `curl http://localhost:8000/health` (JSON).
- Update dependency demo: bump `Flask` in `requirements.txt` (e.g., `3.0.2 -> 3.0.3`), rebuild, and verify: `docker run --rm demo-flask python - <<'PY'\nimport flask; print(flask.__version__)\nPY`
- What to say: “I build a tiny web service into a container, run and validate it, then show how to update dependencies and confirm the new version—typical maintain-and-ship loop on a VPS.”

3) **SSH**
- Keygen: `ssh-keygen -t ed25519 -C "devops-demo"`
- Copy key (Linux/macOS): `ssh-copy-id user@server` (or manual `scp ~/.ssh/id_ed25519.pub user@server:~/.ssh/authorized_keys`)
- Connect: `ssh -i ~/.ssh/id_ed25519 user@server`
- Optional `~/.ssh/config` entry:
  - ```
    Host demo-server
      HostName <server-ip>
      User user
      IdentityFile ~/.ssh/id_ed25519
    ```
- What to say: “I use key-based auth (no passwords), copy the pubkey, and keep a simple ssh config for consistency; permissions and key reuse matter for secure remote access.”

4) **Resource monitoring & optimization**
- One-liners to show: `top`/`htop`, `uptime`, `free -h`, `df -hT`, `vmstat 1 3`, `iostat -xz 1 3` (or `vmstat` fallback), `ss -tulpn | head`.
- Run the helper: `./scripts/monitor.sh`
- Talk through what to watch: load vs CPU cores, swap usage, disk saturation (`%util`), inode usage, network listeners, and noisy processes.
- What to say: “I grab a quick snapshot, interpret CPU/mem/disk/network signals, then suggest lightweight fixes—log cleanup/rotation, right-size container CPU/mem (`--cpus`, `--memory`), add swap if needed, and set alerts to catch regressions.”

## Files included
- `scripts/organize_and_archive.sh` — small Bash automation for housekeeping.
- `scripts/monitor.sh` — quick resource snapshot using standard tools with fallbacks.
- `Dockerfile`, `requirements.txt`, `app/main.py` — tiny Flask container serving a static “maintenance / hello” page on `/` and a JSON `/health` endpoint on port `8000`.

## Suggested recording flow (5–10 minutes)
1. Bash: run a few commands, then the housekeeping script and show its output.
2. Docker: build, run, curl the endpoints, then bump the dependency and rebuild.
3. SSH: show keygen and a sample `ssh`/`ssh-copy-id` command (can be a dry run if no remote is available).
4. Monitoring: run `./scripts/monitor.sh`, call out what each section means, and note optimization ideas.

## Reply template (fill and send back)
Hello, this is [your name] for the DevOps Admin/Engineer challenge.

What I demonstrated in the video:
- Linux Bash commands and scripting: [brief description]
- Docker container deployment (Dockerfile, dependencies, updates): yes/no
- Secure SSH connection: yes/no
- Resource monitoring/optimization techniques: [tools/commands used]
- Experience with managing/scaling web applications (e.g., Directus, n8n): yes/no

Additional notes or challenges I faced:
[Enter your comments here]

Thank you,
[your name]
[your WhatsApp phone number]

