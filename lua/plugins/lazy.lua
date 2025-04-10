local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    "rose-pine/neovim",
    name = "rose-pine",
    groups = {
        background = "#000000", -- True black background
        panel = "#101010", -- Slightly lighter for contrast
    },
    highlight_groups = {
        FloatBorder = { bg = "#000000", fg = "#2a2a2a" },
          styles = { italic = false },
            palette = {
        dawn = {
          no_bg = '#faf4ed',
        },
        moon = {
          gold = '#f6d5a7',
          foam = '#a1d1da',
          iris = '#d9c7ef',
          rose = '#ebbcba',
          pine = '#437e91',
          no_bg = '#000000',
        },
      },
      highlight_groups = {
        Normal = { bg = 'no_bg' },
        Directory = { fg = 'foam', bold = false },
        StatusLine = { bg = 'surface', fg = 'subtle' },
        StatusLineTerm = { link = 'StatusLine' },
        StatusLineNC = { link = 'StatusLine' },
        --- gitsigns
        StatusLineGitSignsAdd = { bg = 'surface', fg = 'pine' },
        StatusLineGitSignsChange = { bg = 'surface', fg = 'gold' },
        StatusLineGitSignsDelete = { bg = 'surface', fg = 'rose' },
        --- diagnostics
        StatusLineDiagnosticSignError = { bg = 'surface', fg = 'love' },
        StatusLineDiagnosticSignWarn = { bg = 'surface', fg = 'gold' },
        StatusLineDiagnosticSignInfo = { bg = 'surface', fg = 'foam' },
        StatusLineDiagnosticSignHint = { bg = 'surface', fg = 'iris' },
        StatusLineDiagnosticSignOk = { bg = 'surface', fg = 'pine' },
      },


    },
    config = function()
      require('rose-pine').setup({
        disable_background = false,
        variant = 'main',
      })
      -- Set transparency for Normal and Floating windows
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

    end
  },

  -- Autopair
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },

  --Co-pilot
  {
      "github/copilot.vim"
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',  -- Ensures that Treesitter parsers are updated automatically
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { 'asm', 'go', 'html', 'lua', 'bash', 'json', 'javascript', 'typescript', 'python'},
        sync_install = false,
        auto_install = true,

        highlight = {
          enable = true, -- Enable syntax highlighting
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      }
    end
  },

  {
    'nvim-treesitter/playground'
  },

	-- Telescope
	{
	   'nvim-telescope/telescope.nvim', tag = '0.1.8',
	   dependencies = { 'nvim-lua/plenary.nvim' }
	 },

	-- File tree
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup {}
		end,
	},

	-- Bufferline
	{
    'akinsho/bufferline.nvim',
    version="*",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  -- Terminal inside neovim
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup{
        size = 15,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = '1',
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = 'horizontal', -- default direction
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 0,
          highlights = {
            background = "Normal",
            border = "Normal"
          }
        }
      }
    end
  },

  -- Save and load buffers automatically while reopening
  {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Downloads" },
      }
    end
  },

  -- LSP zero
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  {
    'Yazeed1s/minimal.nvim'
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      cmp.setup({
        formatting = lsp_zero.cmp_format({details = true}),
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection automatically
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        })
      })
    end
  },

  -- Comment Telescope
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        signs = true, -- show icons in the sign column
        keywords = {
          TODO = { icon = " ", color = "info" },
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          HACK = { icon = " ", color = "warning" },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        },
        highlight = {
          multiline = false,
        },
      }
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      --- if you want to know more about lsp-zero and mason.nvim
      --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      require('mason-lspconfig').setup({
        ensure_installed = {
          'pyright', -- py
          'gopls', -- go
          'clangd', -- c
          'vtsls', -- javascript
          'ast_grep' -- jsx
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })

      -- Golang enviroment
      require('lspconfig').gopls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        gopls = {
          usePlaceholders = true,
          staticcheck = true,
          analyses = {
            unusedparams = true,
            unreachable = true,
            shadow = true,
            -- Add more analyses as needed
          },
        },
      },
    }
    end
  },
})
