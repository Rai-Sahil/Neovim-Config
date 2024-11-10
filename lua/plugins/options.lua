vim.cmd("colorscheme rose-pine-main") -- colorscheme
-- New Highlight Groups
vim.cmd("highlight Package_Import_Return guifg=#7C887F")
vim.cmd("highlight String guifg=#C7ADA6")  -- String literal color C7ADA6
vim.cmd("highlight Keyword guifg=#7C887F")  -- Keyword (func, defer, interface...) color
vim.cmd("highlight Function guifg=#7C887F")  -- Replace with your preferred color
vim.cmd("highlight @type.builtin guifg=#C7D1C9")  -- Replace with your preferred color
vim.cmd("highlight @type guifg=#C7D1C9")  -- Replace with your preferred color
vim.cmd("highlight @keyword.import guifg=#7C887F")  -- Replace with your preferred color
vim.cmd("highlight @keyword.return guifg=#7C887F")  -- Replace with your preferred color
vim.cmd("highlight @keyword.conditional guifg=#7C887F")  -- Replace with your preferred color
vim.cmd("highlight @keyword.conditional.ternary guifg=#7C887F")  -- Replace with your preferred color
vim.cmd("highlight @keyword.exception guifg=#7C887F")  -- Replace with your preferred color
vim.cmd("highlight @keyword.repeat guifg=#7C887F")  -- Replace with your preferred color

--vim.fn.matchadd('Package_Import_Return', 'if', 10)
--vim.fn.matchadd('Package_Import_Return', 'else', 10)
--vim.fn.matchadd('Package_Import_Return', 'for', 10)
--vim.fn.matchadd('Package_Import_Return', '#include', 10)
--vim.fn.matchadd('Package_Import_Return', 'while', 10)

vim.cmd("syntax enable")

-- Consistent screen color approx active and inactive windows.
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")

vim.opt.termguicolors = true -- bufferline
vim.cmd("highlight String guifg=#C7ADA6")  -- String literal color C7ADA6
require("bufferline").setup {} -- bufferline
