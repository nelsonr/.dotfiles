local bind = vim.keymap.set
local unbind = vim.keymap.del
local opts = { noremap = true, silent = true }

--------------------------------
-- Common Keymaps
--------------------------------

-- Clear highlight with <Esc>
bind("n", "<Esc>", "<Esc>:noh<CR>", opts)

-- Redo with uppercase "U"
bind("n", "U", "<cmd>:redo<CR>", opts)

-- Yank line with uppercase "Y"
bind({"n", "v"}, "Y", "yy", opts)

-- Use Tab and Shift+Tab to indent/outdent when in Visual mode
bind("v", "<Tab>", ">gv", opts)
bind("v", "<S-Tab>", "<gv", opts)

-- Insert line break in Normal mode
bind("n", "<S-k>", "i<CR><Esc>w", opts)

-- Jump to matching pairs with "M"
bind("n", "M", "%", { remap = true, silent = true })
bind("v", "M", "%", { remap = true, silent = true })

-- Jump between changes with "<" and ">"
bind("n", "<", "g;", opts)
bind("n", ">", "g,", opts)

-- Move between methods
bind("n", "(", "[m", opts)
bind("n", ")", "]m", opts)

-- Align on Top, Center or Bottom
bind("n", "<leader>t", "zt")
bind("n", "<leader>g", "zz")
bind("n", "<leader>b", "zb")

if vim.g.vscode then
  --------------------------------
  -- Visual Studio Code Keymaps
  --------------------------------
  local vscode = require("vscode")

  -- Center line
  bind("n", "<leader>g", function()
    vscode.action('vscode-neovim.send', { args = { "zz" } })
  end, { silent = true })

  -- Top
  bind("n", "<leader>t", function()
    vscode.action('vscode-neovim.send', { args = { "zt" } })
  end, { silent = true })

  -- Bottom
  bind("n", "<leader>b", function()
    vscode.action('vscode-neovim.send', { args = { "zb" } })
  end, { silent = true })

  -- Disable some mappings when inside VS Code
  unbind("n", "grr")
  unbind("n", "grn")
  unbind("n", "gri")
  unbind("n", "gra")

  -- Move vertically without expanding folds
  bind("n", "j", "gj", { remap = true })
  bind("n", "k", "gk", { remap = true })

  -- Move lines up and down
  bind({"n", "v"}, "<C-j>", "<cmd>lua require('vscode').action('editor.action.moveLinesDownAction')<CR>", opts)
  bind({"n", "v"}, "<C-k>", "<cmd>lua require('vscode').action('editor.action.moveLinesUpAction')<CR>", opts)

  -- Move editors to other groups
  bind("n", "<leader>h", "<cmd>lua require('vscode').action('workbench.action.moveEditorToPreviousGroup')<CR>", opts)
  bind("n", "<leader>l", "<cmd>lua require('vscode').action('workbench.action.moveEditorToNextGroup')<CR>", opts)
  bind("n", "<leader>j", "<cmd>lua require('vscode').action('workbench.action.moveEditorToBelowGroup')<CR>", opts)
  bind("n", "<leader>k", "<cmd>lua require('vscode').action('workbench.action.moveEditorToAboveGroup')<CR>", opts)

  -- Resize editor groups
  bind("n", "+", "<cmd>lua require('vscode').action('workbench.action.increaseViewSize')<CR>", opts)
  bind("n", "-", "<cmd>lua require('vscode').action('workbench.action.decreaseViewSize')<CR>", opts)

  -- Go to references
  bind("n", "gr", "<cmd>lua require('vscode').action('editor.action.goToReferences')<CR>", opts)

  -- Go to symbol in active editor
  bind("n", "go", "<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<CR>", opts)

  -- Go to symbol in workspace
  bind("n", "gO", "<cmd>lua require('vscode').action('workbench.action.showAllSymbols')<CR>", opts)

  -- Go to definition
  bind("n", "<leader>d", "<cmd>lua require('vscode').action('editor.action.revealDefinition')<CR>", opts)

  -- Go to line start/end
  unbind("n", "==")
  bind({"n", "v"}, "0", "^", opts)
  bind("n", "=", "$", opts)

  -- Fold region
  bind("n", "<leader>f", "<cmd>lua require('vscode').action('editor.toggleFold')<CR>", opts)
else
  --------------------------------
  -- Neovim Keymaps
  --------------------------------

  -- Delete buffer with "Ctrl+W D"
  bind("n", "<C-w>d", "<cmd>:bd<CR>", opts)

  -- Scroll and center on current line
  bind("n", "<C-u>", "<C-u>zz", opts)
  bind("n", "<C-d>", "<C-d>zz", opts)

  -- Change buffer with Tab and Shift+Tab
  bind("n", "<Tab>", "<cmd>:bnext<CR>", opts)
  bind("n", "<S-Tab>", "<cmd>:bprev<CR>", opts)

  -- Show symbol hover information with "gh"
  bind("n", "gh", vim.lsp.buf.hover, opts)

  -- Go to definition with "gd"
  bind("n", "gd", vim.lsp.buf.definition, opts)

  -- Toggle File Explorer with "\"
  bind("n", "\\", "<cmd>:NvimTreeToggle<CR>", opts)
end

--------------------------------
-- Language Specific Keymaps
--------------------------------

local function set_language_config()
  local ft = vim.bo.filetype

  if ft == "javascript" or ft == "typescript" or ft == "css" or ft == "scss" then
    -- Visual line moves cursor to end of line
    bind({"n", "v"}, "V", "V$", opts)
  end
end

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"*"},
  callback = set_language_config
})

