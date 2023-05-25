# Setup
# https://askubuntu.com/a/970898
if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    ORIGINAL_USER=$SUDO_USER
else
    ORIGINAL_USER=$(whoami)
fi

ORIGINAL_USER_HOME=$(sudo -u "$ORIGINAL_USER" sh -c 'echo $HOME')

## DNS name resolution workaround
rm -rf /etc/wsl.conf
rm -rf /etc/resolv.conf
echo "[network]\ngenerateResolvConf = false" >> /etc/wsl.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

## Advanced Package Tool (APT)
apt update

# Simlinks
rm -rf $ORIGINAL_USER_HOME/.config
rm -rf $ORIGINAL_USER_HOME/.gitconfig
rm -rf $ORIGINAL_USER_HOME/.zsh
rm -rf $ORIGINAL_USER_HOME/.zshrc
sudo -u $ORIGINAL_USER ln -nfs "$PWD/.config" $ORIGINAL_USER_HOME/.config
sudo -u $ORIGINAL_USER ln -nfs "$PWD/.gitconfig" $ORIGINAL_USER_HOME/.gitconfig
sudo -u $ORIGINAL_USER ln -nfs "$PWD/.zsh" $ORIGINAL_USER_HOME/.zsh
sudo -u $ORIGINAL_USER ln -nfs "$PWD/.zshrc" $ORIGINAL_USER_HOME/.zshrc

# Installations
## Zsh
apt install zsh -y
chsh -s $(which zsh)

## Pyenv
rm -rf $ORIGINAL_USER_HOME/.pyenv/
#apt install make build-essential libssl-dev zlib1g-dev \
#libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
#libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y
#curl https://pyenv.run | zsh
#exec $SHELL

## Poetry


