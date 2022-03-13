-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md

local nvim_lsp = require('lspconfig')
local util = require('lspconfig/util')

-- Disable diagnostic callback
vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

-- Debug
-- vim.lsp.set_log_level("trace")
-- vim.lsp.set_log_level("debug")
-- lua vim.cmd('tabnew'..vim.lsp.get_log_path())

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local flags = {
  debounce_text_changes = 150,
}

-- :help lspconfig-server-configurations
for _, server in ipairs({ "pyright", "rust_analyzer", "tsserver", "gopls", "yamlls" }) do
  nvim_lsp[server].setup {
    on_attach = on_attach,
    flags = flags,
  }
end

nvim_lsp["solargraph"].setup {
  on_attach = on_attach,
  flags = flags,
  single_file_support = true,
  init_options = { formatting = true },
  settings = {
    solargraph = {
      diagnostics = false
    }
  }
}

-- npm install -g typescript typescript-language-server
-- npm install -g pyright
-- gem install solargraph
-- go install golang.org/x/tools/gopls@latest
-- npm install -g yaml-language-server
