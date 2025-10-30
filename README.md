# AHK Window & Key Remapper

This AutoHotkey v2.0 script provides enhanced keyboard shortcuts for
window management, Vim-style navigation, and editing efficiency.\
It's designed for users who rely on keyboard-centric workflows and
prefer minimal mouse interaction.

------------------------------------------------------------------------

## 📋 Prerequisites

1.  Ensure the **bottom-left corner** of your keyboard layout looks like
    this:

        LAlt | LCtrl | RCtrl | Space

2.  Remap **Right Ctrl (RCtrl)** → **Left Win (LWin)** using your
    keyboard firmware or OS tool.

------------------------------------------------------------------------

## ⚙️ Features & Hotkeys

### 1. CapsLock Enhancements

-   **Double-tap CapsLock** → `Esc`\
-   **CapsLock + H/J/K/L** → Vim-style arrow navigation

  Combo      Action
  ---------- ---------
  Caps + H   ← Left
  Caps + J   ↓ Down
  Caps + K   ↑ Up
  Caps + L   → Right

*(CapsLock state is always forced off.)*

------------------------------------------------------------------------

### 2. Right Ctrl + Arrow Key Shortcuts

#### Navigation

  Combo           Action
  --------------- ---------------------------------
  RCtrl + Left    Home
  RCtrl + Right   End
  RCtrl + Up      Ctrl + Home (top of document)
  RCtrl + Down    Ctrl + End (bottom of document)

#### Selection

  Combo                   Action
  ----------------------- ------------------------------
  RCtrl + Shift + Left    Select to line start
  RCtrl + Shift + Right   Select to line end
  RCtrl + Shift + Up      Select to top of document
  RCtrl + Shift + Down    Select to bottom of document

#### Editing

  Combo               Action
  ------------------- -------------------------------------------
  RCtrl + Backspace   Delete all text to the left of the cursor

------------------------------------------------------------------------

### 3. Win + Arrow Key Shortcuts

  Combo             Action
  ----------------- -------------------------------------
  Win + Up / Down   Switch between virtual desktops
  Win + Right       Move window to the next monitor
  Win + Left        Move window to the previous monitor

------------------------------------------------------------------------

### 4. Window Management: Snap & Center

#### SnapCycle

Cycle window widths between **½**, **⅔**, and **⅓** of the monitor
width.

  Combo                   Action
  ----------------------- --------------------------
  RCtrl + LCtrl + Left    Snap left / cycle sizes
  RCtrl + LCtrl + Right   Snap right / cycle sizes

#### Center Window

  Combo               Action
  ------------------- ----------------------------------
  RCtrl + LCtrl + C   Center window on current monitor

#### Maximize / Restore

  Combo               Action
  ------------------- ----------------------------------
  RCtrl + LCtrl + F   Maximize / restore active window

------------------------------------------------------------------------

### 5. Alt Key Remaps (Productivity)

  Combo     Action
  --------- --------------------
  Alt + C   Ctrl + C (Copy)
  Alt + D   Ctrl + D
  Alt + R   Ctrl + R (Refresh)
  Alt + O   Ctrl + O (Open)

------------------------------------------------------------------------

## 🧠 How SnapCycle Works

1.  Detects the active window and monitor.\
2.  Determines the current snap width (½, ⅔, or ⅓).\
3.  Cycles through these widths on the **left** or **right** side.\
4.  If switching sides, keeps the same width.

------------------------------------------------------------------------

## 🧩 Configuration

``` ahk
tol := 0  ; pixel tolerance for edge detection
```

Increase `tol` for high-DPI monitors if snapping is inconsistent.

------------------------------------------------------------------------

## 🖥 Helper Functions

-   **`GetMonitorIndexFromPoint(x, y)`** → Returns the monitor index for
    a given point.\
-   **`CenterWindow()`** → Centers the active window on its current
    monitor.

------------------------------------------------------------------------

## 🧱 Requirements

-   [AutoHotkey v2.0+](https://www.autohotkey.com/)\
-   Windows OS with multiple monitor support (for SnapCycle).

------------------------------------------------------------------------

## 🚀 Installation

1.  Install **AutoHotkey v2.0+**.\
2.  Save this script as `key_remapper.ahk`.\
3.  Double-click to run it.\
4.  (Optional) Add a shortcut to your Startup folder to launch
    automatically on boot.

------------------------------------------------------------------------

## 📄 License

This script is provided under the **MIT License**.\
Feel free to modify and share.

------------------------------------------------------------------------

## ✨ Author Notes

Made for efficiency enthusiasts and Vim users who love precise keyboard
control.
