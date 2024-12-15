return {

  -- formatter
  {
    "stevearc/conform.nvim",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        width = 50,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  { "tpope/vim-surround", lazy = false },
  {
    "folke/trouble.nvim",
    opts = {
      win = {
        size = {
          width = 100,
          height = 15,
        },
      },
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tT",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>ts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>tr",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>tl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>tq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "tailwindcss-language-server",
        "eslint_d",
        "prettierd",
      },
    },
  },

  {
    "tpope/vim-fugitive",
    lazy = false,
  },

  {
    "github/copilot.vim",
    lazy = false,
  },

  {
    "nvim-treesitter/playground",
    cmd = "TSPlaygroundToggle",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "vz",
          node_incremental = "z",
          scope_incremental = "va",
          node_decremental = "Z",
        },
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer", -- Select around a function
            ["if"] = "@function.inner", -- Select inside a function
            ["ac"] = "@class.outer", -- Select around a class
            ["ic"] = "@class.inner", -- Select inside a class
            ["ab"] = "@block.outer", -- Select around braces
            ["ib"] = "@block.inner", -- Select inside braces
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Track jumps in the jump list
          goto_next_start = {
            ["]f"] = "@function.outer", -- Jump to next function
            ["]c"] = "@class.outer", -- Jump to next class
          },
          goto_previous_start = {
            ["[f"] = "@function.outer", -- Jump to previous function
            ["[c"] = "@class.outer", -- Jump to previous class
          },
          goto_next_end = {
            ["]F"] = "@function.outer", -- Jump to end of next function
            ["]C"] = "@class.outer", -- Jump to end of next class
          },
          goto_previous_end = {
            ["[F"] = "@function.outer", -- Jump to end of previous function
            ["[C"] = "@class.outer", -- Jump to end of previous class
          },
        },
      },
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
      },
    },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
  },

  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },
    opts = {}, -- your configuration
    lazy = false,
  },

  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      TODO = { icon = " ", color = "info", alt = { "@todo" } },
    },
  },

  -- use flash for now
  -- {
  --   "smoka7/hop.nvim",
  --   lazy = false,
  --   version = "*",
  --   opts = {
  --     keys = "asdfghjkl;weruioxcvnm,",
  --   },
  -- },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter({ jump = {pos = "start" }}) end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- themes
  { "bkegley/gloombuddy" },
  { "vigoux/oak" },
  { "mhartington/oceanic-next" },
  { "bluz71/vim-moonfly-colors" },
  { "sainnhe/sonokai" },
}
