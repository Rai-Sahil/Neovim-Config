vim.opt.nu = true -- Numbers will be shown
vim.opt.relativenumber = true -- Relative numbers will be shown
vim.opt.encoding = 'utf-8' -- set encoding

vim.opt.tabstop = 4 -- set tab length
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.list = false -- show tab whitespaces
vim.opt.autoindent = true -- set auto-indentation
vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.ignorecase = true -- Ignore case while searching

vim.opt.hlsearch = false -- Do not highlight previous searches
vim.opt.incsearch = true -- Highlight search as you type

vim.opt.termguicolors = true -- enable true colors

vim.opt.scrolloff = 9 -- min number of lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- min number of columns to keep above and below the cursor

vim.opt.updatetime = 50 -- Faster update time

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.py",
  callback = function()
    vim.opt.textwidth = 79
    vim.opt.colorcolumn = "79"
  end
}) -- python formatting

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.js", "*.jsx", "*.tsx", "*.html", "*.css", "*.lua"},
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
  end
}) -- javascript formatting

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
      if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
        vim.cmd("normal! g`\"")
      end
    end
}) -- return to last edit position when opening files
