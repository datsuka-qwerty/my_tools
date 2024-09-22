#!/bin/bash

if [ $(id -u) -ne 0 ]; then
	echo "Do run as root"
	echo "特権モードで実行してください"
	exit 1
fi

echo "Download SoftEther VPN Server."
echo "SoftEther VPN Serverのダウンロードを開始します"

curl -s "https://api.github.com/repos/SoftEtherVPN/SoftEtherVPN_Stable/releases" | sed -n 's/.*\(https:\/\/github.com\/SoftEtherVPN\/SoftEtherVPN_Stable\/releases\/download\/v[0-9]*\.[0-9]*-[0-9]*-rtm\/softether-vpnserver-v[0-9]*\.[0-9]*-[0-9]*-rtm-[0-9]*\.[0-9]*\.[0-9]*-linux-x64-64bit\.tar\.gz\).*/\1/p' | head -n 1 | xargs wget -O /SoftEther.tar.gz

if [ $? -ne 0 ]; then
	echo "Download failed."
	echo "SoftEther VPN Serverのダウンロードに失敗しました。"
	echo "SoftEtherダウンロード失敗時の対処シートにある手順を実行してください。"
	exit 1
fi

echo "Download fnished."
echo "ダウンロードが正常に終了しました"
echo

echo "Install SoftEther VPN Server."
echo "SoftEther VPN Serverのインストールを開始します"
tar xzvf /SoftEther.tar.gz -C /usr/local
make /usr/local/vpnserver
chmod 600 /usr/local/vpnserver/* && chmod 700 /usr/local/vpnserver/vpncmd && chmod 700 /usr/local/vpnserver

cat <<- 'EOF' > /etc/init.d/vpnserver
	#!/bin/sh
	# chkconfig: 2345 99 01
	# description: SoftEther VPN Server
	DAEMON=/usr/local/vpnserver/vpnserver
	LOCK=/var/lock/subsys/vpnserver
	test -x $DAEMON || exit 0
	case "$1" in
	start)
	$DAEMON start
	touch $LOCK
	;;
	stop)
	$DAEMON stop
	rm $LOCK
	;;
	restart)
	$DAEMON stop
	sleep 3
	$DAEMON start
	;;
	*)
	echo "Usage: $0 {start|stop|restart}"
	exit 1
	esac
	exit 0
	EOF

chmod 755 /etc/init.d/vpnserver
update-rc.d vpnserver defaults

echo "Install finished."
echo "SoftEther VPN Serverのインストールが正常に終了しました。"
echo "Require reboot via procedure."
echo "手順書に従って、システムの再起動を行ってください"