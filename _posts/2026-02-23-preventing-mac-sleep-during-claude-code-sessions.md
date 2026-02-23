---
title: Preventing Mac Sleep During Claude Code Sessions
description: Keep your Mac awake during long Claude Code tasks using hooks and macOS's built-in caffeinate command. Supports multiple tabs, handles crashes gracefully, and cleans up automatically.
author: lamngockhuong
date: 2026-02-23 08:00:00 +0700
categories: [macOS, Productivity]
tags: [claude code, macos, caffeinate, hooks, automation, ai tools]
---

When Claude Code runs long tasks unattended, your Mac may go to sleep and pause the agent. Here's a simple fix using Claude Code's hook system and macOS's built-in `caffeinate` command.

## How It Works

- **On prompt submit**: Register session, clean up stale sessions, restart `caffeinate` with 1h timeout
- **On session stop**: Unregister session, kill `caffeinate` only when no active sessions remain

Each session is tracked by its process ID (`$PPID`), so **multiple Claude Code tabs** work correctly. Stale sessions from crashes are automatically cleaned up.

## Setup

### 1. Create the Scripts

**`~/.claude/hooks/prevent-sleep.sh`**

```bash
#!/bin/bash

# Keep Mac awake during Claude Code sessions via caffeinate
# Uses per-session marker files (PPID) instead of counter to handle crashes gracefully

LOCK_DIR="/tmp/claude_caffeinate"
SESSIONS_DIR="$LOCK_DIR/sessions"
PID_FILE="$LOCK_DIR/pid"

mkdir -p "$SESSIONS_DIR"

# Register this session (PPID = Claude Code's node process)
touch "$SESSIONS_DIR/$PPID"

# Clean up stale sessions (process no longer exists)
for f in "$SESSIONS_DIR"/*; do
    [ -f "$f" ] || continue
    sid=$(basename "$f")
    if ! ps -p "$sid" > /dev/null 2>&1; then
        rm -f "$f"
    fi
done

# Restart caffeinate with fresh 1h timeout (safety net if Claude crashes)
if [ -f "$PID_FILE" ]; then
    pid=$(cat "$PID_FILE")
    if ps -p "$pid" -o args= 2>/dev/null | grep -q '^caffeinate'; then
        kill "$pid" 2>/dev/null
    fi
fi

nohup caffeinate -i -t 3600 > /dev/null 2>&1 &
echo $! > "$PID_FILE"
```

**`~/.claude/hooks/allow-sleep.sh`**

```bash
#!/bin/bash

# Re-enable Mac sleep only when all Claude Code sessions have stopped
# Removes session marker, cleans stale sessions, kills caffeinate when none remain

LOCK_DIR="/tmp/claude_caffeinate"
SESSIONS_DIR="$LOCK_DIR/sessions"
PID_FILE="$LOCK_DIR/pid"

[ ! -d "$SESSIONS_DIR" ] && exit 0

# Remove this session's marker
rm -f "$SESSIONS_DIR/$PPID"

# Clean up stale sessions (process no longer exists)
for f in "$SESSIONS_DIR"/*; do
    [ -f "$f" ] || continue
    sid=$(basename "$f")
    if ! ps -p "$sid" > /dev/null 2>&1; then
        rm -f "$f"
    fi
done

# Count remaining active sessions
remaining=$(find "$SESSIONS_DIR" -type f 2>/dev/null | wc -l | tr -d ' ')

if [ "$remaining" -eq 0 ]; then
    if [ -f "$PID_FILE" ]; then
        pid=$(cat "$PID_FILE")
        if ps -p "$pid" -o args= 2>/dev/null | grep -q '^caffeinate'; then
            kill "$pid" 2>/dev/null
        fi
    fi
    rm -rf "$LOCK_DIR"
fi
```

Make them executable:

```bash
chmod +x ~/.claude/hooks/prevent-sleep.sh ~/.claude/hooks/allow-sleep.sh
```

### 2. Add Hooks to `~/.claude/settings.json`

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/prevent-sleep.sh"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/allow-sleep.sh"
          }
        ]
      }
    ]
  }
}
```

> If you already have existing hooks, just add the new entries to the respective arrays.
{: .prompt-info }

## Edge Cases Handled

| Scenario           | Solution                                                                      |
| ------------------ | ----------------------------------------------------------------------------- |
| **Multiple tabs**  | Each tab has its own session file (`$PPID`), no shared state conflicts        |
| **Race condition** | Per-session files instead of shared counter, no read-modify-write race        |
| **Claude crash**   | `-t 3600` timeout auto-kills caffeinate; stale session files cleaned next run |
| **Counter drift**  | No counter — active sessions counted from actual files + process verification |
| **Stale sessions** | Both scripts prune session files whose process no longer exists               |
| **Reboot**         | `/tmp` is cleared automatically by macOS                                      |

## Notes

- `caffeinate -i` prevents idle sleep (not lid-close sleep)
- Each prompt restarts caffeinate with a fresh 1-hour timeout as a safety net
- PID is verified as `caffeinate` before killing to avoid terminating unrelated processes

## Credits

Inspired by [Toni Granados's blog post](https://tngranados.com/blog/preventing-mac-sleep-claude-code/).
