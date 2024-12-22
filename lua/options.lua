require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

o.clipboard = ""
o.listchars = "tab:▸\\ ,trail:·,extends:>,precedes:<,nbsp:␣"

o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 999
o.scrolloff = 2

-- local navic = require "nvim-navic"
--
-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}" -- Use navic for WinBar
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client.server_capabilities.documentSymbolProvider then
--       navic.attach(client, args.buf)
--     end
--   end,
-- })

-- triggers CursorHold event faster
vim.opt.updatetime = 200

require("barbecue").setup {
  create_autocmd = false, -- prevent barbecue from updating itself automatically
}

vim.api.nvim_create_autocmd({
  "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",

  -- include this if you have set `show_modified` to `true`
  "BufModifiedSet",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})
