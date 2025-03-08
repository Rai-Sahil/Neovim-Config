-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>gf", ":Telescope git_files<cr>")
vim.keymap.set("n", "<leader>wf", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>of", ":Telescope oldfiles<cr>")

-- Comment Telescope
vim.keymap.set("n", "<leader>cm", ":TodoTelescope<cr>")
vim.keymap.set("n", "<leader>qf", ":TodoQuickFix<cr>")

-- File Tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- Split Screenslocal
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>vs", function()
  builtin.find_files({
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd("vsplit " .. selection.path)
      end)
      return true
    end,
  })
end, { noremap = true, silent = true })

