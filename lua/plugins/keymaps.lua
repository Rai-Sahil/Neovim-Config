-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>gf", ":Telescope git_files<cr>")
vim.keymap.set("n", "<leader>wf", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>of", ":Telescope oldfiles<cr>")

-- File Tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")
