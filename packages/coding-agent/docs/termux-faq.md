# Termux FAQ & Troubleshooting

Quick solutions for common Termux + Prime Agent issues.

## 📱 Installation Issues

### ❌ "command not found: pkg"

**Cause:** Not running in Termux or Termux is broken.

**Fix:**
```bash
# Verify you're in Termux
ls -la /data/data/com.termux/files/

# If not found, reinstall Termux from GitHub or F-Droid
# Do NOT use Google Play (deprecated version)
```

### ❌ "permission denied" during npm install

**Cause:** File permissions or storage access.

**Fix:**
```bash
# Run storage setup
termux-setup-storage

# Clear npm cache
npm cache clean --force

# Try install again
cd prime-agent
npm ci
```

### ❌ "Node.js version mismatch"

**Cause:** Installed Node.js version is too old.

**Fix:**
```bash
node --version
# Should be 18+ for Prime Agent

# Upgrade Node.js
pkg upgrade nodejs

# Verify
node --version
```

---

## 🔌 Clipboard Issues

### ❌ "termux-clipboard-get: command not found"

**Cause:** Termux:API app not installed or tools not installed.

**Fix:**
1. Install **Termux:API app** from GitHub or F-Droid
2. In Termux, run:
   ```bash
   pkg install termux-api
   ```
3. Try again:
   ```bash
   echo "test" | termux-clipboard-set
   termux-clipboard-get
   ```

### ❌ "Clipboard paste (Ctrl+V) not working"

**Cause:** Image clipboard not supported on Termux (text only).

**Fix:**
- Use text-only clipboard: `termux-clipboard-get`
- Or manually type/copy-paste into Termux
- Images cannot be pasted via Ctrl+V on Termux

---

## 💾 Storage Issues

### ❌ "Permission denied: /storage/emulated/0"

**Cause:** Storage permissions not granted.

**Fix:**
```bash
# Grant permissions (one-time)
termux-setup-storage

# If still issues, check paths
ls -la /storage/emulated/0

# Or use home directory instead
cd ~
```

### ❌ "Files in Downloads not visible"

**Cause:** Storage not set up or path issue.

**Fix:**
```bash
# Setup storage
termux-setup-storage

# Access Downloads
ls -la /storage/emulated/0/Download/

# Or use Termux storage symlink
ls -la ~/storage/downloads/
```

---

## 🚀 Runtime Issues

### ❌ Prime Agent starts but immediately crashes

**Cause:** Missing dependencies or Python issues.

**Fix:**
```bash
# Verify all dependencies
pkg list-installed | grep -E "nodejs|git|ripgrep"

# Reinstall all
pkg install -y nodejs git ripgrep

# Try running from source directory
cd prime-agent
./prime-agent.sh
```

### ❌ "ipython: command not found"

**Cause:** Python environment not properly configured.

**Fix:**
```bash
# Prime Agent bootstraps Python on first use
# Just run it normally:
./prime-agent.sh

# If it still fails, set up Python manually
pkg install python

# Verify
python --version
```

### ❌ Sessions not saving

**Cause:** Disk full or permissions issue.

**Fix:**
```bash
# Check disk space
df -h

# Sessions location
ls -la ~/.prime/agent/sessions/

# If missing, create directory
mkdir -p ~/.prime/agent/sessions/

# Check permissions
chmod 700 ~/.prime/agent/sessions/
```

---

## 🔑 Authentication Issues

### ❌ "/login command not found"

**Cause:** Prime Agent not running or command not recognized.

**Fix:**
```bash
# Make sure Prime Agent is running
./prime-agent.sh

# Inside Prime Agent, type:
/login

# If still not recognized, check Prime Agent version
cat package.json | grep version
```

### ❌ "API key rejected" or "Authentication failed"

**Cause:** Invalid key or expired token.

**Fix:**
```bash
# Clear auth file and re-login
rm ~/.prime/agent/auth.json

# Start Prime Agent fresh
./prime-agent.sh

# Run /login and re-authenticate
```

### ❌ "Model not supported"

**Cause:** Provider requires additional setup or model not enabled.

**Fix:**
- For GitHub Copilot: Enable in VS Code first (Copilot Chat settings)
- For ChatGPT: Use Plus/Pro subscription
- For Claude: Use Pro/Max subscription
- For API keys: Verify key is valid and has correct permissions

---

## 📊 Performance Issues

### ⚠️ "Termux is slow or freezing"

**Cause:** Low device memory or background processes.

**Fix:**
```bash
# Check available memory
free -h

# Kill background processes
# (be careful with this)
ps aux | head -20

# Use lighter mode in Prime Agent
/effort light
```

### ⚠️ "npm install takes forever"

**Cause:** Network issue or package download problem.

**Fix:**
```bash
# Use npm ci (cleaner, faster)
npm ci

# Or force clean start
rm -rf node_modules package-lock.json
npm install

# Use network diagnostics
ping -c 2 8.8.8.8
```

---

## 🛠️ Advanced Troubleshooting

### Enable verbose logging

```bash
# Run Prime Agent with debug output
DEBUG=* ./prime-agent.sh

# Or check logs
tail -f ~/.prime/agent/logs/*
```

### Verify installer script

```bash
# Download installer
curl -fsSL https://raw.githubusercontent.com/Willsonsors/prime-agent/main/packages/coding-agent/install-termux.sh > install-termux.sh

# Check syntax before running
bash -n install-termux.sh

# Run with verbose output
bash -x install-termux.sh
```

### Manual package diagnostics

```bash
# List installed packages
pkg list-installed

# Check package details
pkg show nodejs

# Search for packages
pkg search python

# Remove and reinstall
pkg uninstall nodejs
pkg install nodejs
```

---

## 🆘 Still Having Issues?

1. **Check logs:**
   ```bash
   cat ~/.prime/agent/logs/*.log
   ```

2. **Check GitHub Issues:**
   - [Termux Issues](https://github.com/termux/termux-app/issues)
   - [Prime Agent Issues](https://github.com/Willsonsors/prime-agent/issues)

3. **Ask for help:**
   - [Termux Discussions](https://github.com/termux/termux-app/discussions)
   - [Prime Agent Discussions](https://github.com/Willsonsors/prime-agent/discussions)

4. **System info that helps:**
   ```bash
   # Share this when asking for help:
   uname -a
   pkg list-installed | grep -E "nodejs|git"
   node --version
   npm --version
   ```

---

## Quick Fixes Checklist

- [ ] Termux installed from GitHub/F-Droid (not Play Store)
- [ ] `pkg update && pkg upgrade` run recently
- [ ] All dependencies installed: `nodejs`, `git`, `termux-api`
- [ ] `termux-setup-storage` run once
- [ ] Node.js version 18+: `node --version`
- [ ] Termux:API app installed (for clipboard)
- [ ] Home directory has `.prime/agent/` folder
- [ ] `/login` command works in Prime Agent
- [ ] Sessions auto-save to `~/.prime/agent/sessions/`

---

**Last updated:** 2026-08-25  
**Version:** 1.0 (Termux Integration)
