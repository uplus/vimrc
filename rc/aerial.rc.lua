require('aerial').setup({
  -- TODO: lsp(solargraph)だとシンボルツリーがフラットになる
  backends = {
    _ = { "treesitter", "lsp", "markdown" },
    markdown = { "treesitter", "markdown" },
  },

  lsp = {
    -- Fetch document symbols when LSP diagnostics update.
    -- If false, will update on buffer changes.
    diagnostics_trigger_update = false,
  },

  layout = {
    default_direction = 'float',

    -- open aerial at the far right/left of the editor
    placement_editor_edge = true,

    max_width = { 40, 0.3 },
    width = nil,
    min_width = 40,
  },

  float = {
    border = "rounded",
    --   editor - Opens float centered in the editor
    relative = "editor",

    -- These control the height of the floating window.
    -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a list of mixed types.
    -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
    max_height = 0.9,
    height = nil,
    min_height = { 8, 0.1 },
  },

  open_automatic = false,
  close_on_select = true,
  close_automatic_events = { 'unfocus' },
  attach_mode = 'window',
})
