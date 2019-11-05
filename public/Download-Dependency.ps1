# xah-lookup
if (-not (Test-Path "${PsScriptRoot}/xah-lookup.el" -PathType leaf)) {
    Write-Host 'Download: xah-lookup'
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/xahlee/lookup-word-on-internet/master/xah-lookup.el' -OutFile "${PsScriptRoot}/xah-lookup.el"
}

# chinese-fonts-setup
if (-not (Test-Path "${PsScriptRoot}/chinese-fonts-setup.el" -PathType leaf)) {
    Write-Host 'Download: chinese-fonts-setup'
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Dewdrops/chinese-fonts-setup/master/chinese-fonts-setup.el' -OutFile "${PsScriptRoot}/chinese-fonts-setup.el"
}

# xah-get-thing-or-selection
if (-not (Test-Path "${PsScriptRoot}/xah-get-thing.el" -PathType leaf)) {
    Write-Host 'Download: xah-get-thing-or-selection'
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/xahlee/xah-get-thing-or-selection/master/xah-get-thing.el' -OutFile "${PsScriptRoot}/xah-get-thing.el"
}

# eim
if (-not (Test-Path "${PsScriptRoot}/eim" -PathType Container)) {
    Write-Host 'Download: eim'
    Invoke-WebRequest -Uri 'https://github.com/wenbinye/emacs-eim/archive/master.zip' -OutFile "${PsScriptRoot}/emacs-eim.zip"
    Expand-Archive -Path "${PsScriptRoot}/emacs-eim.zip"
    Remove-Item -Path "${PsScriptRoot}/emacs-eim.zip"
    Move-Item "${PsScriptRoot}/emacs-eim/emacs-eim-master" "${PsScriptRoot}/eim"
    Remove-Item -Path "${PsScriptRoot}/emacs-eim/"
}

# json-mode
if (-not (Test-Path "${PsScriptRoot}/json-mode.el" -PathType leaf)) {
    Write-Host 'Download: json-mode'
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/DoMiNeLa10/json-mode/master/json-mode.el' -OutFile "${PsScriptRoot}/json-mode.el"
}

# request
if (-not (Test-Path "${PsScriptRoot}/request" -PathType Container)) {
    Write-Host 'Download: request'
    Invoke-WebRequest -Uri 'https://github.com/tkf/emacs-request/archive/master.zip' -OutFile "${PsScriptRoot}/emacs-request.zip"
    Expand-Archive -Path "${PsScriptRoot}/emacs-request.zip"
    Remove-Item -Path "${PsScriptRoot}/emacs-request.zip"
    Move-Item "${PsScriptRoot}/emacs-request/emacs-request-master" "${PsScriptRoot}/request"
    Remove-Item -Path "${PsScriptRoot}/emacs-request/"
}

# web
if (-not (Test-Path "${PsScriptRoot}/web" -PathType Container)) {
    Write-Host 'Download: web'
    Invoke-WebRequest -Uri 'https://github.com/nicferrier/emacs-web/archive/master.zip' -OutFile "${PsScriptRoot}/emacs-web.zip"
    Expand-Archive -Path "${PsScriptRoot}/emacs-web.zip"
    Remove-Item -Path "${PsScriptRoot}/emacs-web.zip"
    Move-Item "${PsScriptRoot}/emacs-web/emacs-web-master" "${PsScriptRoot}/web"
    Remove-Item -Path "${PsScriptRoot}/emacs-web/"
}
