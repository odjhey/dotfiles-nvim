require "nvchad.mappings"

local map = vim.keymap.set

-- @todo modify descriptions to show well in the cheatsheet, format is desc = "group desc"

vim.g.telescope_search_dir = nil -- Initialize the variable
vim.keymap.set("n", "<leader>fd", function()
  require("telescope.builtin").find_files {
    prompt_title = "Select Directory",
    cwd = vim.fn.getcwd(), -- Start from the current working directory
    find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" }, -- Directory search
    attach_mappings = function(prompt_bufnr, map)
      local actions = require "telescope.actions"
      local action_state = require "telescope.actions.state"

      local function set_dir()
        local selection = action_state.get_selected_entry()
        if selection and selection.path then
          vim.g.telescope_search_dir = selection.path
          print("Search directory set to: " .. vim.g.telescope_search_dir)
        else
          print "No directory selected"
        end
        actions.close(prompt_bufnr)
      end

      map("i", "<CR>", set_dir)
      map("n", "<CR>", set_dir)

      return true
    end,
  }
end, { desc = "Set Telescope search directory (dirs only, respects .gitignore)" })

vim.keymap.set("n", "<leader>fw", function()
  local dir = vim.g.telescope_search_dir
  if dir then
    require("telescope.builtin").live_grep { search_dirs = { dir } }
  else
    require("telescope.builtin").live_grep()
  end
end, { desc = "Live grep in set directory" })

vim.keymap.set("n", "<leader>ff", function()
  local dir = vim.g.telescope_search_dir
  if dir then
    require("telescope.builtin").find_files { cwd = dir }
  else
    require("telescope.builtin").find_files()
  end
end, { desc = "Find files in set directory" })

map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<leader>fs", "<cmd>Telescope grep_string<CR>", { desc = "grep_string" })
map("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", { desc = "quick fix" })
map("n", "<leader>fj", "<cmd>Telescope jumplist<CR>", { desc = "jump list" })
map("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "lsp references" })

-- hunks
map("n", "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<CR>", { desc = "Preview hunk" })
map("n", "<leader>ga", "<cmd>lua require('gitsigns').stage_hunk()<CR>", { desc = "Stage hunk" })
map("n", "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", { desc = "Undo stage hunk" })
map("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", { desc = "Reset hunk" })
map("n", "]h", "<cmd>lua require('gitsigns').next_hunk()<CR>", { desc = "Next Hunk" })
map("n", "[h", "<cmd>lua require('gitsigns').prev_hunk()<CR>", { desc = "Prev Hunk" })

local nomap = vim.keymap.del

-- Buffers
nomap("n", "<leader>x")
nomap("n", "<leader>b")
map("n", "<leader>bo", ":%bd|e#<CR>", { noremap = true, silent = true, desc = "Close Other Buffers" })
map("n", "<leader>bx", ":%bd<CR>", { noremap = true, silent = true, desc = "Close Buffer" })
map("n", "<leader>bl", "<cmd>Telescope buffers<CR>", { desc = "List Buffers" })

-- Override
map("n", "gR", "<cmd>Trouble lsp_references<CR>", { desc = "Find references using Trouble" })

vim.keymap.set("n", "<C-j>", "5j", { noremap = true, desc = "Jump 5 lines down" })
vim.keymap.set("n", "<C-k>", "5k", { noremap = true, desc = "Jump 5 lines up" })

-- remove terminal mappings
nomap("n", "<leader>h")
nomap("n", "<leader>v")

map(
  "n",
  "<leader>st",
  ':lua require("custom.swap_test_file").swap_source_test()<CR>',
  { noremap = true, silent = true }
)

local user = {
  n = {
    ["<left>"] = {
      "<cmd> cprev <cr>",
      "",
    },
    ["<right>"] = {
      "<cmd> cnext <cr>",
      "",
    },
    ["<up>"] = {
      "<cmd> lprev <cr>",
      "",
    },
    ["<down>"] = {
      "<cmd> lnext <cr>",
      "",
    },
    ["<leader><CR>"] = {
      "<C-^>",
      "",
    },
    -- Live Grep for the word under the cursor
    ["<leader>lw"] = {
      function()
        local word = vim.fn.expand "<cword>"
        require("telescope.builtin").live_grep {
          default_text = word,
        }
      end,
      "Live Grep word under cursor",
    },
  },
}

for key, value in pairs(user.n) do
  map("n", key, value[1], { desc = value[2] })
end

local harpoon = require "harpoon"
-- REQUIRED
harpoon:setup()
-- REQUIRED

-- stylua: ignore start
vim.keymap.set("n", "<leader>hh", function() harpoon:list():add() end, { desc = "Add mark to harpoon" })
vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "list harpoons" })
vim.keymap.set("n", "<C-h>", function() harpoon:list():prev() end, { desc = "prev harpoon" })
vim.keymap.set("n", "<C-l>", function() harpoon:list():next() end, { desc = "next harpoon" })
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "prev harpoon" })
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "next harpoon" })
vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, {desc ="select harpoon 1"})
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, {desc ="select harpoon 2"})
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, {desc ="select harpoon 3"})
vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, {desc ="select harpoon 4"})
-- stylua: ignore end
