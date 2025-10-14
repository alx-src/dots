return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    config = function()
      require('noice').setup {
        routes = {
          {
            filter = {
              event = 'lsp',
              kind = 'progress',
              find = 'jdtls',
            },
            opts = { skip = true },
          },
        },
      }
    end,
  },
}
