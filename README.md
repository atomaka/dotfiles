```
sudo apt-get install tmux zsh zclip
chsh -s /bin/zsh
```

LOGOUT COMPLETELY and relogin

```
git clone repo
mv dotfiles/\* .
git submodule update --init
source .zshrc
```

```:BundleInstall``` inside of vim

Remote Server:
edit /etc/ssh/sshd_config

```
PermitTunnel yes
GatewayPorts yes
```

