## Mac Setup Script

This is the beginning of a mac setup script to run to configure a new mac the way it is desired.

This first step is to set the three different hostnames (or change them on an existing system) to the desired name

install xcode tools
<pre> <code> </code>xcode-select --install </code> </pre>

install homebrew
<pre> <code> /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </code> </pre>

using homebrew, install git, ansible
<code> brew install git ansible </code>

create ssh key
<code> ssh-keygen </code>

log into github and save the ssh key to github
install dropbox
<pre><code>https://www.dropbox.com/download?os=mac&plat=mac </code> </pre>

pull down ansible repo from github

<pre><code>git clone</code></pre>

<pre><code> curl -L -o /Users/smarba/Downloads/dropbox_installer.dmg "https://www.dropbox.com/download?os=mac&plat=mac"</code> </pre>
