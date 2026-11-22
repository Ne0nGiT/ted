# ted

Đọc [README tiếng Anh](README.md)

Trình soạn thảo văn bản GUI **nhẹ** cho Linux, mở bằng `ted <tên file>`, dùng các phím tắt hiện đại (Ctrl+S, Ctrl+Z, Ctrl+F...) thay cho giao diện kiểu nano.

*Trình soạn thảo GUI nhỏ gọn cho Linux, dùng các phím tắt hiện đại. Chỉ một file Python, chỉ cần tkinter.*

- Chỉ gồm một file Python; chỉ cần `python3` và `tkinter`
- Khởi động nhanh, ít tốn RAM và vẫn mượt khi mở file lớn
- Hỗ trợ gõ tiếng Việt có dấu bình thường và lưu file bằng UTF-8

## Cài đặt

```bash
sudo apt install git python3-tk zenity   # zenity không bắt buộc: dùng hộp thoại mở/lưu file kiểu GTK
git clone https://github.com/Ne0nGiT/ted.git
cd ted
sudo install -m 755 ted /usr/local/bin/ted
cd ..
```

Nếu muốn dùng thử mà không cài chương trình vào PATH, chỉ cần tải file `ted` rồi chạy:
`python3 ted ghichu.txt`

Cách dùng: `ted <tên file>`. Nếu file chưa tồn tại, chương trình mở một tài liệu trống và tạo file khi bạn lưu (Ctrl+S).

<img width="906" height="627" alt="Ảnh giao diện trình soạn thảo ted" src="https://github.com/user-attachments/assets/7b248ac1-396b-4068-9f25-db0ade90373d" />

## Phím tắt

| Phím | Chức năng |
|---|---|
| Ctrl+S / Ctrl+Shift+S | Lưu / Lưu thành |
| Ctrl+O | Mở file |
| Ctrl+Q hoặc Ctrl+W | Thoát (hỏi nếu còn thay đổi chưa lưu) |
| Ctrl+Z / Ctrl+Y (hoặc Ctrl+Shift+Z) | Hoàn tác / Làm lại |
| Ctrl+A | Chọn tất cả |
| Ctrl+F | Tìm (Enter để tìm tiếp, Shift+Enter để tìm ngược, Esc để đóng) |
| Ctrl+H | Tìm và thay thế |
| F3 / Shift+F3 | Tìm kết quả tiếp theo / trước đó |
| Ctrl+G | Đến dòng |
| Ctrl+D | Nhân đôi dòng |
| Ctrl+Backspace / Ctrl+Delete | Xóa từ bên trái / bên phải |
| Ctrl+/ | Bật/tắt chú thích (dòng hiện tại hoặc khối đang chọn) |
| Tab / Shift+Tab | Thụt lề / lùi lề (áp dụng cho cả khối nếu chọn nhiều dòng) |
| Alt+Z | Bật/tắt tự động xuống dòng |
| Ctrl+= / Ctrl+- / Ctrl+0 hoặc Ctrl+cuộn chuột | Phóng to / thu nhỏ / đặt lại cỡ chữ |

## Tính năng

- **Tô sáng cú pháp:** Python, JavaScript/TypeScript, JSON, HTML/XML, CSS, Markdown, Shell, các ngôn ngữ họ C (C/C++/Java/Go/Rust/C#/PHP...) và file cấu hình (yaml/toml/ini). Nhận diện theo phần mở rộng file hoặc dòng `#!`.
<img width="906" height="627" alt="Ảnh tô sáng cú pháp trong ted" src="https://github.com/user-attachments/assets/5cbf92fc-4957-4cff-b8af-7533418b2d45" />

- **Khi soạn mã:** tự đóng ngoặc và dấu nháy, bọc phần văn bản được chọn, nhấn Enter bên trong `{}` sẽ tạo thành ba dòng và tự động thụt lề.
- Luôn thêm ký tự xuống dòng ở cuối file khi lưu (như nano), để `cat` và `git diff` không báo thiếu ký tự xuống dòng.
- Ghi nhớ vị trí con trỏ từ phiên trước (lưu tại `~/.cache/ted/positions.json`).
- Giao diện tối.

## Hạn chế

- Mỗi cửa sổ chỉ mở được một file; không có tab hoặc số dòng.
- Tô sáng cú pháp dùng biểu thức chính quy nên đơn giản hơn các trình soạn thảo lớn. Với file trên 4.000 dòng, chuỗi hoặc chú thích nhiều dòng bắt đầu ngoài vùng đang hiển thị có thể không được tô sáng chính xác.
- Không tự nhận diện các bảng mã ngoài UTF-8 (dùng latin-1 dự phòng khi đọc file).

## Giấy phép

MIT; xem [LICENSE](LICENSE).
