while test -f ngrok-v3-stable-linux-amd64.tgz
do
	wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
done
tar -xvf ngrok-v3-stable-linux-amd64.tgz
sudo mv ./ngrok /bin/ngrok
rm -rf ngrok-v3-stable-linux-amd64.tgz
cd ~
sudo chmod 777 /bin/ngrok
if [-f "kmrcs_ngrok.txt"]
then
    authtoken_ngrok=$(<kmrcs_ngrok.txt)
    ngrok authtoken $authtoken_ngrok
else
    read -p "Paste authtoken vào đây: " authtoken_ngrok
    echo "$authtoken_ngrok" > "kmrcs_ngrok.txt"
    ngrok authtoken $authtoken_ngrok
fi
echo "Done setting up NGROK ! Redirecting..."
DEBIAN_FRONTEND=noninteractive sudo apt install --assume-yes --install-recommends xfce4 xarchiver firefox-esr xfce4-goodies dialog autocutsel dbus-x11 dbus curl tar net-tools tigervnc-standalone-server tigervnc-xorg-extension
export HOME="$(pwd)"
export DISPLAY=":0"
cd $HOME 2> /dev/null
cd ~/ 2> /dev/null
unset DBUS_LAUNCH
export HOME="$(pwd)"
export DISPLAY=":0"
sudo killall ngrok
#sudo killall vncserver
vncserver -kill :0
nohup ngrok tcp 5900 &> /dev/null &
vncserver :0
sudo /sbin/sysctl -w net.ipv4.tcp_keepalive_time=10000 net.ipv4.tcp_keepalive_intvl=5000 net.ipv4.tcp_keepalive_probes=100
khanhall="$(service  --status-all 2> /dev/null | grep '\-' | awk '{print $4}')"
while IFS= read -r line; do
    nohup sudo service "$line" start &> /dev/null 2> /dev/null &
done < <(printf '%s\n' "$khanhall")
printf "\nYour IP Here: "
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
export PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
printf "\n\n"
### This line by kmille36
seq 1 9999999999999 | while read i; do echo -en "\r Running .     $i s /9999999999999 s";sleep 0.1;echo -en "\r Running ..    $i s /9999999999999 s";sleep 0.1;echo -en "\r Running ...   $i s /9999999999999 s";sleep 0.1;echo -en "\r Running ....  $i s /9999999999999 s";sleep 0.1;echo -en "\r Running ..... $i s /9999999999999 s";sleep 0.1;echo -en "\r Running     . $i s /9999999999999 s";sleep 0.1;echo -en "\r Running  .... $i s /9999999999999 s";sleep 0.1;echo -en "\r Running   ... $i s /9999999999999 s";sleep 0.1;echo -en "\r Running    .. $i s /9999999999999 s";sleep 0.1;echo -en "\r Running     . $i s /9999999999999 s";sleep 0.1; done
