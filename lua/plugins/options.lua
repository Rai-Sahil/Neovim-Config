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

vim.cmd [[
  highlight Comment cterm=NONE gui=NONE
  highlight Keyword cterm=NONE gui=NONE
  highlight String cterm=NONE gui=NONE
  highlight Function cterm=NONE gui=NONE
  highlight Type cterm=NONE gui=NONE
  highlight Statement cterm=NONE gui=NONE
  highlight Identifier cterm=NONE gui=NONE
]]

local function ColorMyWebDev()
  vim.cmd("highlight @type.builtin gui=none")

  vim.cmd('highlight JSDoc guifg=#31748F')
  vim.cmd('highlight JSDocType guifg=#9CCFD8')
end

-- Colortheme changes for go file
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript" },  -- Only match TS/JS files
  callback = ColorMyWebDev,
})

vim.cmd("highlight @variable gui=none") -- variable should not be italic
-- Consistent screen color approx active and inactive windows.
vim.cmd("highlight NormalNC guibg=NONE ctermbg=NONE")

vim.api.nvim_set_hl(0, "Normal", { bg = "#111111" }) -- Deep black
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#101010" }) -- Slight shine

-- Curosr shape
vim.opt.guicursor = "n-v-i-c:block-Cursor"

vim.opt.termguicolors = true -- bufferline
require("bufferline").setup {} -- bufferline
