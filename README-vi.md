# ted

Trình soạn thảo văn bản GUI **nhẹ** cho Linux, mở bằng `ted <tên file>`, dùng phím tắt hiện đại (Ctrl+S, Ctrl+Z, Ctrl+F...) thay cho kiểu nano.

*A tiny GUI text editor for Linux with modern keybindings. One Python file, tkinter only.*

- Một file Python duy nhất, chỉ cần `python3` và `tkinter`
- Khởi động nhanh, ít tốn RAM, mở file lớn vẫn mượt
- Gõ tiếng Việt có dấu bình thường, lưu UTF-8

## Cài đặt

```bash
sudo apt install python3-tk zenity   # zenity là tùy chọn: hộp thoại mở/lưu file kiểu GTK
git clone https://github.com/Ne0nGiT/ted.git
cd ted
sudo install -m 755 ted /usr/local/bin/ted
```

Chạy thử mà không cần cài: `python3 ted ghichu.txt`

Dùng: `ted <tên file>`. File chưa có thì mở trống và được tạo khi lưu (Ctrl+S).

## Phím tắt

| Phím | Chức năng |
|---|---|
| Ctrl+S / Ctrl+Shift+S | Lưu / Lưu thành |
| Ctrl+O | Mở file |
| Ctrl+Q hoặc Ctrl+W | Thoát (hỏi nếu chưa lưu) |
| Ctrl+Z / Ctrl+Y (hoặc Ctrl+Shift+Z) | Undo / Redo |
| Ctrl+A | Chọn tất cả |
| Ctrl+F | Tìm (Enter xuống, Shift+Enter lên, Esc đóng) |
| Ctrl+H | Tìm và thay thế |
| F3 / Shift+F3 | Kết quả tìm tiếp / trước |
| Ctrl+G | Đến dòng |
| Ctrl+D | Nhân đôi dòng |
| Ctrl+Backspace / Ctrl+Delete | Xóa nguyên từ bên trái / phải |
| Ctrl+/ | Bật tắt comment (dòng hoặc khối đang chọn) |
| Tab / Shift+Tab | Thụt / lùi lề (cả khối nếu chọn nhiều dòng) |
| Alt+Z | Bật tắt xuống dòng tự động |
| Ctrl+= / Ctrl+- / Ctrl+0 hoặc Ctrl+cuộn chuột | Phóng to / thu nhỏ / mặc định |

## Tính năng

- **Tô màu cú pháp:** Python, JavaScript/TypeScript, JSON, HTML/XML, CSS, Markdown, Shell, họ C (C/C++/Java/Go/Rust/C#/PHP...), file config (yaml/toml/ini). Nhận theo đuôi file hoặc dòng `#!`.
- **File code:** tự đóng ngoặc và nháy, bọc phần đang chọn, Enter giữa `{}` mở thành 3 dòng, thụt lề tự động.
- Luôn có ký tự xuống dòng ở cuối file khi lưu (như nano), nên `cat` và `git diff` không báo thiếu newline.
- Nhớ vị trí con trỏ của lần mở trước (lưu ở `~/.cache/ted/positions.json`).
- Theme tối.

## Hạn chế

- Chỉ mở một file mỗi cửa sổ, không có tab, không có số dòng.
- Tô màu cú pháp dùng regex nên đơn giản hơn các editor lớn. Với file trên 4000 dòng, chuỗi hoặc comment nhiều dòng bắt đầu ngoài vùng đang xem có thể tô chưa chính xác.
- Chưa tự đoán encoding ngoài UTF-8 (có fallback latin-1 khi đọc file).

## Giấy phép

MIT, xem file [LICENSE](LICENSE).
