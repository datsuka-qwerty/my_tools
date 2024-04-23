# This is my tool box
## !ATTENTION!
Use these tools at your **OWN RISK**.  
Also, please check the contents carefully **before** executing them.

__日本語版は[こちら](/README.jp.md)__

- [This is my tool box](#this-is-my-tool-box)
	- [!ATTENTION!](#attention)
- [About the tools](#about-the-tools)
	- [./](#)
		- [caps2ctrl\_regedit.reg](#caps2ctrl_regeditreg)
		- [GAS\_payroll.js](#gas_payrolljs)
		- [installed\_app\_list.json](#installed_app_listjson)
		- [keymap.txt](#keymaptxt)
		- [Microsoft.PowerShell\_profile.ps1](#microsoftpowershell_profileps1)
		- [setting.json](#settingjson)
		- [user\_snippets\_latex.json](#user_snippets_latexjson)
	- [./extension\_setting](#extension_setting)
		- [Enhancer\_for\_YouTube.txt](#enhancer_for_youtubetxt)
		- [vimium-options.json](#vimium-optionsjson)
	- [./HHKB](#hhkb)
	- [./usercommand](#usercommand)
		- [allrename](#allrename)
		- [avcnv](#avcnv)
		- [dis-install](#dis-install)
		- [pdf2p](#pdf2p)
		- [termux-url-opener](#termux-url-opener)
		- [ytd](#ytd)
		- [ytd.bat](#ytdbat)
	- [./vivaldi\_thumbnails](#vivaldi_thumbnails)

# About the tools
## ./
### caps2ctrl_regedit.reg
This reg file changes Caps to Ctrl in Windows using the Registry Editor.
### GAS_payroll.js
This script links GoogleCalendar and Sheet using GAS to calculate payroll.  
For more information, please see [my blog](https://datsuka-qwerty.hatenablog.com/entry/diary/gas_payroll) (Japanese only)
### installed_app_list.json
This is the list of software that should be installed first in Windows using winget.
### keymap.txt
This is the IME keymap configuration file for Google Japanese Input.  
It is set up so that you can turn on/off IME by pressing Ctrl+Space.
### Microsoft.PowerShell_profile.ps1
This is a Powershell7 configuration file.  
It sets up a theme using oh my posh.
### setting.json
This is the VSCode configuration file for the todo tree.  
For more information, please see [my blog](https://datsuka-qwerty.hatenablog.com/entry/latex/linux_install) (Japanese only)
### user_snippets_latex.json
This is a VSCode snippet for LaTeX.  
For more information, please see [my blog](https://datsuka-qwerty.hatenablog.com/entry/latex/linux_install) (Japanese only)
## ./extension_setting
### Enhancer_for_YouTube.txt
Enhancer for Youtube configuration file.  
### vimium-options.json
This is a configuration file for vimium, an extension for Chrome.
## ./HHKB
This is the keymap file for the HHKB Hybrid TypeS.  
The main change is that the left Alt is the Fn key.
## ./usercommand
### allrename
This is a script that appends the first argument extension to the end of all files in the current directory.  
```$ allrename <extension>```
### avcnv
This is a script that allows ffmpeg to use pseudo wildcards.  
All files in the current directory with the extension selected in the first argument are converted using ffmpeg to the format of the second argument.
```$ avcnv <convert from extension> <convert to extension>```
### dis-install
This is a script to install Discord and BetterDisocrd.  
Please append the save path before running.
### pdf2p
This is a script that performs mutual conversion between PDF and JPG,PNG using the pdftoppm and convert commands.
```$ pdf2p <convert file>```
### termux-url-opener
This is a script to download videos etc. using yt-dlp on termux.  
If placed in ~/bin, it can be run from the share screen.  
For more information, please see [my blog](https://datsuka-qwerty.hatenablog.com/entry/androidtips/termux-youtube-dl) (Japanese only)
### ytd
This is a script to download videos, etc. using yt-dlp.  
```$ ytd [option] <URL>```
### ytd.bat
This is a script to download videos, etc. using yt-dlp.  
```C:/> ytd [option] <URL>```
## ./vivaldi_thumbnails
This is the logo used in the speed dial of the vivaldi browser