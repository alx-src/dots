return {
  {
    'echasnovski/mini.nvim',
    enabled = true,
    config = function()
      require('mini.statusline').setup { use_icons = true }
      require('mini.tabline').setup()
      require('mini.pairs').setup()
      require('mini.comment').setup()
      require('mini.files').setup()
      vim.keymap.set('n', '<leader>ee', '<cmd>lua MiniFiles.open()<CR>', { desc = 'Toggle file explorer' })
      vim.keymap.set('n', '<leader>ef', function()
        require('mini.files').open(vim.api.nvim_buf_get_name(0), false)
        require('mini.files').reveal_cwd()
      end, { desc = 'Toggle file explorer into currently opened file' })
      -- require('mini.starter').setup()
      -- require('mini.notify').setup()
    end,
  },
}
