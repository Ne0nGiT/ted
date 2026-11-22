# ted
For **Vietnamese** version, check [README-vi.md](README-vi.md)

A **lightweight** GUI text editor for Linux, opened with `ted <filename>`, with modern shortcuts (Ctrl+S, Ctrl+Z, Ctrl+F...) instead of a nano-style interface.

*A tiny GUI text editor for Linux with modern keybindings. One Python file, tkinter only.*

- A single Python file; requires only `python3` and `tkinter`
- Starts quickly, uses little RAM, and stays smooth even with large files
- Handles Vietnamese typing with diacritics normally and saves as UTF-8

## Installation

### Option 1: `.deb` package (recommended)

Download the `.deb` from the [Releases](https://github.com/Ne0nGiT/ted/releases) page and install it:

```bash
wget https://github.com/Ne0nGiT/ted/releases/download/v1.3.0/ted-editor_1.3.0_all.deb
sudo apt install ./ted-editor_1.3.0_all.deb
```

`apt` installs the dependencies (`python3-tk`) for you, and **ted** shows up in your application menu and in the "Open With" list for text and code files. (A note like "Download is performed unsandboxed as root" is harmless.)

### Option 2: from source

```bash
sudo apt install git python3-tk zenity   # zenity is optional: GTK-style file open/save dialogs
git clone https://github.com/Ne0nGiT/ted.git
cd ted
sudo install -m 755 ted /usr/local/bin/ted
cd ..
```

To try it without installing, just download the `ted` file and run:
`python3 ted notes.txt`

## Usage

`ted <filename>`. If the file doesn't exist, it opens as a blank document and is created when you save (Ctrl+S).

When started from a terminal, ted detaches from it, so you can keep using that terminal (and closing the terminal won't close ted). Use `ted -f <filename>` to keep it attached. Output and errors of a detached ted are written to `~/.cache/ted/ted.log`.

<img width="906" height="627" alt="image" src="https://github.com/user-attachments/assets/7b248ac1-396b-4068-9f25-db0ade90373d" />


## Keyboard shortcuts

| Key | Action |
|---|---|
| Ctrl+S / Ctrl+Shift+S | Save / Save As |
| Ctrl+O | Open file |
| Ctrl+Q or Ctrl+W | Quit (asks if there are unsaved changes) |
| Ctrl+Z / Ctrl+Y (or Ctrl+Shift+Z) | Undo / Redo |
| Ctrl+A | Select all |
| Ctrl+F | Find (Enter for next, Shift+Enter for previous, Esc to close) |
| Ctrl+H | Find and replace |
| F3 / Shift+F3 | Find next / previous |
| Ctrl+G | Go to line |
| Ctrl+D | Duplicate line |
| Ctrl+Backspace / Ctrl+Delete | Delete the word to the left / right |
| Ctrl+/ | Toggle comment (on the current line or selected block) |
| Tab / Shift+Tab | Indent / outdent (the whole block when multiple lines are selected) |
| Alt+Z | Toggle word wrap |
| Ctrl+= / Ctrl+- / Ctrl+0 or Ctrl+mouse wheel | Zoom in / out / reset |
| Ctrl+L | Toggle line numbers |
| Alt+H | Toggle highlighting of matching words |
| F5 | Run the current file (code runner) |
| Shift+F5 | Stop the running program |
| Ctrl+J | Show / hide the output panel |

## Features

- **Syntax highlighting:** Python, JavaScript/TypeScript, JSON, HTML/XML, CSS, Markdown, Shell, C-family languages (C/C++/Java/Go/Rust/C#/PHP...), and config files (yaml/toml/ini). Detected by file extension or `#!` line.
<img width="906" height="627" alt="image" src="https://github.com/user-attachments/assets/5cbf92fc-4957-4cff-b8af-7533418b2d45" />

- **For code files:** automatically closes brackets and quotes, wraps selected text, expands Enter inside `{}` into three lines, and auto-indents.
- **Code runner (F5):** runs the current file and shows the output in a panel at the bottom of the window. Supports Python, JavaScript (node), Shell, PHP, Ruby, Perl, Lua, Go, Java, C, C++, Rust, and HTML (opens in your browser); files without an extension use their `#!` line. The matching interpreter or compiler must be installed (ted tells you which `apt` package is missing). The stdin box under the output lets you type input for programs that read from the keyboard (Ctrl+D sends end-of-input).
- **Line numbers** (Ctrl+L to toggle); click a number to select that line.
- **Matching words:** in code files, other occurrences of the word under the cursor (or of the selected text) are highlighted, which helps when renaming variables. Alt+H toggles it.
- Always adds a trailing newline when saving (like nano), so `cat` and `git diff` won't report a missing newline.
- Remembers the cursor position from the previous session (stored in `~/.cache/ted/positions.json`).
- Dark theme.

## Limitations

- Only one file per window; no tabs.
- Syntax highlighting uses regular expressions, so it is simpler than that of larger editors. In files over 4,000 lines, strings or multiline comments that begin outside the visible area may not be highlighted accurately.
- Does not automatically detect encodings other than UTF-8 (falls back to latin-1 when reading a file).

## License

MIT; see [LICENSE](LICENSE).
