return {
  {
    'mason-org/mason.nvim',
    dependencies = {
      'mason-org/mason-lspconfig.nvim',
      opts = {
        automatic_enable = {
          exclude = {
            'jdtls',
          },
        },
      },
    },
    config = function()
      require('mason').setup()
      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = { 'basedpyright' },
      }
    end,
  },
  { 'mfussenegger/nvim-jdtls' },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },

    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      --capabilities = require("blink").default_capabilities(capabilities)

      -- lua_ls
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            format = { enable = true },
          },
        },
      })
      vim.lsp.enable 'lua_ls'

      -- bashls
      vim.lsp.enable 'bashls'

      -- clangd
      vim.lsp.config('clangd', {
        capabilities = capabilities,
        cmd = {
          'clangd',
          '--fallback-style=webkit',
        },
      })
      vim.lsp.enable 'clangd'

      -- basedpyright
      vim.lsp.config('basedpyright', {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'basic',
              autoImportCompletions = true,
              useLibrarycCodeForTypes = true,
              diagnosticSeverityOverrides = {
                reportUnknownParameterType = 'none',
                reportUnknownArgumentType = 'none',
                reportUnknownVariableType = 'none',
                reportUnknownMemberType = 'none',
                reportMissingTypeStubs = 'none',
              },
            },
          },
        },
      })
      vim.lsp.enable 'basedpyright'

      -- jdtls
      vim.lsp.enable 'jdtls'

      -- TODO:
      -- rust_analyser

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          if not client:supports_method 'textDocument/willSaveWaitUntil' and client:supports_method 'textDocument/formatting' then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format { bufnr = args.buf, id = client.id, timeout_ms = 1000 }
              end,
            })
          end
        end,
      })
    end,
  },
}
