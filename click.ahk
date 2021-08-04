#NoEnv 
SendMode Input 
SetWorkingDir %A_ScriptDir% 

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
            WinMove, 2560, 0
            WinMove, 2560, 100
            WinClose, ahk_exe Teams.exe
        }
    }
}


