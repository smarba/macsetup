## Mac Setup

This is the beginning of a mac setup script to run to configure a new mac the way it is desired.

### Task List

- [ ] Set execute permissions on setup.sh
      <pre><code>chmod u+x setup.sh</code></pre>
- [ ] Execute setup.sh
      <pre><code>./setup.sh</code></pre>
- [ ] Log into iPassword
  - [ ] Configure 1Password
  - [ ] Configure iPassword for Safari
- [ ] Log into Tailscale
- [ ] Log into Dropbox
  - [ ] Configure sync folders
- [ ] Update .zshrc
      <pre><code># Load custom aliases if they exist
      [ -f ~/dotfiles/.aliases ] && source ~/dotfiles/.aliases</code></pre>
- [ ] Create dotfiles folder
      <pre><code></code>mkdir dotfiles
      cp ~/macsetup/.aliases ~/dotfiles/</code></pre>




