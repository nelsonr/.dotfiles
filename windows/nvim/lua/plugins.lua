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

if vim.g.vscode then
  --------------------------------
  -- Visual Studio Code Plugins
  --------------------------------

  require("lazy").setup({
    spec = {
      -- Surround Plugin
      {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
          require("nvim-surround").setup({})
        end
      },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- automatically check for plugin updates
    checker = { enabled = true },
  })
else
  --------------------
  -- Neovim Plugins
  --------------------

  require("lazy").setup({
    spec = {
      -- Kanagawa colorscheme
      {
        "rebelot/kanagawa.nvim",
        config = function()
          vim.cmd("colorscheme kanagawa")
        end
      },
      -- Better buff delete
      {
        "moll/vim-bbye",
      },
      -- Surround
      {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
          require("nvim-surround").setup()
        end
      },
      -- Mason
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup()
        end
      },
      -- Telescope
      {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
          local builtin = require("telescope.builtin")

          -- Go to files with Ctrl+P
          vim.keymap.set("n", "<C-P>", builtin.find_files, { desc = "Telescope Find files" })

          -- Go to document symbols with "go"
          vim.keymap.set("n", "go", builtin.lsp_document_symbols, { desc = "Telescope Document Symbols" })
        end
      },
      -- Status line
      {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        options = {
          globalstatus = true,
        },
        config = function()
          require("lualine").setup()
        end
      },
      -- Clear trail spaces
      {
        "echasnovski/mini.nvim",
        version = "*",
        config = function()
          require("mini.trailspace").setup()
        end
      },
      -- File Explorer
      {
        "nvim-tree/nvim-tree.lua",
        config = function()
          require("nvim-tree").setup()
        end
      },
      -- LSP Diagnostics and more
      {
        "folke/trouble.nvim",
        cmd = "Trouble",
        config = function()
          require("trouble").setup()
        end,
        keys = {
          {
            "<F8>",
            "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>",
            desc = "Toggle Diagnostics Panel"
          }
        }
      },
      -- Treesitter
      {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate", -- Automatically update parsers
        config = function()
          require"nvim-treesitter.configs".setup {
            ensure_installed = { "lua", "javascript", "typescript", "css", "html", "vim", "vimdoc" },
            highlight = {
              enable = true, -- Enable syntax highlighting
              additional_vim_regex_highlighting = false, -- Disable old vim syntax highlighting
            },
            indent = {
              enable = true, -- Enable indentation support
            },
            -- Enable code folding (optional)
            folding = {
              enable = true,
            },
          }
        end
      },
    },
    -- Autopairs
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup({})
      end
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },

    -- Configure any other settings here. See the documentation for more details.
    -- automatically check for plugin updates
    checker = { enabled = true },
  })
end

