local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "biome" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.denols.setup {
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern "package.json",
  single_file_support = false,
  on_init = on_init,
  capabilities = capabilities,
}

-- lspconfig.biome.setup {
--   cmd = { "biome", "lsp" },
--   filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },
--   root_dir = require("lspconfig.util").root_pattern(".biomerc", ".biomerc.json", "package.json"),
--   settings = {},
-- }

lspconfig["eslint"].setup {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}

-- lspconfig.eslint.setup {
--   on_attach = function(client, bufnr)
--     -- Enable formatting
--     client.server_capabilities.documentFormattingProvider = true
--
--     -- Keymap for formatting
--     vim.api.nvim_buf_set_keymap(
--       bufnr,
--       "n",
--       "<leader>f",
--       ":lua vim.lsp.buf.format({ async = true })<CR>",
--       { noremap = true, silent = true }
--     )
--
--     -- Optional: Autoformat on save
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = bufnr,
--       command = "EslintFixAll",
--     })
--   end,
--   settings = {
--     eslint = {
--       -- Ensure ESLint uses the correct config file
--       configFile = ".eslintrc.cjs",
--       -- Auto-detect the working directory based on the config file
--       workingDirectory = { mode = "auto" },
--     },
--   },
-- }
