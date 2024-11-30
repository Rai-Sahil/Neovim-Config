vim.cmd("colorscheme rose-pine-main") -- colorscheme


  -- Use matchadd to highlight @param
  vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
      pattern = "*",
      callback = function()
          vim.fn.matchadd('JSDoc', '@param')
          vim.fn.matchadd('JSDoc', '@returns')
          vim.fn.matchadd('JSDocType', '{[^}]*}')
      end
  })

function ColorMyGoLang()
  vim.cmd("highlight String guifg=#C7ADA6")  -- String literal color C7ADA6
  vim.cmd("highlight Keyword guifg=#7C887F")  -- Keyword (func, defer, interface...) color
  vim.cmd("highlight Function guifg=#7C887F")
  vim.cmd("highlight @type.builtin guifg=#C7D1C9")  -- Replace with your preferred col
  vim.cmd("highlight @type guifg=#C7D1C9")  -- Replace with your preferred color
  vim.cmd("highlight @keyword.import guifg=#7C887F")  -- Replace with your preferred color
  vim.cmd("highlight @keyword.return guifg=#7C887F")  -- Replace with your preferred color
  vim.cmd("highlight @keyword.conditional guifg=#7C887F")  -- Replace with your preferred color
  vim.cmd("highlight @keyword.conditional.ternary guifg=#7C887F")  -- Replace with your preferred color
  vim.cmd("highlight @keyword.exception guifg=#7C887F")  -- Replace with your preferred color
  vim.cmd("highlight @keyword.repeat guifg=#7C887F")  -- Replace with your preferred color
end

local function ColorMyWebDev()
  vim.cmd("highlight @type.builtin gui=none")

  vim.cmd('highlight JSDoc guifg=#31748F')
  vim.cmd('highlight JSDocType guifg=#9CCFD8')
end

-- Colortheme changes for go file
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",  -- Only match Go files
  callback = ColorMyGoLang
})

-- Colortheme changes for go file
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript" },  -- Only match TS/JS files
  callback = ColorMyWebDev,
})

vim.cmd("highlight @variable gui=none") -- variable should not be italic
vim.cmd("highlight @variable.parameter gui=none") -- params should not be italic

-- Consistent screen color approx active and inactive windows.
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")

vim.opt.termguicolors = true -- bufferline
require("bufferline").setup {} -- bufferline
