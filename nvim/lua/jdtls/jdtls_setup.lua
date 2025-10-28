local M = {}

function M:setup()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = '/home/alx/develpoment/jdtls_data' .. project_name
  local config = {
    cmd = {
      '/usr/lib/jvm/java-21-openjdk/bin/java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.produce=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx1g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens',
      'java.base/java.util=ALL-UNNAMED',
      '--add-opens',
      'java.base/java.lang=ALL-UNNAMED',

      '-jar',
      '/home/alx/.local/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar',
      '-configuration',
      '/home/alx/.local/share/nvim/mason/packages/jdtls/config_linux',
      '-data',
      workspace_dir,
    },
    root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew' },
    settings = {
      java = {},
    },
  }
end

return M
