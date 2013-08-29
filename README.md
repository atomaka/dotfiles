```
sudo apt-get install tmux zsh zclip
chsh -s /bin/zsh
```

Install rbenv
```
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
```

```
exec $SHELL -1
git clone repo
mv dotfiles/\* .
git submodule update --init
source .zshrc
```

```:BundleInstall``` inside of vim

```
exec $SHELL -1
rbenv install 1.9.3-p327
rbenv rehash
```

Remote Server:
edit /etc/ssh/sshd_config

```
PermitTunnel yes
GatewayPorts yes
```

