#!/bin/bash

#install nvidia drivers
#sudo apt install -y nvidia-opencl-dev nvidia-opencl-common
#sudo apt install -y nvidia-driver nvidia-cuda-toolkit

#install sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

#prep wordlists
sudo gunzip /usr/share/wordlists/rockyou.txt.gz
sudo apt install -y seclists

#upload and enumeration scripts
cd /opt
sudo git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git
sudo git clone https://github.com/rebootuser/LinEnum.git
sudo git clone https://github.com/pentestmonkey/php-reverse-shell.git
sudo mkdir pspy
cd pspy
sudo wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32
sudo wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64
sudo wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32s
sudo wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64s
cd ~/

#install necessary tools
sudo apt install -y python3-pip

#install useful tools that should be here
sudo apt install -y gobuster 
sudo apt install -y ffuf
#need this for some CTFs that hide stuff in images
sudo apt install -y steghide
sudo apt install -y libimage-exiftool-perl
sudo gem install seccomp-tools
#install gef for gdb
bash -c "$(curl -fsSL http://gef.blah.cat/sh)"
sudo pip3 install pwntools

#java and ghidra
#use correct java:
sudo update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java

#rustscan
wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb
sudo apt install -y ./rustscan_2.0.1_amd64.deb 
rm rustscan_2.0.1_amd64.deb

# Make sure golang is installed
sudo apt install golang-go


# Install TomNomNom's recon tools
echo "export PATH=$PATH:/home/kali/go/bin"
go get github.com/tomnomnom/waybackurls
go get -u github.com/tomnomnom/dnsgrep
go get -u github.com/tomnomnom/httprobe
go get -u github.com/tomnomnom/gf
go get -u github.com/tomnomnom/fff
go get -u github.com/tomnomnom/meg
go get -u github.com/tomnomnom/assetfinder
go get -u github.com/tomnomnom/anew

