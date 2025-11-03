#Requires AutoHotkey v2.0

; prerequesite:
; 1. the left bottom corner should look like this:
; LAlt | LCtrl | RCtrl | Space
; 2. switch RCtl to LWin

CapsLock:: {
    static presses := 0, squelch := 300
    presses += 1
    if (presses = 1) {
        SetTimer(done, -squelch) ; start single-shot timeout
    } else {                    ; second press: act immediately
        SetTimer(done, 0)   ; cancel pending timer
        presses := 0
        Send("{Esc}")
    }

    done() { ; timer expired without a 2nd press
        presses := 0
    }
}

; capsLock + HJKL
SetCapsLockState "AlwaysOff"
#HotIf GetKeyState("CapsLock", "P")
h::Left
j::Down
k::Up
l::Right
#HotIf

; --- Right Ctrl + Arrow remaps ---
>^Left:: send "{Home}"
>^Right:: send "{End}"
>^Up:: Send("^{Home}")        ; Top of document
>^Down:: Send("^{End}")       ; Bottom of document

; select them
>^+Left:: send "+{Home}"
>^+Right:: send "+{End}"
>^+Up:: Send("^+{Home}")
>^+Down:: Send("^+{End}")

; Right Ctrl + backspace to delete whole word to the left
>^BackSpace::
{
    send "+{Home}"
    send "{BackSpace}"
}

>^Tab::!Tab

#up:: Send("#{Tab}")
#down:: Send("#{Tab}")
#right:: Send("#^{Right}")
#left:: Send("#^{Left}")

; ---- Settings ----
tol := 0  ; pixel tolerance for detecting sizes/edges

; ---- Hotkeys ----
>^<^Left:: SnapCycle("left")
>^<^Right:: SnapCycle("right")
>^<^c:: CenterWindow()
>^<^f::#Up
<^+x::!+x

; remap Alt + c/d/r/o to Ctrl + c/d/r/o
!c::^c
!d::^d
!r::^r
!o::^o

!Space::!Shift

SnapCycle(direction := "left") {
    global tol
    win := WinExist("A")
    if !win
        return

    ; Restore if maximized/minimized
    mm := WinGetMinMax("ahk_id " win)  ; -1=minimized, 0=normal, 1=maximized
    if (mm != 0)
        WinRestore("ahk_id " win)

    ; Current window rect
    WinGetPos(&wx, &wy, &ww, &wh, "ahk_id " win)

    ; --- Find the monitor that contains the window center ---
    cx := wx + ww / 2, cy := wy + wh / 2
    mon := GetMonitorIndexFromPoint(cx, cy)
    MonitorGetWorkArea(mon, &ml, &mt, &mr, &mb)
    msw := mr - ml, msh := mb - mt

    ; --- Define width stages relative to this monitor ---
    widths := [msw / 2, (msw * 2) / 3, msw / 3]  ; 1/2, 2/3, 1/3

    ; --- Figure out current width stage (0 = none matched) ---
    idx := 0
    for i, val in widths {
        if Abs(ww - val) <= tol {
            idx := i
            break
        }
    }

    ; --- Figure out current side (left/right) on this monitor ---
    ; Prefer exact edge checks, fall back to center comparison.
    currentSide := ""
    if Abs(wx - ml) <= tol
        currentSide := "left"
    else if Abs((wx + ww) - mr) <= tol
        currentSide := "right"
    else
        currentSide := (cx <= (ml + mr) / 2) ? "left" : "right"

    ; --- Decide target width index ---
    ; If width already matches a stage and we're only switching sides, keep same width.
    ; Otherwise, cycle to the next width.
    if (idx >= 1 && currentSide != direction) {
        nextIdx := idx
    } else {
        ; Cycle: 1/2 -> 2/3 -> 1/3 -> 1/2
        nextIdx := (idx = 0 || idx = 3) ? 1 : (idx + 1)
    }

    newW := widths[nextIdx]
    newH := msh
    newX := (direction = "left") ? ml : (mr - newW)
    newY := mt

    ; Move/resize
    WinMove(newX, newY, newW, newH, "ahk_id " win)
}

CenterWindow() {
    win := WinExist("A")
    if !win
        return
    mm := WinGetMinMax("ahk_id " win)
    if (mm != 0)
        WinRestore("ahk_id " win)

    WinGetPos(&wx, &wy, &ww, &wh, "ahk_id " win)

    cx := wx + ww / 2, cy := wy + wh / 2
    mon := GetMonitorIndexFromPoint(cx, cy)
    MonitorGetWorkArea(mon, &ml, &mt, &mr, &mb)
    msw := mr - ml, msh := mb - mt

    newX := ml + (msw - ww) / 2
    newY := mt + (msh - wh) / 2
    WinMove(newX, newY, ww, wh, "ahk_id " win)
}

; ---- Helpers ----
GetMonitorIndexFromPoint(x, y) {
    ; Returns the 1-based monitor index containing (x, y),
    ; or the nearest monitor if the point is off-screen.
    count := MonitorGetCount()
    nearest := 1
    nearestDist := 1e9

    loop count {
        i := A_Index
        MonitorGetWorkArea(i, &l, &t, &r, &b)
        if (x >= l && x <= r && y >= t && y <= b)
            return i  ; inside this monitor
        ; Track nearest by squared distance to the workarea center
        cx := (l + r) / 2, cy := (t + b) / 2
        d := (x - cx) ** 2 + (y - cy) ** 2
        if (d < nearestDist) {
            nearestDist := d
            nearest := i
        }
    }
    return nearest
}
