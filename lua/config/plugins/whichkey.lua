return {
  {
    "folke/which-key.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      spec = {
      },
    },
    keys = {
      --"<C-w>", function() require("which-key").show({}) end,
    },
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 400

      local wk = require("which-key")
      wk.add({
        { "<C-w>",           group = "Windows" },
        { "<leader>f",       group = "Telescope" },
        { "<leader>e",       group = "Plugins" },
        { "<leader><space>", group = "Refresh Nvim" },
      })
    end,
  },
}
