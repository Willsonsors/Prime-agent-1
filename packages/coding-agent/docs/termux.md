# Termux (Android) Setup

Prime Agent runs on Android via [Termux](https://termux.dev/), a terminal emulator and Linux environment for Android.

## Quick Start (3 Steps)

### 1️⃣ Install Apps
Install from **GitHub** or **F-Droid** (not Google Play):
- [Termux](https://github.com/termux/termux-app)
- [Termux:API](https://github.com/termux/termux-api) (optional, for clipboard)

### 2️⃣ Automatic Setup
```bash
# Download and run the installer
curl -fsSL https://raw.githubusercontent.com/Willsonsors/prime-agent/main/packages/coding-agent/install-termux.sh | bash
```

Or manually (one-liner):
```bash
pkg update && pkg upgrade && pkg install -y nodejs termux-api git && git clone https://github.com/PrimeIntellect-ai/prime-agent.git && cd prime-agent && npm ci && ./prime-agent.sh
```

### 3️⃣ Authenticate
Inside Prime Agent, run:
```
/login
```
Choose a provider (Claude, ChatGPT, GitHub Copilot, or API key).

## What the Installer Does

✅ Updates package manager  
✅ Installs Node.js, Git, Ripgrep  
✅ Installs Termux:API tools  
✅ Sets up storage permissions  
✅ Clones Prime Agent repo  
✅ Installs dependencies  
✅ Creates default `AGENTS.md` config  

Takes ~2-3 minutes total.

## Manual Setup (If Needed)

```bash
# Update packages
pkg update && pkg upgrade

# Install dependencies
pkg install -y nodejs termux-api git ripgrep

# Setup storage (do this once)
termux-setup-storage

# Clone and install
git clone https://github.com/PrimeIntellect-ai/prime-agent.git
cd prime-agent
npm ci

# Run
./prime-agent.sh
```

## First Session

Once running:
```
Summarize this repository and tell me how to run its checks.
```

Prime Agent will analyze your project and provide guidance.

## Common Commands

| Feature | Command |
|---------|---------|
| **Start** | `./prime-agent.sh` |
| **Resume session** | `prime-agent -c` |
| **Browse sessions** | `prime-agent -r` |
| **Authenticate** | `/login` |
| **Copy to clipboard** | `termux-clipboard-set "text"` |
| **Paste from clipboard** | `termux-clipboard-get` |
| **Open URL** | `termux-open-url "https://example.com"` |
| **Open file** | `termux-open file.pdf` |
| **Device info** | `termux-battery-status` |

## Limitations

| Issue | Status |
|-------|--------|
| **Image clipboard** | ❌ Not supported (text only) |
| **Native binaries** | ⚠️ Skipped on ARM64 (optional deps) |
| **Storage access** | ⚠️ Requires `termux-setup-storage` once |

## Troubleshooting

### Common Issues

See [**Termux FAQ & Troubleshooting**](termux-faq.md) for:
- ✅ Installation errors
- ✅ Clipboard not working
- ✅ Storage permission issues
- ✅ npm/Node.js problems
- ✅ Authentication issues
- ✅ Performance tips
- ✅ Quick fixes checklist

### Quick Fixes

**Clipboard not working:**
```bash
pkg install termux-api
```

**Storage permission denied:**
```bash
termux-setup-storage
```

**npm fails:**
```bash
npm cache clean --force
```

## Advanced: Project Instructions

Create `~/.prime/agent/AGENTS.md` to customize behavior:

```markdown
# Agent Environment: Termux on Android

## Device
- OS: Android (Termux)
- Home: /data/data/com.termux/files/home
- Storage: /storage/emulated/0

## Behavior
- Keep responses concise (mobile interface)
- Use sessions to save work
- Text clipboard only (no images)
```

Restart Prime Agent after creating/editing this file, or run `/reload`.

## Sessions

Sessions auto-save to `~/.prime/agent/sessions/`:

```bash
prime-agent -c              # Continue last session
prime-agent -r              # Browse all sessions
```

Inside Prime Agent:
- `/resume` — continue session
- `/new` — start new session
- `/tree` — view session tree
- `/fork` — branch current session
- `/clone` — duplicate session

## Getting Help

- 📖 **[Termux FAQ & Troubleshooting](termux-faq.md)** — detailed problem-solving
- 📖 [Quickstart](quickstart.md) - full setup guide
- 📖 [Providers](providers.md) - authentication options
- 📖 [Using Prime Agent](usage.md) - commands and features
- 📖 [Sessions](sessions.md) - session management

## Links

- 🐛 [GitHub Issues](https://github.com/Willsonsors/prime-agent/issues)
- 💬 [GitHub Discussions](https://github.com/Willsonsors/prime-agent/discussions)
- 📱 [Termux GitHub](https://github.com/termux/termux-app)
- 📱 [Termux:API GitHub](https://github.com/termux/termux-api)
