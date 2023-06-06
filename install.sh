COMMAND_TITLE_COLOUR="\033[1;36m"
SEPARATOR_COLOUR="\033[1;30m"
NO_COLOR="\033[0m"
SEPARATOR="\n${DARK_GREY}---------------------------${NO_COLOR}\n"

print_title () {
  printf "$SEPARATOR${COMMAND_TITLE_COLOUR}$1${NO_COLOR}\n"
}

# Setup
# https://askubuntu.com/a/970898
if ! [ $(id -u) = 0 ]; then
   echo "This script must be run with elevated privileges. Try: sudo ./install.sh" >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    ORIGINAL_USER=$SUDO_USER
else
    ORIGINAL_USER=$(whoami)
fi

ORIGINAL_USER_HOME=$(sudo -u "$ORIGINAL_USER" sh -c 'echo $HOME')

## DNS name resolution workaround
print_title "Lock nameserver"
rm -rf /etc/wsl.conf
rm -rf /etc/resolv.conf
echo "[network]\ngenerateResolvConf = false" >> /etc/wsl.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

## Advanced Package Tool (APT)
print_title "Update apt"
apt update

## Simlinks
print_title "Create config files symlinks"
rm -rf $ORIGINAL_USER_HOME/.config
rm -rf $ORIGINAL_USER_HOME/.gitconfig
rm -rf $ORIGINAL_USER_HOME/.zsh
rm -rf $ORIGINAL_USER_HOME/.zshrc
sudo -u $ORIGINAL_USER ln -nfs "$PWD/.config" $ORIGINAL_USER_HOME/.config
sudo -u $ORIGINAL_USER ln -nfs "$PWD/.gitconfig" $ORIGINAL_USER_HOME/.gitconfig
sudo -u $ORIGINAL_USER ln -nfs "$PWD/.zsh" $ORIGINAL_USER_HOME/.zsh
sudo -u $ORIGINAL_USER ln -nfs "$PWD/.zshrc" $ORIGINAL_USER_HOME/.zshrc

## Create .gitconfig.private template
print_title "Create .gitconfig.private template"
sudo -u $ORIGINAL_USER cp "$PWD/.gitconfig.private.example" $ORIGINAL_USER_HOME/.gitconfig.private

# Installations
## Zsh
print_title "Install zsh"
apt install zsh -y
chsh -s $(which zsh)
chsh -s $(which zsh) $ORIGINAL_USER
printf "Current shell: $SHELL"

## Pyenv
print_title "Install pyenv"
rm -rf $ORIGINAL_USER_HOME/.pyenv/
apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y
curl https://pyenv.run | sudo -u $ORIGINAL_USER zsh

## Poetry
print_title "Install poetry"
curl -sSL https://install.python-poetry.org | sudo -u $ORIGINAL_USER python3 -

# Reset the shell
print_title "Restart the shell"
exec sudo -u $ORIGINAL_USER $SHELL
