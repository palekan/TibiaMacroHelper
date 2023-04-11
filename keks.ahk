;--------------------------------DIRECTIVES/IMPORTS-----------------------------------
#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance, Force
#Include lib/gdip.ahk
#Include lib/Gdip_ImageSearch.ahk
#MaxThreadsPerHotkey 2
DetectHiddenWindows, on
SendMode Input
SetBatchLines -1
OnExit("CloseGdip")
CoordMode, pixel, screen
CoordMode, mouse, screen

;--------------------------------SETUP/INITIALIZATION---------------------------------
IniRead, iconsMain, config.ini, settings, iconsMain
if (iconsMain = "true")
    Menu, Tray, Icon, images/main.ico
else
    Menu, Tray, NoIcon
    
IniRead, window, config.ini, windowName, name
IniRead, sound, config.ini, settings, sound
IniRead, icons, config.ini, settings, icons

IniRead, delay, config.ini, settings, launchDelay
IniRead, minSleep, config.ini, settings, minSleep
IniRead, maxSleep, config.ini, settings, maxSleep
IniRead, aFailCh, config.ini, settings, aFailCh
IniRead, rFailCh, config.ini, settings, rFailCh
IniRead, aSleep, config.ini, settings, aSleep
IniRead, rSleep, config.ini, settings, rSleep
IniRead, parSleep, config.ini, settings, parSleep
IniRead, hSleep, config.ini, settings, hSleep
IniRead, uSleep, config.ini, settings, uSleep

loop, 7 {
    IniRead, hot%A_Index%, config.ini, hotkeys, hot%A_Index%
}

loop, 5 {
    IniRead, hotToRun%A_Index%, config.ini, hotkeysToRunScripts, hotToRun%A_Index%
}



IniRead, pos1X, config.ini, positions, pos1X
IniRead, pos1Y, config.ini, positions, pos1Y
IniRead, col1, config.ini, positions, col1

IniRead, pos2X, config.ini, positions, pos2X
IniRead, pos2Y, config.ini, positions, pos2Y
IniRead, col2, config.ini, positions, col2

IniRead, pos3X, config.ini, positions, pos3X
IniRead, pos3Y, config.ini, positions, pos3Y
IniRead, col3, config.ini, positions, col3

IniRead, pos4X, config.ini, positions, pos4X
IniRead, pos4Y, config.ini, positions, pos4Y
IniRead, redColLight, config.ini, positions, redColLight
IniRead, redColMid, config.ini, positions, redColMid
IniRead, redColDeep, config.ini, positions, redColDeep
IniRead, yellowCol, config.ini, positions, yellowCol

IniRead, pos5X, config.ini, positions, pos5X
IniRead, pos5Y, config.ini, positions, pos5Y
IniRead, col5, config.ini, positions, col5

IniRead, pos6X, config.ini, positions, pos6X
IniRead, pos6Y, config.ini, positions, pos6Y
IniRead, utCol, config.ini, positions, utCol

IniRead, pos7X, config.ini, positions, pos7X
IniRead, pos7Y, config.ini, positions, pos7Y
IniRead, col7, config.ini, positions, col7

IniRead, pos8X, config.ini, positions, pos8X
IniRead, pos8Y, config.ini, positions, pos8Y
IniRead, mCol, config.ini, positions, mCol

global kekS := False
global kekM := False
global kekU := False
global kekH := False
global kekAP := False
global cd := 0
global delay := delay
global sound := sound
global icons := icons
global loopTimes := 1
pToken := Gdip_Startup()
parIco := Gdip_createBitmapFromFile("images/p.png")

WinGet, WinID, ID, %window%

;---------------------------------------MAIN-------------------------------------
loop {

    Hotkey, %hotToRun1%, label1
    Hotkey, %hotToRun2%, label2
    Hotkey, %hotToRun3%, label3
    Hotkey, %hotToRun4%, label4
    Hotkey, %hotToRun5%, label5
    
    pBitmap := Gdip_BitmapFromHWND(WinID)
    
    ;-----------S-----------
    if (kekS) {
        pixel1 := Gdip_GetPixel(pBitmap, pos1X, pos1Y)
        hex1 := DEC2HEX(pixel1, "true")
        
        
        ;if (hex1 != col1) {
        if (hex1 = 0x525557) {
            Sleep %aSleep%
            Random, rnd, 1, 100
            
            if (rnd <= aFailCh)
                loopTimes := 2
            else
                loopTimes := 1

            loop, %loopTimes% {
                Random, rndSleep1, %minSleep%, %maxSleep%
                Send {%hot1% down}
                Sleep %rndSleep1%
                Send {%hot1% up}
            }
            RandomSleep(100, 200)
        }
        
    }
    
    ;-----------M-----------
    if (kekM) {
        pixel2 := Gdip_GetPixel(pBitmap, pos2X, pos2Y)
        hex2 := DEC2HEX(pixel2, "true")
        
        if (hex2 != col2) {
            Sleep %rSleep%
            Random, rnd2, 1, 100
            
            if (rnd2 <= rFailCh)
                loopTimes := 2
            else
                loopTimes := 1

            loop, %loopTimes% {
                Random, rndSleep2, %minSleep%, %maxSleep%
                Send {%hot2% down}
                Sleep %rndSleep2%
                Send {%hot2% up}
            }
            RandomSleep(100, 200)
        }
        
    }
    
    ;-----------AP-----------
    if (kekAP) {
        err := Gdip_imageSearch(pBitmap, parIco, xy, 0, 0, 0, 0, 0, trans, dir)
        pixel3 := Gdip_GetPixel(pBitmap, pos3X, pos3Y)
        hex3 := DEC2HEX(pixel3, "true")
        
        if (xy > 0) {
            Sleep %parSleep%
            Random, rndSleep3, %minSleep%, %maxSleep%
            
            if (hex3 = col3) {
                Send {%hot5% down}
                Sleep %rndSleep3%
                Send {%hot5% up}
            } else {
                Send {%hot6% down}
                Sleep %rndSleep3%
                Send {%hot6% up}
            }
            RandomSleep(100, 200)
        }
        
    }
    
    ;-----------H-----------
    if (kekH) {
        pixel4 := Gdip_GetPixel(pBitmap, pos4X, pos4Y)
        hex4 := DEC2HEX(pixel4, "true")
        
        
        if (hex4 = yellowCol) {
            Send {%hot6% down}
            Sleep %rndSleep4%
            Send {%hot6% up}
        }
        else if (hex4 = redColLight || hex4 = redColMid || hex4 = redColDeep) {
            pixel41 := Gdip_GetPixel(pBitmap, pos5X, pos5Y)
            hex41 := DEC2HEX(pixel41, "true")
            Random, rndSleep4, %minSleep%, %maxSleep%
            Sleep %hSleep%
            
            
            if (hex41 = col5) {
                Send {%hot7% down}
                Sleep %rndSleep4%
                Send {%hot7% up}
            } else {
                Send {%hot6% down}
                Sleep %rndSleep4%
                Send {%hot6% up}
            }
        }
    }
    
    ;-----------U-----------
    if (kekU) {
        pixel5 := Gdip_GetPixel(pBitmap, pos6X, pos6Y)
        hex5 := DEC2HEX(pixel5, "true")

        pixel51 := Gdip_GetPixel(pBitmap, pos8X, pos8Y)
        hex51 := DEC2HEX(pixel51, "true")

        Sleep %uSleep%
        
        if (hex5 != utCol && hex51 = mCol) {
            pixel52 := Gdip_GetPixel(pBitmap, pos7X, pos7Y)
            hex52 := DEC2HEX(pixel52, "true")
            Random, rndSleep5, %minSleep%, %maxSleep%
            
            if (hex52 != col7) {
                Send {%hot3% down}
                Sleep %rndSleep5%
                Send {%hot3% up}
                Sleep 300
            } else {
                Send {%hot4% down}
                Sleep %rndSleep5%
                Send {%hot4% up}
                Sleep 300
            }
        }
    }
    
    
    Gdip_DisposeImage(pBitmap)
}
return

;-------------------------------------LABELS FOR HOTKEYS-------------------------
label1:
    checkDelayAndRun("kekS", "S")
Return

label2:
    checkDelayAndRun("kekM", "M")
Return

label3:
    checkDelayAndRun("kekAP", "AP")
Return

label4:
    checkDelayAndRun("kekH", "H")
Return

label5:
    checkDelayAndRun("kekU", "U")
Return

;-------------------------------------FUNCTIONS--------------------------------
DEC2HEX(DEC, RARGB="false")
{
    SetFormat, IntegerFast, hex
    RGB += DEC
    if(RARGB=="true") {
        RGB := RGB & 0x00ffffff
    }
    return RGB
}

RandomSleep(min, max)
{
    Random, random, %min%, %max%
    Sleep %random%
}

CloseGdip()
{
    Gdip_DisposeImage(pBitmap)
    Gdip_DisposeImage(parIco)
    Gdip_Shutdown(pToken)
}

checkDelayAndRun(nameVar, nameFile)
{
    if (A_TickCount >= cd) {
        cd := (A_TickCount + delay)
        %nameVar% := !%nameVar%
        if (%nameVar%) {
            if (icons = "true")
                Run, iconsVisual\%nameFile%.ahk
            if (sound = "true")
                SoundBeep, 2000, 200
        } else {
            SetTitleMatchMode, 2
            if (icons = "true")
                WinKill, %nameFile%.ahk
            if (sound = "true")
                SoundBeep, 1000, 200
        }
    }
}