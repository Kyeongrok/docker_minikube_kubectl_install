apt update
apt install glances -y
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
echo "alias k='kubectl'" >> ~/.bashrc
. ~/.bashrc
