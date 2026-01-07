# DevOps challenge helper

Assets and a step-by-step flow you can demo in a short Loom video to cover the four requested areas: Bash, Docker, SSH, and resource monitoring/optimization.

## Quick demo outline
1) **Bash proficiency**
- Show essentials: `pwd`, `ls -lah`, `grep -R`, `find`, `tail -f file.log`, `du -sh .`, `df -h`, `ps aux --sort=-%mem | head`, `sed`/`awk` one-liner.
- Run the helper script to automate a simple housekeeping task:
  - `chmod +x scripts/*.sh`
  - `./scripts/organize_and_archive.sh ./demo-data`
  - Explain what it does: moves `.log` files into `logs/`, compresses ones older than 7 days, purges archives older than 30 days, and prints a disk-usage summary.
- Explanation: demonstrate familiarity with core file/process/disk commands, then show a small automation that organizes logs and reports usage—typical of quick admin tasks.

2) **Dockerized container (hello/maintenance page)**
- Build: `docker build -t demo-flask .`
- Run: `docker run --rm -p 8000:8000 demo-flask`
- Test: `curl http://localhost:8000/` (returns a simple maintenance page HTML) and `curl http://localhost:8000/health` (JSON).
- Update dependency demo: bump `Flask` in `requirements.txt` (e.g., `3.0.2 -> 3.0.3`), rebuild, and show `docker run ...` then `pip show Flask` inside the container (`docker exec <cid> pip show Flask` or `docker run --rm demo-flask python -c "import flask; print(flask.__version__)"`).
- Explanation: show you can build a Docker image, run it, validate endpoints, and manage dependency updates—covering the typical cycle of building and maintaining a small web service on a VPS.

3) **SSH**
- Keygen: `ssh-keygen -t ed25519 -C "devops-demo"`
- Copy key (Linux/macOS): `ssh-copy-id user@server`
- Or manual: `scp ~/.ssh/id_ed25519.pub user@server:~/.ssh/authorized_keys`
- Connect: `ssh -i ~/.ssh/id_ed25519 user@server`
- Optional `~/.ssh/config` entry:
  - ```
    Host demo-server
      HostName <server-ip>
      User user
      IdentityFile ~/.ssh/id_ed25519
    ```
- Explanation: highlight secure, key-based auth and a simple `~/.ssh/config` to standardize access; mention avoiding password auth and reusing keys securely.

4) **Resource monitoring & optimization**
- One-liners to show: `top`/`htop`, `uptime`, `free -h`, `df -hT`, `vmstat 1 3`, `iostat -xz 1 3` (install `sysstat` if missing), `ss -tulpn | head`.
- Run the helper: `./scripts/monitor.sh`
- Talk through what to watch: load averages vs CPU cores, swap usage, disk saturation (`%util` in `iostat`), inode usage, noisy processes. Mention simple optimizations: clean temp/logs, right-size container CPU/mem (`--cpus`, `--memory`), add swap if appropriate, and add alerts.
- Explanation: demonstrate situational awareness—capture a quick snapshot, interpret CPU/mem/disk/network signals, then suggest lightweight remediations (log cleanup, right-sizing, swap/alerts) to keep services healthy.

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

