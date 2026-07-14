# Mac Setup

Scripts and checklist for configuring a new Mac from scratch.

---

## Task List (In order)

### Before running setup.sh
- [ ] Log into iCloud
- [ ] Log into Mac App Store
- [ ] Log into Messages
- [ ] Configure Photos to Optimize Storage
- [ ] Log into Mail (Gmail)
  - [ ] Add Gmail signature

### Run setup script
- [ ] Set execute permissions and run
      <pre><code>chmod u+x setup.sh && ./setup.sh</code></pre>

### After setup.sh
- [ ] Clone config repos
      <pre><code>git clone git@github.com:smarba/.config.git ~/.config
git clone git@github.com:smarba/macsetup.git ~/macsetup
git clone git@github.com:smarba/ansible.git ~/ansible</code></pre>
- [ ] Clone ZSH plugins
      <pre><code>mkdir -p ~/.config/zsh/plugins
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.config/zsh/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.config/zsh/plugins/zsh-history-substring-search</code></pre>
- [ ] Set JetBrainsMono Nerd Font in Terminal.app
      <pre><code>Terminal → Settings → Profiles → [profile] → Font → Change → JetBrainsMono Nerd Font Mono</code></pre>
- [ ] Log into 1Password
  - [ ] Configure 1Password
  - [ ] Configure 1Password for Safari
- [ ] Log into Tailscale
  - [ ] Set On Demand to not connect when on home WiFi
  - [ ] Configure to use Exit Node when connected
- [ ] Log into Dropbox
  - [ ] Configure sync folders
- [ ] Log into ExpressVPN

---

## ZSH Configuration

See `ZSH.md` for full documentation on aliases, tools, plugins, and prompt configuration.
