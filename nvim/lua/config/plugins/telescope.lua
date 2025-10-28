return {
  {
    'nvim-telescope/telescope.nvim',
    enabled = true,
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },

    config = function()
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<space>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<space>fb', builtin.buffers, { desc = 'Telescope open buffers' })
      vim.keymap.set('n', '<space>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<space>fg', builtin.live_grep, { desc = 'Telescope grep files' })
      vim.keymap.set('n', '<space>fc', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath 'config',
        }
      end, { desc = 'Telescope Nvim config' })
      vim.keymap.set('n', '<space>ep', function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy'),
        }
      end)

      require('telescope').setup {
        defaults = {},
        pickers = {
          find_files = {
            theme = 'ivy',
          },
          help_tags = {
            theme = 'ivy',
          },
          live_grep = {
            theme = 'ivy',
          },
        },
        extensions = {
          fzf = {
            --[[fuzzy = true,
            override_generic_sorter=true,
            override_file_sorter=true,
            case_mode = "smart_case",
            ]]
          },
        },
      }

      --require('telescope').load_extension('fzf')
    end,
  },
}
