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
		- [kyoshin\_Eew\_Viewer\_Ingen\_workflow.json](#kyoshin_eew_viewer_ingen_workflowjson)
		- [Microsoft.PowerShell\_profile.ps1](#microsoftpowershell_profileps1)
		- [setting.json](#settingjson)
		- [user\_snippets\_latex.json](#user_snippets_latexjson)
		- [vscode\_custom\_css.css](#vscode_custom_csscss)
		- [VlcPrevNext.lua](#vlcprevnextlua)
		- [init.vim](#initvim)
	- [./extension\_setting](#extension_setting)
		- [Enhancer\_for\_YouTube.txt](#enhancer_for_youtubetxt)
		- [SponsorBlockConfig.json](#sponsorblockconfigjson)
		- [vimium-options.json](#vimium-optionsjson)
	- [./HHKB](#hhkb)
	- [./usercommand](#usercommand)
		- [allrename](#allrename)
		- [avcnv](#avcnv)
		- [dis-install](#dis-install)
		- [nano-install.sh](#nano-installsh)
		- [pdf2p](#pdf2p)
		- [termux-install](#termux-install)
		- [termux-url-opener](#termux-url-opener)
		- [ytd](#ytd)
		- [ytd.bat](#ytdbat)

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
### kyoshin_Eew_Viewer_Ingen_workflow.json
Voice Vox settings for Kyoshin Eew Viewer Ingen.
### Microsoft.PowerShell_profile.ps1
This is a Powershell7 configuration file.  
It sets up a theme using oh my posh.
### setting.json
This is the VSCode configuration file.
### user_snippets_latex.json
This is a VSCode snippet for LaTeX.  
For more information, please see [my blog](https://datsuka-qwerty.hatenablog.com/entry/latex/linux_install) (Japanese only)
### vscode_custom_css.css
This is Override VSCode Logo to Kawaii Logo.
### VlcPrevNext.lua
Play next video in same folder feature for VLC media player.
### init.vim
My vim settings.
## ./extension_setting
### Enhancer_for_YouTube.txt
Enhancer for Youtube configuration file.  
### SponsorBlockConfig.json
Configuration file for SponsorBlock extension.  
Replace the string in the Secret User ID section with your own ID.
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

```sh
bash <(curl -s https://raw.githubusercontent.com/datsuka-qwerty/my_tools/main/usercommand/dis-install)
```

### nano-install.sh
This is a script to build the nano environment.
You can chose installing scopatz's nano syntax highlihting.   
```sh
bash <(curl -s https://raw.githubusercontent.com/datsuka-qwerty/my_tools/main/usercommand/nano-install.sh)
```

### pdf2p
This is a script that performs mutual conversion between PDF and JPG,PNG using the pdftoppm and convert commands.
```$ pdf2p <convert file>```
### termux-install
This is a script to install yt-dlp on Termux.  
For more information, please see [my blog](https://datsuka-qwerty.hatenablog.com/entry/androidtips/termux-youtube-dl) (Japanese only)
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