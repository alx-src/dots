return {
  {
    'lmantw/themify.nvim',
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 999,
    config = function()
      require('themify').setup {
        'folke/tokyonight.nvim',
        'sho-87/kanagawa-paper.nvim',
        'comfysage/evergarden',
        'catppuccin/nvim',
        'EdenEast/nightfox.nvim',
        'scottmckendry/cyberdream.nvim',
        'bluz71/vim-moonfly-colors',
        'projekt0n/github-nvim-theme',
        'zenbones-theme/zenbones.nvim',
        'default',
      }
    end,
  },
}
