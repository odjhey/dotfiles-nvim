require "nvchad.mappings"

-- @todo modify descriptions to show well in the cheatsheet, format is desc = "group desc"
local map = vim.keymap.set
local nomap = vim.keymap.del

-- we need <c-i> and apparently, tab is <c-i> in terminal
nomap("n", "<TAB>")
map("n", "<leader>sf", ":Navbuddy<CR>", { desc = "Open NavBuddy" })

local function telescope()
  vim.g.telescope_search_dir = nil -- Initialize the variable
  vim.keymap.set("n", "<leader>fd", function()
    require("telescope.builtin").find_files {
      previewer = false,
      prompt_title = "Select Directory",
      cwd = vim.fn.getcwd(), -- Start from the current working directory
      find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git", "--follow", "." }, -- Directory search
      attach_mappings = function(prompt_bufnr, map)
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"

        local function set_dir()
          local selection = action_state.get_selected_entry()
          if selection and selection.path then
            vim.g.telescope_search_dir = selection.path
            print("Search directory set to: " .. vim.g.telescope_search_dir)
          else
            vim.g.telescope_search_dir = nil
            print "No directory selected"
          end
          actions.close(prompt_bufnr)
        end

        map("i", "<CR>", set_dir)
        map("n", "<CR>", set_dir)

        -- Add a custom function to set the directory to '.'
        local function set_to_dot()
          vim.g.telescope_search_dir = "."
          print "Search directory set to: . (current directory)"
          actions.close(prompt_bufnr)
        end
        -- Map a custom key (e.g., <C-d>) to select '.'
        map("i", "<C-d>", set_to_dot)
        map("n", "<C-d>", set_to_dot)

        return true
      end,
    }
  end, { desc = "Set Telescope search directory (dirs only, respects .gitignore)" })

  vim.keymap.set("n", "<leader>fw", function()
    local dir = vim.g.telescope_search_dir
    if dir then
      require("telescope.builtin").live_grep { search_dirs = { dir } }
    else
      require("telescope.builtin").live_grep {}
    end
  end, { desc = "Live grep in set directory" })

  vim.keymap.set("n", "<leader>fo", function()
    local dir = vim.g.telescope_search_dir
    if dir then
      require("telescope.builtin").oldfiles { cwd = dir }
    else
      require("telescope.builtin").oldfiles()
    end
  end, { desc = "Live grep in set directory" })

  -- swap ff and c-p for now, to test frecency
  vim.keymap.set("n", "<c-p>", function()
    local dir = vim.g.telescope_search_dir
    local Path = require "plenary.path"
    local relpath = Path:new(dir):make_relative(vim.fn.getcwd())

    if dir then
      require("telescope.builtin").find_files {
        prompt_title = "Find Files: " .. relpath,
        cwd = dir,
        previewer = false,
      }
    else
      require("telescope.builtin").find_files {
        previewer = false,
      }
    end
  end, { desc = "Find files in set directory" })
end
telescope()

-- finders
nomap("n", "<leader>gt")
map("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "lsp references" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "grep_string" })
map("n", "<leader>fq", "<cmd>Telescope quickfix<CR>", { desc = "quick fix" })
map("n", "<leader>fj", "<cmd>Telescope jumplist<CR>", { desc = "jump list" })
map("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "lsp references" })
map("n", "<leader>0", "<cmd>Telescope resume<CR>", { desc = "telescope resume" })
map("n", "<c-t>", "<cmd>Telescope<CR>", { desc = "telescope open" })
map("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "telescope buffers" })
map("n", "<leader>fc", "<cmd>Telescope git_status<CR>", { desc = "telescope git_status" })
map(
  "n",
  "<leader>ff",
  "<cmd>Telescope frecency workspace=CWD theme=ivy previewer=false<CR>",
  { desc = "telescope open" }
)

-- quick fix
map("n", "<leader>co", ":copen<CR>", { noremap = true, silent = true, desc = "quickfix open" })
map("n", "<leader>cx", "<cmd>cclose<CR>", { noremap = true, silent = true, desc = "Quickfix: Close" })
map("n", "<leader>cr", "<cmd>call setqflist([])<CR>", { noremap = true, silent = true, desc = "Quickfix: Clear" })
map(
  "n",
  "<leader>ce",
  "<cmd>lua vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })<CR>",
  { noremap = true, silent = true, desc = "Quickfix: Only Errors" }
)
map(
  "n",
  "<leader>cd",
  "<cmd>lua vim.diagnostic.setqflist()<CR>",
  { noremap = true, silent = true, desc = "Quickfix: All Diagnostics" }
)
map("n", "<leader>cc", [[<cmd>lua ToggleQuickfix()<CR>]], { noremap = true, silent = true, desc = "Quickfix: Toggle" })
function ToggleQuickfix()
  local quickfix_open = false
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      quickfix_open = true
      break
    end
  end
  if quickfix_open then
    vim.cmd "cclose"
  else
    vim.cmd "copen"
  end
end

-- hunks
map("n", "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<CR>", { desc = "Preview hunk" })
map("n", "<leader>ga", "<cmd>lua require('gitsigns').stage_hunk()<CR>", { desc = "Stage hunk" })
map("n", "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", { desc = "Undo stage hunk" })
map("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<CR>", { desc = "Reset hunk" })
map("n", "]g", "<cmd>lua require('gitsigns').next_hunk()<CR>", { desc = "Next Hunk" })
map("n", "[g", "<cmd>lua require('gitsigns').prev_hunk()<CR>", { desc = "Prev Hunk" })
map("n", "<leader>gA", "<cmd>DiffviewOpen<CR>", { desc = "Stage hunk" })
map("n", "<leader>gf", "<cmd>Git add %<CR>", { desc = "Add file" })
map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Git Neogit" })

-- Buffers
nomap("n", "<leader>x")
nomap("n", "<leader>b")
map("n", "<leader>bo", ":%bd|e#<CR>", { noremap = true, silent = true, desc = "Close Other Buffers" })
map("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true, desc = "Close Buffer" })
map("n", "<leader>bl", "<cmd>Telescope buffers<CR>", { desc = "List Buffers" })
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous Buffer" })

-- Override
-- i don't think we're using this, we're mostly on <l>tt
map("n", "gR", "<cmd>Trouble lsp_references<CR>", { desc = "Find references using Trouble" })

vim.keymap.set("n", "<C-j>", "5j", { noremap = true, desc = "Jump 5 lines down" })
vim.keymap.set("n", "<C-k>", "5k", { noremap = true, desc = "Jump 5 lines up" })
vim.keymap.set(
  "n",
  "<C-h>",
  "<cmd>lua require('barbecue.ui').navigate(-2)<CR>",
  { noremap = true, desc = "Eat a Piece of your BBQ" }
)

-- remove terminal mappings
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap("n", "<M-i>")
nomap("n", "<M-v>")
nomap("n", "<M-h>")

map(
  "n",
  "<leader>st",
  ':lua require("custom.swap_test_file").swap_source_test()<CR>',
  { noremap = true, silent = true }
)
map(
  "n",
  "<leader>si",
  ':lua require("custom.swap_index_file").swap_source_index()<CR>',
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
vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Add mark to harpoon" })
vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "list harpoons" })
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "prev harpoon" })
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "next harpoon" })
vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, {desc ="select harpoon 1"})
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, {desc ="select harpoon 2"})
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, {desc ="select harpoon 3"})
vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, {desc ="select harpoon 4"})
-- stylua: ignore end

-- i gave up trying to find why c-space doesn't resolve to cmp complete
vim.keymap.set("i", "<C-n>", function()
  require("cmp").mapping.complete()()
end, { noremap = true, silent = true })

map("n", "<leader>rm", "<cmd>make<CR>", { desc = "run make" })

-- not sure where to add this
require("telescope").load_extension "file_browser"

function Set_makeprg(script_path)
  local config_path = vim.fn.stdpath "config"
  local full_path = config_path .. "/compile-scripts/" .. script_path
  if vim.fn.filereadable(full_path) == 1 then
    vim.o.makeprg = full_path
    print("makeprg set to: " .. full_path)
  else
    print("Error: Script not found at " .. full_path)
  end
end
