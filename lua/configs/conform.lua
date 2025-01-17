-- Helper function to check for the existence of biome.json
local function use_biome()
  local biome_config = vim.fn.findfile("biome.json", ".;") -- Searches for biome.json upwards
  return biome_config and #biome_config > 0
end

local function ifHasBiome(def)
  return use_biome() and vim.list_extend(vim.deepcopy(def), { "biome" }) or def
end

local options = {
  log_level = vim.log.levels.DEBUG,
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },

    javascript = ifHasBiome { "prettierd" },
    typescript = ifHasBiome { "prettierd" },
    javascriptreact = ifHasBiome { "prettierd" },
    typescriptreact = ifHasBiome { "prettierd" },
    json = ifHasBiome {},

    -- comment this for now to see how eslint-lsp works
    -- javascript = { "eslint_d", "prettierd" },
    -- typescript = { "eslint_d", "prettierd" },
    -- javascriptreact = { "eslint_d", "prettierd" },
    -- typescriptreact = { "eslint_d", "prettierd" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    -- lsp_fallback = true,
  },
}

require("conform").setup(options)
