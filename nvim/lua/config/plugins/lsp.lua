return {
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
      -- bashls

      -- clangd
      vim.lsp.config('clangd', {
        capabilities = capabilities,
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'h', 'hpp' },
        cmd = {
          'clangd',
          '--fallback-style=webkit',
          '--compile-commands-dir=build',
          '--background-index',
          '--clang-tidy',
        },
        root_markers = { 'CMakeLists.txt', '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
        single_file_support = true,
      })

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
  {
    'mason-org/mason.nvim',
  },
  {
    'williamboman/mason-lspconfig.nvim', 
    dependencies = {
      'williamboman/mason.nvim', 
      'neovim/nvim-lspconfig',
    },
    opts = {
      automatic_enable = {
        exclude = {
          'jdtls',
        },
      },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()
    end,
  },
}
