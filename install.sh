
#!/data/data/com.termux/files/usr/bin/bash

R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
W="$(printf '\033[1;37m')"
C="$(printf '\033[1;36m')"

banner() {
clear

}

kfce_setup() {
	banner
	echo -e "${R} [${W}-${R}]${C} Installing XFCE DESKTOP"${W}
	pkg update
       pkg install xfce4 -y
       banner
       echo -e "${R} [${W}-${R}]${C} Setting up VNC Server..."${W}
  if [[ ! -d "$HOME/.vnc" ]]; then
        mkdir -p "$HOME/.vnc"
    fi
   if [[ -e "/usr/local/bin/vncstart" ]]; then
        rm -rf /usr/local/bin/vncstart
    fi
  echo "dbus-launch" >>/usr/local/bin/vncstart
  echo "vncserver -geometry 1080x720  -xstartup /usr/bin/startxfce4" >>/usr/local/bin/vncstart
  chmod +x /usr/local/bin/vncstart
  if [[ -e "/usr/local/bin/vncstop" ]]; then
        rm -rf /usr/local/bin/vncstop
    fi
  echo "#!/usr/bin/env bash" >>/usr/local/bin/vncstop
  echo "vncserver -kill :*" >>/usr/local/bin/vncstop
  echo "rm -rf /username/.vnc/localhost:*.pid" >>/usr/local/bin/vncstop
  echo "rm -rf /tmp/.X1-lock" >>/usr/local/bin/vncstop
  echo "rm -rf /tmp/.X11-unix/X1" >>/usr/local/bin/vncstop
    chmod +x /usr/local/bin/vncstop

}

package() {
	termux-setup-storage
	sleep 0.5
	banner
    echo -e "${R} [${W}-${R}]${C} Checking required packages..."${W}
    pkg update -y
    pkg install x11-repo -y
    packs=(  wget curl nano git qterminal mousepad inetutils-tools dialog tightvncserver tigervnc-standalone-server tigervnc-tools dbus )
      dpkg --configure -a
    for hulu in "${packs[@]}"; do
        type -p "$hulu" &>/dev/null || {
            echo -e "\n${R} [${W}-${R}]${G} Installing package : ${Y}$hulu${C}"${W}
            pkg-get install "$hulu" -y --no-install-recommends
        }
    done
}

note() {
banner
    echo -e " ${G} Successfully Installed !"${W}
    sleep 1
    echo
    echo -e " ${G}Type ${C}vncstart${G} to run Vncserver."${W}
    echo
    echo -e " ${G}Type ${C}vncstop${G} to stop Vncserver."${W}
    echo
    echo -e " ${C}Install VNC VIEWER OR Nethunter Kex on your Device."${W}
    echo
    echo -e " ${C}Open VNC VIEWER & Click on + Button."${W}
    echo
    echo -e " ${C}Enter the Address localhost:1 & Name anything you like."${W}
    echo
    echo -e " ${C}Set the Picture Quality to High for better Quality."${W}
    echo

    echo -e " ${C}Click on Connect & Input the Password."${W}
    echo
}

customize() {
	if [[ $(command -v plank) ]]; then
	echo "${G}Plank is already installed .."${W}
        sleep .5
        clear
   else
	   clear
	   sleep 1
	   echo "${G}Plank not found.Installing now.."${W}
	   echo
	   apt install plank -y
	fi
mkdir /data/data/com.termux/files/home/.config/autostart/
        touch /data/data/com.termux/files/home/.config/autostart/plank.desktop
        echo "[Desktop Entry]" >>/data/data/com.termux/files/home/.config/autostart/plank.desktop
        echo "Type=Application" >>/data/data/com.termux/files/home/.config/autostart/plank.desktop
        echo "Name=Plank" >>/data/data/com.termux/files/home/.config/autostart/plank.desktop
        echo "Exec=plank" >>/data/data/com.termux/files/home/.config/autostart/plank.desktop
        chmod +x /data/data/com.termux/files/home/.config/autostart/plank.desktop
	mv ~/termux-gui/setup/appmenu/setup-look ~/
	chmod +x ~/setup-look

}

package
kfce_setup
customize
