#!/bin/bash

if [ $(id -u) -ne 0 ]; then
	echo "Do run as root"
	echo "特権モードで実行してください"
	exit 1
fi

VPNCMD=/usr/local/vpnserver/vpncmd

if [ -f "$VPNCMD" ]; then
	echo "SoftEtherVPN Server installed." > /dev/null 2>%1
else
	echo "Please install SoftEtherVPN Sever"
	echo "SoftEtherVPN Serverをインストール後に実行してください"
	exit 1
fi

echo "Create consecutive VirtualHUBs starting from the number entered in START to the number entered in END."
echo "STARTに入力された数字からENDに入力された数字までの連続した仮想HUBを作成します。"
echo "Log feature is automatically OFF."
echo "パケットのログ保存機能は自動的にオフにされます。"
echo -n "START VLAN NUMBER: "
read ST
echo -n "END VLAN NUMBER: "
read EN
echo "Enter SoftEther admin password."
echo -n "SoftEtherの管理者パスワードを入力してください: "
read SEPW
echo "Enter Virtual HUB's password."
echo -n "仮想HUBに設定するパスワードを入力してください"
read VHUBPW

# vhub preview
for i in $(seq $ST $EN)
do
	echo "vSwitch$i"
done
echo

# vhub check
echo "is the VHUB being created correctly?"
echo -n "作成する仮想HUBは正しいですか？[Y/n]: "
read ANS
case $ANS in
	"" | [Yy]* )
		echo "Create VHUB"
		echo "この内容で仮想HUBを作成します。"
		;;
	* )
		echo "Aborted!"
		echo "変更を加えず終了します"
		exit 1
		;;
esac

# vhub creating
for i in $(seq $ST $EN)
do
	$VPNCMD /server localhost /password:$SEPW /cmd hubcreate vSwitch$i /password:$VHUBPW
	$VPNCMD /server localhost /password:$SEPW  /adminhub:vSwitch$i /cmd logdisable packet
done

echo "Finished!"
echo "処理を終了します"