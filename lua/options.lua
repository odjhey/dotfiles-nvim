require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

o.clipboard = ""
o.listchars = "tab:▸\\ ,trail:·,extends:>,precedes:<,nbsp:␣"

o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 999
