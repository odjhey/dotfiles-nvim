require "nvchad.mappings"

local map = vim.keymap.set

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
map("n", "fs", "<cmd>Telescope grep_string<CR>", { desc = "grep_string" })
map("n", "fq", "<cmd>Telescope quickfix<CR>", { desc = "quick fix" })
map("n", "fj", "<cmd>Telescope jumplist<CR>", { desc = "jump list" })
map("n", "fr", "<cmd>Telescope lsp_references<CR>", { desc = "lsp references" })

-- hunks
map("n", "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<CR>", { desc = "Preview hunk" })
map("n", "<leader>ga", "<cmd>lua require('gitsigns').stage_hunk()<CR>", { desc = "Stage hunk" })
map("n", "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", { desc = "Undo stage hunk" })
map("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", { desc = "Reset hunk" })
map("n", "]c", "<cmd>lua require('gitsigns').next_hunk()<CR>", { desc = "Next Hunk" })
map("n", "[c", "<cmd>lua require('gitsigns').prev_hunk()<CR>", { desc = "Prev Hunk" })

-- Buffers
local nomap = vim.keymap.del
nomap("n", "<leader>x")
nomap("n", "<leader>b")
map("n", "<leader>bo", ":%bd|e#<CR>", { noremap = true, silent = true, desc = "Close Other Buffers" })

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
