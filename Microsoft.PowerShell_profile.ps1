# oh-my-posh settings
oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config $env:POSH_THEMES_PATH/craver.omp.json | Invoke-Expression

# User alias
Set-Alias touch New-Item
Set-Alias grep findstr
Set-Alias vim "C:\Program Files\Vim\vim91\vim.exe"
Set-Alias git "C:\Users\rento\AppData\Local\GitHubDesktop\app-3.4.3\resources\app\git\mingw64\bin\git.exe"

function git() {
        . $HOME\AppData\Local\GitHubDesktop\app-3.4.3\resources\app\git\mingw64\bin\git.exe
}
function cdd() {
        cd $HOME
}
function which($commandname) {
        Get-Command $commandname | Select-Object -ExpandProperty Definition
}
