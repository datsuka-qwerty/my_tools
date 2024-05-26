# This is my tool box
## !ATTENTION!
これらのスクリプトを使用する際は、**自己責任**でお願いいたします。
また、実行する前にスクリプト等の中身を確認してください。


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
	- [./vivaldi\_thumbnails](#vivaldi_thumbnails)

# About the tools
## ./
### caps2ctrl_regedit.reg
CapsをCtrlにするWidows用のレジストリです。
### GAS_payroll.js
GoogleカレンダーとSheetをGASで連携させ、給与計算ができるスクリプトです。  
詳しくは、[記事](https://datsuka-qwerty.hatenablog.com/entry/diary/gas_payroll)をご覧ください。
### installed_app_list.json
Windowsのクリーンインストール時に毎回wingetで、インストールしているソフトウェアたちです。
### keymap.txt
Google日本語入力でIMEのキーマップを変更するための設定ファイルです。
Ctrl+SpaceでIMEのオン・オフができるようにしています。
### Microsoft.PowerShell_profile.ps1
Powershell7のプロフィールです。  
oh my poshのテーマを設定しています。
### setting.json
todo tree用のVSCodeのsetting.jsonです。  
詳しくは、[記事](https://datsuka-qwerty.hatenablog.com/entry/latex/linux_install)をご覧ください。
### user_snippets_latex.json
LateX用のVSCodeスニペットです。
詳しくは、[記事](https://datsuka-qwerty.hatenablog.com/entry/latex/linux_install)をご覧ください。
## ./extension_setting
### Enhancer_for_YouTube.txt
Enhancer for Youtubeの設定ファイルです。
### SponsorBlockConfig.json
SponsorBlock拡張機能の設定ファイルです。
UserIDの部分を自身のIDに変更してください。
### vimium-options.json
Chrome向け拡張機能のvimiumの設定ファイルです。
## ./HHKB
HHKB Hybrid TypeS用のキーマップ設定ファイルです。  
左AltをFnにしています。
## ./usercommand
### allrename
カレントディレクトリのすべてのファイル名の末尾に拡張子を付与するスクリプトです。  
```$ allrename <拡張子>```
### avcnv
第一引数形式の動画をffmpegを用いて全て第二引数形式に変換するスクリプトです。  
ffmpegがワイルドカードに非対応なので作りました。
```$ avcnv <変換前拡張子> <変換後拡張子>```
### dis-install
DiscordとBetterDiscordをインストールするためのスクリプトです。  
毎回ブラウザ開くのメンドイので作りました。
### nano-install.sh
nanoの各種設定や、キーバイドを生成するスクリプトです。
毎回.nanorcを編集するのが面倒で作りました。
scopatz氏作成のシンタックスハイライトをダウンロードするオプションも入れました。
### pdf2p
PDFとJPG, PNGとを相互に変換できるスクリプトです。  
pdftoppmとconvertコマンドを使ってます。
```$ pdf2p <変換したいファイル>```
### termux-install
termuxにyt-dlpをインストールするためのスクリプトです。
### termux-url-opener
termux上でyt-dlpを使った動画のダウンロードを行うためのスクリプトです。  
~/binに配置すると、共有画面から実行できます。  
詳しくは、[記事](https://datsuka-qwerty.hatenablog.com/entry/androidtips/termux-youtube-dl)をご覧ください。
### ytd
yt-dlpを実行するためのスクリプトです。  
オプションを自分用に付与してあるので、都度調整してください
```$ ytd [option] <URL>```
### ytd.bat
Windows版です。
```C:/> ytd [option] <URL>```
## ./vivaldi_thumbnails
Vivaldiブラウザーのスピードダイヤルで使っているロゴ達です。