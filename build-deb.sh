#!/usr/bin/env bash
# Đóng gói ted thành .deb:   bash build-deb.sh
# Cần: dpkg-deb, python3. File `ted` phải nằm cùng thư mục với script này.
set -euo pipefail

PKG="ted-editor"        # tên gói; lệnh để chạy vẫn là `ted`
MAINTAINER="Ne0nGiT <250701900+Ne0nGiT@users.noreply.github.com>"   # <-- đổi thành email noreply của bạn (ID+tên@users.noreply.github.com)
HOMEPAGE="https://github.com/Ne0nGiT/ted"
HERE="$(cd "$(dirname "$0")" && pwd)"
VERSION="$(python3 - "$HERE/ted" <<'PY'
import re, sys
print(re.search(r'VERSION = "([^"]+)"', open(sys.argv[1], encoding="utf-8").read()).group(1))
PY
)"
ROOT="$(mktemp -d)"
trap 'rm -rf "$ROOT"' EXIT
D="$ROOT/${PKG}_${VERSION}_all"

mkdir -p "$D/DEBIAN" "$D/usr/bin" "$D/usr/share/applications" \
         "$D/usr/share/icons/hicolor/256x256/apps" \
         "$D/usr/share/icons/hicolor/scalable/apps" \
         "$D/usr/share/doc/$PKG"

# --- chương trình: /usr/bin/ted. Trong gói dùng /usr/bin/python3 thay vì `env python3`
#     để không bị nhầm sang Python khác (conda, pyenv...) không có tkinter.
sed '1s|^#!.*|#!/usr/bin/python3|' "$HERE/ted" > "$D/usr/bin/ted"
chmod 755 "$D/usr/bin/ted"
python3 -m py_compile "$D/usr/bin/ted"
rm -rf "$D/usr/bin/__pycache__"

# --- icon PNG 256x256 (chữ "t" trên nền tối) + SVG
python3 - "$D/usr/share/icons/hicolor/256x256/apps/ted.png" <<'PY'
import struct, sys, zlib
W = H = 256
bg, fg, edge = (40, 44, 52, 255), (97, 175, 239, 255), (0, 0, 0, 0)
rows = []
for y in range(H):
    row = bytearray([0])
    for x in range(W):
        inside = 16 <= x < 240 and 16 <= y < 240
        stem = 112 <= x < 144 and 64 <= y < 200
        bar = 80 <= x < 176 and 96 <= y < 124
        row += bytes(fg if (stem or bar) else (bg if inside else edge))
    rows.append(bytes(row))
def chunk(t, d):
    c = struct.pack(">I", len(d)) + t + d
    return c + struct.pack(">I", zlib.crc32(t + d) & 0xFFFFFFFF)
png = (b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", W, H, 8, 6, 0, 0, 0))
       + chunk(b"IDAT", zlib.compress(b"".join(rows), 9)) + chunk(b"IEND", b""))
open(sys.argv[1], "wb").write(png)
PY
cat > "$D/usr/share/icons/hicolor/scalable/apps/ted.svg" <<'EOF'
<svg xmlns="http://www.w3.org/2000/svg" width="256" height="256" viewBox="0 0 256 256">
  <rect x="16" y="16" width="224" height="224" rx="28" fill="#282c34"/>
  <rect x="112" y="64" width="32" height="136" fill="#61afef"/>
  <rect x="80" y="96" width="96" height="28" fill="#61afef"/>
</svg>
EOF

# --- mục trong menu ứng dụng và "Mở bằng..."
cat > "$D/usr/share/applications/ted.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=ted
GenericName=Text Editor
Comment=Lightweight text editor with modern keybindings and a built-in code runner
Comment[vi]=Trình soạn thảo văn bản nhẹ, keybind hiện đại, có chạy code (F5)
Exec=ted %f
Icon=ted
Terminal=false
Categories=Utility;TextEditor;Development;
Keywords=editor;text;nano;code;runner;
StartupWMClass=Ted
MimeType=text/plain;text/markdown;text/x-python;text/x-shellscript;application/x-shellscript;application/json;text/html;text/css;application/xml;text/xml;text/javascript;application/javascript;text/x-csrc;text/x-chdr;text/x-c++src;
EOF

# --- cảnh báo nếu còn bản cài tay trong /usr/local/bin (nó được ưu tiên hơn /usr/bin)
cat > "$D/DEBIAN/postinst" <<'EOF'
#!/bin/sh
set -e
if [ "$1" = "configure" ] && [ -e /usr/local/bin/ted ]; then
    echo "ted-editor: /usr/local/bin/ted (bản cài tay) sẽ che bản vừa cài. Gỡ nó bằng: sudo rm /usr/local/bin/ted" >&2
fi
exit 0
EOF
chmod 755 "$D/DEBIAN/postinst"

# --- thông tin gói
INSTALLED_KB="$(du -sk "$D/usr" | cut -f1)"
cat > "$D/DEBIAN/control" <<EOF
Package: $PKG
Version: $VERSION
Section: editors
Priority: optional
Architecture: all
Depends: python3 (>= 3.8), python3-tk
Recommends: zenity
Suggests: nodejs, gcc, g++, golang-go, default-jdk, php-cli, ruby
Installed-Size: $INSTALLED_KB
Maintainer: $MAINTAINER
Homepage: $HOMEPAGE
Description: Trình soạn thảo văn bản GUI nhẹ với keybind hiện đại
 ted mở bằng "ted <tên file>", dùng phím tắt quen thuộc (Ctrl+S, Ctrl+Z,
 Ctrl+F, Ctrl+/ ...) thay cho kiểu nano. Có tô màu cú pháp, tự đóng ngoặc,
 số dòng, tô các chữ trùng nhau, thụt lề thông minh, tìm và thay thế, nhớ vị
 trí con trỏ, và chạy file ngay trong editor bằng F5 (Python, JavaScript,
 Shell, C/C++, Go, Java, Rust, PHP, Ruby...). Viết bằng Python và tkinter nên
 khởi động nhanh, ít tốn RAM.
EOF

cat > "$D/usr/share/doc/$PKG/copyright" <<'EOF'
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ted
Source: https://github.com/Ne0nGiT/ted

Files: *
Copyright: 2026 Ne0nGiT
License: MIT
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 .
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 .
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
EOF

OUT="$HERE/${PKG}_${VERSION}_all.deb"
dpkg-deb --build --root-owner-group "$D" "$OUT" >/dev/null
echo "Đã tạo: $OUT"
