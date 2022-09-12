-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
-- https://qiita.com/kitagry/items/216c2cf0066ff046d200#lspdocumentdiagnostics

local nvim_lsp = require('lspconfig')
local util = require('lspconfig/util')

-- Disable diagnostic callback
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end

-- Debug
-- vim.lsp.set_log_level("trace")
-- vim.lsp.set_log_level("debug")
-- lua vim.cmd('tabnew'..vim.lsp.get_log_path())

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  require("aerial").on_attach(client, bufnr)

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- lua vim.lsp.codelens.run()
  buf_set_keymap('n', ',ai', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', ',as', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', ',at', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', ',ar', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  buf_set_keymap('n', ',aR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', ',aa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', ',af', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local flags = {
  debounce_text_changes = 150,
}

-- :help lspconfig-server-configurations
-- "marksman"
  -- h1が複数あると警告が出て邪魔
for _, server in ipairs({ "pyright", "rust_analyzer", "tsserver", "gopls", "graphql", "dockerls", }) do
  nvim_lsp[server].setup {
    on_attach = on_attach,
    flags = flags,
  }
end

nvim_lsp["metals"].setup {
  on_attach = on_attach,
  flags = flags,
  filetypes = { "scala", "sbt", "java" },
}

nvim_lsp["yamlls"].setup {
  on_attach = on_attach,
  flags = flags,
  settings = {
    yaml = {
      -- schema pair patterns
      schemas = {
        -- special reserved key
        kubernetes = {"charts/**/*.yaml", "charts/**/*.yml"},
      }
    },
    redhat = { telemetry = { enabled = false } },
  }
}

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

nvim_lsp["sumneko_lua"].setup {
  on_attach = on_attach,
  flags = flags,
  single_file_support = true,
  init_options = { formatting = true },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  }
}

-- npm install -g typescript typescript-language-server pyright yaml-language-server graphql-language-service-cli dockerfile-language-server-nodejs
-- gem install solargraph
-- go install golang.org/x/tools/gopls@latest
-- wget https://github.com/artempyanykh/marksman/releases/download/2022-06-02/marksman-linux -O ~bin/marksman && chmod +x ~bin/marksman
  -- https://github.com/artempyanykh/marksman/releases/latest
