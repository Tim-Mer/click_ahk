#NoEnv 
SendMode Input 
SetWorkingDir %A_ScriptDir% 

#MaxThreadsPerHotkey, 5
^NumpadSub::
if KeepRunning 
{ ; In here stops the App
    KeepRunning := false
    return
}
KeepRunning := true

TActive := new TeamsActive
TActive.Start() ; Calls the start function

While, KeepRunning
{ ; Checks for stop call every 1 second
    sleep, 1000
}

TActive.Stop() ; Calls the stop function

KeepRunning := false ; Reset for next time

^+NumpadSub::
Reload ; Used to reload the script if an error occurs and when you do an edit
Sleep 1000
return

class TeamsActive {
    __New() {
        this.interval := 60000 ; Runs every 1 minute
        this.timer := ObjBindMethod(this, "Runner") ; Attaches the Runner to the timer
    }
    Start() {
        timer := this.timer
        SetTimer % timer, % this.interval ; Starts the timer
        ToolTip % "App started"
        Sleep, 2000
        Tooltip
    }
    Stop() {
        timer := this.timer
        SetTimer % timer, Off ; Stops the timer
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


