return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = { enabled = true, example = 'files' },
      indent = { enabled = true },
      quickfile = { enabled = true },
      -- dim = { enabled = false },
      -- scroll = { enabled = true },
      -- gitbrowse = { enabled = false },
      -- terminal = { enabled = false },
      words = { enabled = true },
    },
  },
}
