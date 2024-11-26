local api = vim.api

-- Namespace for virtual text
local namespace = api.nvim_create_namespace("git_blame")

-- Flag to track whether blame is active
local blame_active = true

-- Function to check if the buffer is a normal file buffer (not a terminal or floating window)
local function is_normal_buffer()
  local bufnr = api.nvim_get_current_buf()
  local filetype = api.nvim_buf_get_option(bufnr, "filetype")
  return filetype ~= "terminal" and not vim.fn.bufname(bufnr):match("fugitive://") and not vim.fn.bufname(bufnr):match("NvimTree") and filetype ~= ""
end

-- Function to fetch and display blame info for the current line
local function show_git_blame()
  if not blame_active or not is_normal_buffer() then
    return
  end

  local bufnr = api.nvim_get_current_buf()
  local cursor = api.nvim_win_get_cursor(0)
  local line = cursor[1]

  -- Run Git blame command for the current file and line
  local blame_cmd = string.format("git blame -L %d,%d -- %s", line, line, vim.fn.expand("%"))
  local blame_output = vim.fn.systemlist(blame_cmd)

  -- Handle uncommitted or Git errors
  if vim.v.shell_error ~= 0 or not blame_output[1] or blame_output[1]:match("^%^%s*") then
    api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
    api.nvim_buf_set_virtual_text(bufnr, namespace, line - 1, { { " Not yet committed", "Comment" } }, {})
    return
  end

  -- Parse the blame output
  local blame_line = blame_output[1]
  local author = blame_line:match("%((.-)%s+%d") or "Unknown Author"
  local time = blame_line:match("%s(%d%d%d%d%-%d%d%-%d%d)%s") or "Unknown Date"
  local summary = blame_line:match(": (.+)") or "No summary"

  -- If the author matches the current user's Git name, show "You"
  local git_user = vim.fn.system("git config user.name"):gsub("\n", "")
  if author:find(git_user, 1, true) then
    author = "You"
  end

  -- Create blame message
  local blame_message = string.format(" %s | %s | %s", author, time, summary)

  -- Clear previous virtual text and add the new one
  api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)
  api.nvim_buf_set_virtual_text(bufnr, namespace, line - 1, { { blame_message, "Comment" } }, {})
end

-- Enable blame display by default
vim.api.nvim_create_autocmd({ "CursorMoved", "BufEnter" }, {
  callback = show_git_blame,
})

-- Command to disable blame display
vim.api.nvim_create_user_command("GitBlameOff", function()
  blame_active = false
  api.nvim_buf_clear_namespace(0, namespace, 0, -1)
  print("Git blame display disabled.")
end, {})

-- Command to re-enable blame display
vim.api.nvim_create_user_command("GitBlameOn", function()
  blame_active = true
  show_git_blame()
  print("Git blame display enabled.")
end, {})

