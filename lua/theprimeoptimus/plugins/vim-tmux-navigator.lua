-- Phía nvim của vim-tmux-navigator. Phía tmux đã khai báo trong ~/.tmux.conf,
-- nhưng cần CẢ HAI phía thì Ctrl+h/j/k/l mới nhảy liền mạch được:
-- tmux dùng `ps` để xem pane có đang chạy nvim không -> nếu có thì gửi phím
-- vào nvim, và chính plugin này bên nvim quyết định chuyển split hay trả
-- phím ngược lại cho tmux khi đã hết split.
return {
    "christoomey/vim-tmux-navigator",

    -- Không lazy-load theo sự kiện: phím phải sẵn sàng ngay từ đầu.
    lazy = false,

    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
    },

    keys = {
        { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
}
