#!/bin/bash

if [ $(id -u) -ne 0 ]; then
	echo "Do run as root"
	echo "特権モードで実行してください"
	exit 1
fi

FILEPATH=/etc/network/interfaces

mv $FILEPATH /interfaces.bak && echo "Successfully backuped interfaces file." && echo "現在のVLAN設定のバックアップに成功しました。"

echo "Create consecutive VLANs starting from the number entered in START to the number entered in END."
echo "STARTに入力された数字からENDに入力された数字までの連続したVLANを作成します"
echo -n "START VLAN NUMBER: "
read ST
echo -n "END VLAN NUMBER: "
read EN

# exist check
echo "Please enter y to append without overwriting the current VLAN configuration; otherwise, enter n or just press Enter."
echo -n "現在のVLAN設定を上書きせず、追記する場合は、yを入力してください。そうでない場合は、nかそのままEnterを入力してください[y/N]: "
read EXISTCHK
case $EXISTCHK in
	"" | [Nn]* )
		echo "Overwritign VLANs"
		echo "VLAN設定を上書きして保存します。"
		cat <<- 'EOF' > $FILEPATH
		# This file describes the network interfaces available on your system
		# and how to activate them. For more information, see interfaces(5).

		source /etc/network/interfaces.d/*

		# The loopback network interface
		auto lo
		iface lo inet loopback
		
		# The primary network interface
		auto eno1
		iface eno1 inet dhcp

		# The secondary network interface

		EOF
		echo
		;;
	* )
		echo "Without overwriting VLAN"
		echo "VLAN設定を上書きせず追記します"
		echo
		;;
esac

# vlan preview
for i in $(seq $ST $EN)
do
	echo "auto eno2.$i"
	echo "iface eno2.$i"
	echo "vlan-row-device echo2"
	echo
done

# vlan check
echo "Is the VLAN being created correctly?"
echo -n "作成するVLANは正しいですか？"
read ANS
case $ANS in
	"" | [Yy]* )
		echo "Create VLAN."
		echo "この内容でVLANを作成します"
		;;
	* )
		echo "Aborted!"
		echo "変更を加えず終了します。"
		exit 1
		;;
esac

# vlan writing
for i in $(seq $ST $EN)
do
	echo "#VLAN $i" >> $FILEPATH
	echo "auto eno2.$i" >> $FILEPATH
	echo "iface eno2.$i" >> $FILEPATH
	echo "vlan-row-device echo2" >> $FILEPATH
	echo >> $FILEPATH
done

echo "Finished!"
echo "処理を終了します"
