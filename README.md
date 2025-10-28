# 🧠 AHK Productivity Profile

A modern, developer-oriented AutoHotkey (AHK v2) profile designed to enhance text editing, navigation, and window management efficiency on Windows.

---

## ⚙️ Requirements

### System prerequisites

1. **Keyboard layout**:
   Must have the left bottom row as:
   `LWin | LCtrl | LAlt | Space`

2. **Remap Right Ctrl → Left Win**
   You can do this using PowerToys, SharpKeys, or keyboard firmware.

3. **Install AutoHotkey v2.0+**
   [https://www.autohotkey.com/](https://www.autohotkey.com/)

4. Save this script as `productivity.ahk` and set it to run at startup.

---

## 🧠 Key Concepts

### CapsLock Behavior
| Action | Result |
|--------|---------|
| Tap **CapsLock** twice quickly | Sends `Esc` |
| Hold **CapsLock** | Enables `HJKL` arrow navigation |
| `Caps + H/J/K/L` | Moves Left/Down/Up/Right (Vim-style) |

CapsLock state remains **off** — it functions purely as a **modal modifier**.

---

### Alt Key as "Smart Ctrl"

All **Alt+<key>** combos behave as **Ctrl+<key>**, so your left hand can stay in the home position.

| Example | Action |
|----------|---------|
| `Alt + C` | Copy (`Ctrl+C`) |
| `Alt + V` | Paste (`Ctrl+V`) |
| `Alt + Z` | Undo (`Ctrl+Z`) |
| `Alt + /` | Comment (`Ctrl+/`) |
| `Alt + Enter` | `Ctrl+Enter` |
| `Alt + Shift + Enter` | `Ctrl+Shift+Enter` |

#### Arrows
| Combo | Action |
|--------|--------|
| `Alt + ← / →` | Home / End |
| `Alt + ↑ / ↓` | Top / Bottom of document |
| `Alt + Shift + (Arrow)` | Same with selection |
| `Alt + Backspace` | Delete previous word (`Ctrl+Backspace`) |

---

### Win-Key Shortcuts → Ctrl Equivalents

| Combo | Action |
|--------|--------|
| `Win + D` | `Ctrl+D` |
| `Win + R` | `Ctrl+R` |
| `Win + O` | `Ctrl+O` |
| `Win + ← / →` | Move window between desktops |
| `Win + ↑ / ↓` | Cycle virtual desktops |

*(Note: Some Win-key combos may be reserved by Windows.)*

---

## 🪟 Window Management

Smart window snapping with width cycling and monitor awareness.

| Combo | Action |
|--------|--------|
| `Alt + Ctrl + ← / →` | Snap left/right, cycle widths (½ → ⅔ → ⅓) |
| `Alt + Ctrl + C` | Center active window |
| `Alt + Ctrl + F` | Maximize window to work area |

**Cycle logic:**
Each press cycles through width ratios — ½, ⅔, ⅓ — and switches sides if you press the opposite direction.

---

### Mouse Enhancements

| Combo | Action |
|--------|--------|
| `Alt + LClick` | Performs a `Ctrl + LClick` |
| `Alt + Shift + X` | Sends `PrintScreen` |

---

## 🧩 Implementation Details

### Functions
- **SnapCycle(direction)**: Smart snapping with monitor detection and width cycling
- **CenterWindow()**: Centers active window on its current monitor
- **FullWindow()**: Expands active window to monitor’s work area
- **GetMonitorIndexFromPoint(x, y)**: Identifies which monitor contains a given point

### Tunable Parameters
- `tol := 12` — Pixel tolerance for detecting window size and position edges

### Notes
- The Alt→Ctrl mapping is dynamically generated with loops to avoid 50+ redundant hotkeys.
- Window snapping uses `MonitorGetWorkArea()` to respect taskbars and reserved areas.
- The script restores windows before moving if minimized/maximized (`WinRestore`).

---

## 🧾 Summary

| Shortcut | Function |
|-----------|-----------|
| CapsLock double-tap | Escape |
| CapsLock + H/J/K/L | Arrow keys |
| Alt + Letter | Ctrl + Letter |
| Alt + Arrows | Jump in text |
| Alt + Ctrl + Arrows | Snap windows |
| Alt + Ctrl + C/F | Center / Full window |
| Alt + LClick | Ctrl + LClick |
| Alt + Shift + X | Screenshot |

---

## 🧠 Dev Notes

- Written for **AutoHotkey v2 syntax** — incompatible with v1.
- Designed for **power users and developers** who prefer minimal movement from the home row.
- Tested on **Windows 11**, multi-monitor setups, and high-DPI environments.

---

## 🧾 License

MIT License © 2025
Feel free to fork, modify, and redistribute with credit.
