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

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local bufnr = args.buf
    -- local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- if client.server_capabilities.completionProvider then
    --   vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    -- end
    -- if client.server_capabilities.definitionProvider then
    --   vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    -- end

    -- Mappings.
    local opts = { buffer=bufnr, noremap=true, silent=true }
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    -- lua vim.lsp.codelens.run()
    vim.keymap.set('n', ',ai', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.keymap.set('n', ',as', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.keymap.set('n', ',at', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.keymap.set('n', ',ar', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    vim.keymap.set('n', ',aR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.keymap.set('n', ',aa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.keymap.set('n', ',af', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)

    -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- vim.diagnostic.open_float
  end,
})

-- ddc用にcapabilitiesやforceCompletionPatternを設定する
-- https://zenn.dev/vim_jp/articles/6a2c9717930e54
require("ddc_source_lsp_setup").setup()
-- local capabilities = require("ddc_source_lsp").make_client_capabilities()


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
    flags = flags,
  }
end

nvim_lsp["metals"].setup {
  flags = flags,
  root_dir = util.root_pattern('build.sbt', 'build.sc', 'build.gradle', 'pom.xml', '.scala-build'),
  filetypes = { "scala", "sbt", "java" },
  -- init_options = {
  --   statusBarProvider = 'off',
  -- },
}

nvim_lsp["yamlls"].setup {
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

nvim_lsp.solargraph.setup {
  flags = flags,
  single_file_support = true,
  init_options = { formatting = true },
  settings = {
    solargraph = {
      diagnostics = false
    }
  }
}

nvim_lsp["lua_ls"].setup {
  flags = flags,
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
        -- なぜか起動しなくなるのでコメントアウト
        -- library = vim.api.nvim_get_runtime_file("", true),
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
