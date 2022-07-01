local M = {}

M.config = function()
  -- NOTE: By default, all null-ls providers are checked on startup.
  -- If you want to avoid that or want to only set up the provider
  -- when you opening the associated file-type,
  -- then you can use filetype plugins for this purpose.
  -- https://www.lunarvim.org/languages/#lazy-loading-the-formatter-setup
  local status_ok, nls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  local custom_md_hover = require "user.null_ls.markdown"
  local sources = {
    -- NOTE: npm install -g prettier prettier-plugin-solidity
    nls.builtins.formatting.prettier.with {
      filetypes = { "solidity" },
      timeout = 10000,
    },
    nls.builtins.formatting.prettierd.with {
      condition = function(utils)
        return not utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = "node_modules/.bin",
    },
    nls.builtins.formatting.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = "node_modules/.bin",
    },
    nls.builtins.formatting.stylua,
    nls.builtins.diagnostics.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = "node_modules/.bin",
    },
    nls.builtins.diagnostics.semgrep.with {
      condition = function(utils)
        return utils.root_has_file ".semgrepignore"
      end,
      extra_args = { "--metrics", "off", "--config", "'p/r2c-security-audit'" },
    },
    nls.builtins.diagnostics.shellcheck,
    nls.builtins.diagnostics.luacheck,
    nls.builtins.diagnostics.markdownlint.with {
      filetypes = { "markdown" },
    },
    nls.builtins.diagnostics.vale.with {
      filetypes = { "markdown" },
    },
    nls.builtins.code_actions.shellcheck,
    nls.builtins.code_actions.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = "node_modules/.bin",
    },
    -- TODO: try these later on
    -- nls.builtins.formatting.google_java_format,
    -- nls.builtins.code_actions.proselint,
    -- nls.builtins.diagnostics.proselint,
    custom_md_hover.dictionary,
  }
  if lvim.builtin.refactoring.active then
    table.insert(
      sources,
      nls.builtins.code_actions.refactoring.with {
        filetypes = { "typescript", "javascript", "lua" },
      }
    )
  end

  -- you can either config null-ls itself
  nls.setup {
    on_attach = require("lvim.lsp").common_on_attach,
    debounce = 150,
    save_after_format = false,
    sources = sources,
  }
end

return M
