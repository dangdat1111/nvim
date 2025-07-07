# Cấu hình Neovim của tôi (`init.lua`)

Chào mừng bạn đến với kho lưu trữ cấu hình Neovim của tôi. Tệp `init.lua` này được thiết kế để tạo ra một môi trường lập trình hiện đại, hiệu quả và đẹp mắt.

## ✨ Tính năng nổi bật

- **Tổ chức thông minh**: Sử dụng `augroup` để quản lý các lệnh tự động, tránh xung đột và trùng lặp khi tải lại cấu hình.
- **Tăng cường hiệu suất**:
  - Tự động làm nổi bật văn bản vừa được "yank" (sao chép) để xác nhận trực quan.
  - Tự động dọn dẹp các khoảng trắng thừa ở cuối dòng trước khi lưu tệp.
- **Giao diện người dùng động**:
  - Tự động chuyển đổi bảng màu (colorscheme) dựa trên loại tệp đang chỉnh sửa.
- **Tích hợp LSP mạnh mẽ**:
  - Tự động thiết lập các phím tắt quan trọng cho LSP (`go to definition`, `hover`, `rename`, v.v.) chỉ khi LSP được kích hoạt, giúp tối ưu hiệu năng.
- **Tùy chỉnh có sẵn**:
  - Cải thiện hành vi của trình duyệt tệp `netrw`.
  - Thêm hỗ trợ nhận dạng cho các tệp `.templ`.

## 📋 Yêu cầu

- **Neovim**: Phiên bản `0.5` trở lên.
- **Plugin**:
  - [plenary.nvim](https://github.com/nvim-lua/plenary.nvim): Dùng cho hàm tải lại module.
  - `tokyonight.nvim`: Bảng màu cho tệp Zig.
  - `rose-pine`: Bảng màu mặc định.
- **Máy chủ Ngôn ngữ (LSP)**: Bạn cần cài đặt các LSP server tương ứng với ngôn ngữ bạn làm việc (ví dụ: `lua-language-server`, `gopls`, `rust-analyzer`).

## 🚀 Cài đặt

1.  **Đặt tệp cấu hình**:
    Sao chép nội dung của `init.lua` và đặt nó vào đường dẫn cấu hình Neovim của bạn:
    -   **Linux/macOS**: `~/.config/nvim/init.lua`
    -   **Windows**: `~/AppData/Local/nvim/init.lua`

2.  **Cài đặt Plugin**:
    Bạn cần sử dụng một trình quản lý plugin như [lazy.nvim](https://github.com/folke/lazy.nvim) hoặc [packer.nvim](https://github.com/wbthomason/packer.nvim) để cài đặt các plugin được liệt kê trong phần **Yêu cầu**.

## ⚙️ Giải thích Cấu hình

### Tổ chức & Tiện ích
- **`augroup`**: Các lệnh tự động (`autocmd`) được nhóm vào `ThePrimeagenGroup` và `HighlightYank` để dễ dàng quản lý và xóa khi cần, đảm bảo cấu hình luôn sạch.
- **Hàm `R(name)`**: Một hàm tiện ích (`require("plenary.reload")`) giúp tải lại các tệp cấu hình Lua mà không cần khởi động lại Neovim.

### Cải thiện Trải nghiệm Soạn thảo
- **Highlight on Yank**: Sử dụng sự kiện `TextYankPost` để tô sáng nhanh vùng văn bản vừa được sao chép, giúp xác nhận hành động một cách trực quan.
- **Trim Whitespace**: Sử dụng sự kiện `BufWritePre` để tự động chạy lệnh `%s/\s\+$//e`, xóa các khoảng trắng thừa ở cuối dòng trước khi lưu.

### Giao diện Động
- Một `autocmd` trên sự kiện `BufEnter` sẽ kiểm tra kiểu tệp (`filetype`):
  - Nếu là `"zig"`, đổi bảng màu thành `tokyonight-night`.
  - Ngược lại, sử dụng `rose-pine-moon`.

### Tích hợp LSP
- **`LspAttach`**: Đây là sự kiện quan trọng nhất, nó chỉ kích hoạt các phím tắt LSP khi một máy chủ ngôn ngữ đã sẵn sàng hoạt động trên buffer hiện tại. Điều này giúp tối ưu và tránh lỗi khi mở các tệp không có LSP.

### Tùy chỉnh `netrw`
- Các thiết lập `vim.g.netrw_*` được dùng để tùy chỉnh trình duyệt tệp mặc định:
  - Mở tệp trong cửa sổ hiện tại (`netrw_browse_split = 0`).
  - Ẩn banner không cần thiết (`netrw_banner = 0`).
  - Đặt kích thước cửa sổ là 25% (`netrw_winsize = 25`).

## ⌨️ Các phím tắt chính

Các phím tắt sau đây sẽ tự động được kích hoạt trong các buffer có LSP.

| Chế độ | Phím tắt      | Chức năng                               |
| :----- | :------------ | :--------------------------------------- |
| Normal | `gd`          | Đi tới Định nghĩa (Go to Definition)     |
| Normal | `K`           | Hiển thị thông tin (Hover)               |
| Normal | `<leader>vws` | Tìm kiếm Biểu tượng trong Workspace      |
| Normal | `<leader>vd`  | Mở cửa sổ chẩn đoán (Lỗi/Cảnh báo)       |
| Normal | `<leader>vca` | Hiển thị Hành động Code (Code Action)    |
| Normal | `<leader>vrr` | Xem các Tham chiếu (References)          |
| Normal | `<leader>vrn` | Đổi tên Biểu tượng (Rename)              |
| Normal | `[d`          | Đi tới chẩn đoán tiếp theo               |
| Normal | `]d`          | Đi tới chẩn đoán trước đó                |
| Insert | `<C-h>`       | Gợi ý tham số của hàm (Signature Help)   |

---
_README này được tạo để giải thích tệp `init.lua`._
