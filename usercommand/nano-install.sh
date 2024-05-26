#!/bin/bash

if [ $(id -u) -eq 0 ]; then
	echo "Do not run as root"
	exit 1
fi

echo "This is a script created by datsuka-qwerty to build the nano environment."
echo "You can use the syntax highlighting at https://github.com/scopatz/nanorc ."
echo -n "Do you want to install scopatz's nano syntax highlihting? [Y/n]: "
read ANS

# check installed nano on system
echo "Checking is nano installed on this system..."
type "nano" > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "nano is installed on this system"
else
	echo "nano is NOT installed on this system"
	echo "Do you want to install nano? [Y/n]: "
	read NANOINST
	case $NANOINST in
		"" | [Yy]* )
			echo "Enter sudo password to install nano"
			stty -echo && read -rp "Password: " passwd
			echo
			echo $passwd | sudo -S -k echo > /dev/null 2>%1
			if [ $? -eq 0 ]; then
				echo "Password is correct!"
				echo $passwd | sudo -S -k apt update
				echo $passwd | sudo -S -k apt install -y nano
				if [ $? -eq 0 ]; then
					echo "Done!"
				else
					echo "Something went to wrong :("
					exit 1
				fi
			else
				echo "Password is incorrect :("
				exit 1
			fi
			;;
		* )
			echo "EXIT!"
			exit 0
			;;
	esac
fi

# check nanorc exits
if [ ! -e ~/.nanorc ]; then
	echo "Creating ~/.nanorc"
	touch ~/.nanorc
	if [ $? -eq 0 ]; then
		echo "Done!"
	else
		echo "Something went to wrong :("
		exit 1
	fi
else
	echo "Backing up ~/.nanorc to ~/nanorc.bak"
	cp ~/.nanorc ~/nanorc.bak
	if [ $? -eq 0 ]; then
		echo "Done!"
	else
		echo "Something went to wrong :("
		exit 1
	fi
fi

# write settings
echo "Write settings to ~/.nanorc"
cat <<EOF > ~/.nanorc
# appearance settings
set mouse
set tabsize 4
set autoindent
set linenumbers
set titlecolor white,cyan
set numbercolor yellow,black
set functioncolor white
set statuscolor white,cyan

# keybind settings
bind ^F whereis all
bind ^R replace main
bind ^C copy main
bind ^V paste all
bind ^Z undo all

EOF
if [ $? -eq 0 ]; then
	echo "Done!"
else
	echo "Something went to wrong :("
	exit 1
fi

# install syntax highlighting
case $ANS in
	"" | [Yy]* )
		echo "Cloning repository..."
		curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
		if [ $? -eq 0 ]; then
			echo "Done!"
		else
			echo "Something went to wrong :("
			exit 1
		fi
		;;
	* )
		echo ""
		;;
esac