-- <SPACE> is the leader key
vim.g.mapleader = " "

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>")
vim.keymap.set("n", "<leader>p", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")

-- yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", '"+y', { noremap = true, silent = true })

-- Format file
vim.keymap.set("n", "<leader>fm", ":silent !black %<cr>")
