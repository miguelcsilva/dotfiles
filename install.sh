# Setup
## DNS name resolution workaround
echo "[network]\ngenerateResolvConf = false" >> /etc/wsl.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

## Advanced Package Tool (APT)
apt update

# Simlinks
ln -nfs /home/miguel/projects/dotfiles/.config /home/miguel/.config
ln -nfs /home/miguel/projects/dotfiles/.gitconfig /home/miguel/.gitconfig
ln -nfs /home/miguel/projects/dotfiles/.zsh /home/miguel/.zsh
ln -nfs /home/miguel/projects/dotfiles/.zshrc /home/miguel/.zshrc

# Installations
## Zsh
apt install zsh -y
chsh -s $(which zsh)

## Pyenv
rm -rf /root/.pyenv/
apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y
curl https://pyenv.run | zsh
exec $SHELL

## Poetry


