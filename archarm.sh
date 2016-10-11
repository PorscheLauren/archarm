#!/bin/bash
REPOPATH="https://github.com/PorscheLauren/archarm"

# Update pacman
pacman -Syyu
if !(which wget)
then
	pacman -Sy wget
fi
pacman -S mesa-libgl xorg-server xorg-xinit xorg-server-utils xterm alsa-utils alsamixer
pacman -S xf86-video-fbdev xf86-input-synaptics python3 smplayer smtube chromium wicd wicd-gtk
pacman -S bluez pulseaudio pavucontrol geary gedit
pacman -S lightdm lightdm-greeter
systemctl enable lightdm
echo "exec xfce4" > ~/.xinitrc
echo "exec bluez" > ~/.xinitrc
echo "pulseaudio" >~/.xinitrc
# add xorg.conf
cd /etc/X11/xorg.conf.d/
wget ${REPOPATH}10-monitor.conf
wget ${REPOPATH}50-touchpad.conf
# add user xx and sudoers
useradd -m -G wheel -S /bin/bash xx
# set pass
passwd xx
# sudo
cd /etc/sudoers
wget ${REPOPATH}sudoers
# best sound settings
cp /etc/pulse/daemon.conf /etc/pulse/daemon.conf.bak
cd  /etc/pulse
wget ${REPOPATH}daemon.conf
wget ${REPOPATH}default.pa
wget ${REPOPATH}system.pa
cd /etc/
wget ${REPOPATH}asound.conf
## all done reboot 
