# ZSH Configuration Manual

Config files live in `~/.config/zsh/` and are symlinked from `~/.zshrc` and `~/.aliases`.
The repo is `github.com/smarba/.config`.

---

## Shell Behaviour

These are set automatically on every shell start — no action needed.

| Behaviour | What it does |
|-----------|-------------|
| **History persistence** | History saved to `~/.zsh_history`, 10,000 lines, shared across all open terminal windows in real time |
| `HIST_IGNORE_DUPS` | Duplicate consecutive commands are not saved |
| `HIST_IGNORE_SPACE` | Prefix any command with a space and it won't be saved to history — useful for commands with passwords |
| `HIST_VERIFY` | `!!` and `!foo` expansions show the command first and wait for Enter before running |
| `AUTO_CD` | Type a directory name without `cd` to navigate into it |
| `NO_BEEP` | Terminal bell disabled |

---

## Navigation

| Command | What it does |
|---------|-------------|
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `....` | `cd ../../..` |
| `cdans` | Jump to `~/ansible` |
| `cdmac` | Jump to `~/macsetup` |
| `mkcd <dir>` | Create directory and cd into it in one step |

---

## File Listing — eza

Replaces `ls`. Shows file icons, git status, and color-coded output.

| Command | What it does |
|---------|-------------|
| `ls` | Basic listing with icons |
| `ll` | Long listing with icons + git status column |
| `la` | Long listing including hidden files + git status |
| `lt` | Tree view of current directory |

> Requires a Nerd Font to display icons correctly. See Phase 4 of `zsh-improvements.md`.

---

## File Viewing — bat

Replaces `cat`. Adds syntax highlighting, line numbers, and git change indicators.

```zsh
cat file.py          # syntax highlighted output
cat compose.yaml     # same command, works as before
```

For raw output without formatting (e.g. piping):
```zsh
bat --plain file.txt
```

---

## File Finding — fd

Replaces `find`. Faster, respects `.gitignore`, simpler syntax.

```zsh
fd .yaml             # find all yaml files in current dir (recursive)
fd compose           # find files matching "compose"
fd -e py             # find by extension only
fd -H .env           # include hidden files/dirs in search
fd pattern ~/path    # search a specific directory
```

---

## Text Search — ripgrep

Replaces `grep`. Much faster on large codebases, respects `.gitignore`, shows filename and line numbers by default.

```zsh
rg "search term"          # search current directory recursively
rg "pattern" src/         # search specific path
rg -l "term"              # list filenames only, not matching lines
rg -i "term"              # case insensitive
rg "term" -g "*.yaml"     # search only yaml files
```

---

## Fuzzy Finder — fzf

Installed via `eval "$(fzf --zsh)"` in `.zshrc`. Adds three keyboard shortcuts:

### `Ctrl+R` — Fuzzy history search
Press `Ctrl+R`, start typing any fragment of a past command. Shows a scrollable list of matches. Arrow keys to navigate, `Enter` to run, `Ctrl+C` to cancel.

### `Ctrl+T` — Fuzzy file picker
Paste a file path into your current command. Example:
```zsh
vim          # then press Ctrl+T to pick the file interactively
cat          # then press Ctrl+T to select a file to view
```

### `Alt+C` — Fuzzy cd
Press `Alt+C` to fuzzy-search subdirectories and cd into the selection.

---

## Smart Navigation — zoxide

Replaces `cd` with a frecency-based jump command. Learns the directories you visit most.

```zsh
z infra          # jumps to /opt/claude/infra (after visiting it once)
z docker         # jumps to ~/docker-configs
z ansible        # jumps to ~/ansible
zi               # interactive fuzzy picker of all known directories (uses fzf)
```

`cd` still works normally — zoxide adds `z` alongside it. The more you use `z`, the smarter it gets.

---

## Homebrew

| Command | What it does |
|---------|-------------|
| `brewup` | `brew update && brew upgrade && brew upgrade --cask && brew cleanup` in one step |

---

## Git Aliases

| Alias | Expands to |
|-------|-----------|
| `gs` | `git status` |
| `gd` | `git diff` |
| `gc` | `git commit` |
| `gco` | `git checkout` |
| `gb` | `git branch` |
| `gta` | `git add .` |
| `glog` | `git log --oneline --graph --decorate` |
| `gpull <branch>` | checkout + pull a branch |
| `gpush <message>` | add all + commit + push in one step |

---

## Pi SSH Shortcuts

Direct SSH to each Pi over Tailscale (internal IPs — must be on Tailscale).

| Alias | Host |
|-------|------|
| `pi01` | PI01 — 10.25.1.21 (Pi-hole primary, Nebula-Sync, Homebridge) |
| `pi02` | PI02 — 10.25.1.22 (Pi-hole replica, FreshRSS, Cloudflare Tunnel) |
| `pi03` | PI03 — 10.25.1.23 (Pi-hole replica, Uptime Kuma, Spoolman) |
| `pi04` | PI04 — 10.25.1.24 (GitHub Actions runner, Tailscale exit node) |
| `pi05` | PI05 — 10.25.1.25 (Tailscale exit node, Technitium DNS) |
| `pi07` | PI07 — 10.25.1.27 (spare) |
| `pi08` | PI08 — 10.25.1.28 (spare) |
| `pi501` | PI5-01 — 10.25.1.137 (n8n, Cloudflare Tunnel, ElastiFlow) |

---

## Claude Shortcuts

| Command | What it does |
|---------|-------------|
| `cl <project>` | cd to `/opt/claude/<project>` and launch Claude Code |
| `claude-pull` | Pull latest from `~/.claude` and `/opt/claude` repos |
| `claude-push` | Commit and push both repos (auto-detects changes) |

---

## Plugins (auto-loaded in `.zshrc`)

| Plugin | What it does |
|--------|-------------|
| `zsh-autosuggestions` | Suggests completions from history as you type — press `→` to accept |
| `fast-syntax-highlighting` | Colors commands as you type — red = invalid, green = valid. Faster and more accurate than `zsh-syntax-highlighting` |
| `zsh-history-substring-search` | Up/down arrows search history by prefix — type part of a command then arrow up to cycle through all matches |

### History Substring Search — how to use
Type any part of a previous command, then press the **up arrow** to cycle through all history entries that contain that text. Press **down arrow** to go forward. Press `Enter` to run the selected command.

Example: type `docker` then press up arrow — cycles through every docker command you've run.

---

## Prompt — Starship

Replaces the old `zsh-git-prompt` custom prompt. Config lives at `~/.config/starship.toml`.

### What the prompt looks like
```
~/.config/zsh on  main [~…] ❯
```

### What each part means
| Part | What it shows |
|------|--------------|
| `~/.config/zsh` | Current directory (last 3 segments) |
| ` main` | Git branch (with  icon — requires Nerd Font, otherwise shows text) |
| `[~…]` | Git status — see symbols below |
| `❯` | Green = last command succeeded · Red = last command failed |
| `took 3s` | Shown when a command takes more than 2 seconds |

### Git status symbols
| Symbol | Meaning |
|--------|---------|
| `⇡N` | N commits ahead of remote |
| `⇣N` | N commits behind remote |
| `~` | Modified files (unstaged) |
| `…` | Untracked files |
| `+` | Staged files |
| `!` | Merge conflicts |

### Format
The prompt format is explicitly defined in `starship.toml` to suppress language/runtime detection (Swift, Python, Node, etc. that macOS triggers automatically):
```toml
format = "$directory$git_branch$git_status$cmd_duration$character"
```

### To customize
Edit `~/.config/starship.toml`. Full reference: https://starship.rs/config/

### To unwind (revert to old prompt)
In `~/.config/zsh/.zshrc`:
1. Comment out `eval "$(starship init zsh)"`
2. Uncomment the `zsh-git-prompt` block and `PROMPT=` line (marked "Replaced by Starship")
3. `source ~/.zshrc`

### Nerd Fonts
**Install:**
```bash
brew install --cask font-jetbrains-mono-nerd-font
```

**Set it in Terminal.app:**
1. Open **Terminal → Settings → Profiles → [your profile] → Font → Change**
2. Select **JetBrainsMono Nerd Font Mono (NFM)**
3. Choose size (13–14pt recommended)
4. Close and reopen a terminal window

---

## Shell Startup Performance

### compinit cache
The completion index (`~/.zcompdump`) is only rebuilt once per day instead of on every shell start. No action needed — happens automatically.

---

## What's Coming (deferred)

See `zsh-improvements.md` in `/opt/claude/infra/` for the full roadmap.

- **ZDOTDIR** — set `~/.zshenv` so zsh finds config in `~/.config/zsh/` natively without symlinks
- **Split config** — break `.zshrc` into `conf.d/` files (history, completion, bindings, plugins, prompt)
- **zsh-vi-mode** — enables vi keybindings in terminal (skipped for now)
