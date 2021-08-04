#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#MaxThreadsPerHotkey, 5
^NumpadSub::
if KeepRunning
{
    KeepRunning := false
    return
}
KeepRunning := true
TActive := new TeamsActive
TActive.Start()
While, KeepRunning
{
    sleep, 1000
}
TActive.Stop()
KeepRunning := false 


class TeamsActive {
    __New() {
        this.interval := 60000
        this.timer := ObjBindMethod(this, "Runner")
    }
    Start() {
        timer := this.timer
        SetTimer % timer, % this.interval
        ToolTip % "App started"
        Sleep, 2000
        Tooltip
    }
    Stop() {
        timer := this.timer
        SetTimer % timer, Off
        ToolTip % "App stopped"
        Sleep, 2000
        Tooltip
    }
    Runner() {
        if ! WinActive("ahk_exe Teams.exe")
        {
            WinActivate, ahk_exe Teams.exe 
            WinWaitActive, ahk_exe Teams.exe
            WinMove, 2560, 1070
            WinMove, 2560, 1080
            WinClose, ahk_exe Teams.exe
        }
    }
}


