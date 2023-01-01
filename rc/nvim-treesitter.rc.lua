require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- disable = {},
    disable = function(lang)
      local ok = pcall(function()
        vim.treesitter.get_query(lang, 'highlights')
      end)
      return not ok
    end,
  },
  indent = {
    enable = true,
    disable = {'python', 'ruby'},
  },
  rainbow = {
    enable = false,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },

      selection_modes = {
        -- ['@parameter.outer'] = 'v', -- charwise
        ['@function.inner'] = 'V', -- linewise
        ['@class.inner'] = 'V', -- blockwise
      },

      -- include_surrounding_whitespace = false,
    },
    move = {
      enable = true,

      -- Whether to set jumps in the jumplist
      set_jumps = true,

      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}
