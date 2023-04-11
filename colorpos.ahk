#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to itsrrr superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

~q::
    loop {
        WinGetActiveTitle, winid
        MouseGetPos, XX, YY
        PixelGetColor, Pix, %XX%, %YY%, RGB
        
        ToolTip, X: %XX%`nY: %YY%`nC: %Pix%`nW: %winid%
    }
return

Esc::
    ExitApp
    