return {
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    lazy = false,
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
    "andymass/vim-matchup",
    lazy = false,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- use nvim-surround
  -- {
  --   "tpope/vim-surround",
  --   lazy = false,
  --   config = function()
  --     -- Visual Mode: Use S to surround the selection
  --     vim.api.nvim_set_keymap("x", "S", "<Plug>VSurround", { noremap = false, silent = true })
  --   end,
  -- },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {
      win = {
        size = {
          width = 100,
          height = 15,
        },
      },
      modes = {
        symbols_f = {
          desc = "document symbols",
          mode = "lsp_document_symbols",
          focus = false,
          win = { position = "right" },
          filter = {
            -- remove Package since luals uses it for control flow structures
            ["not"] = { ft = "lua", kind = "Package" },
            any = {
              -- all symbol kinds for help / markdown files
              ft = { "help", "markdown" },
              -- default set of symbol kinds
              kind = {
                "Function",
              },
            },
          },
        },
      },
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xf",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xss",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xsf",
        "<cmd>Trouble symbols_f toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xr",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xq",
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
        "eslint-lsp",
        "markdown-oxide",
        "biome",
        "json-lsp",
        "yaml-language-server",
      },
    },
  },

  -- both for git stuff, rhubarb is for github
  { "tpope/vim-fugitive", lazy = false },
  { "tpope/vim-rhubarb", lazy = false, dependencies = { "tpope/vim-fugitive" } },

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
        "tsx",
      },
      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
        disable = { "c", "ruby" }, -- optional, list of language that will be disabled
        -- [options]
      },
    },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        per_filetype = {
          ["html"] = {
            enable_close = true,
          },
        },
      }
    end,
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
    opts = {
      keywords = {
        TODO = { icon = " ", color = "info", alt = { "todo" } },
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      highlight = {
        pattern = [[(KEYWORDS)]], -- Match `@todo`, `todo`, and similar patterns
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[(KEYWORDS)]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
  },

  -- use fork, i_c-o is broken
  { "folke/which-key.nvim", enabled = false },
  {
    "odjhey/which-key.nvim",
    enabled = true,
    branch = "fix/broken_i_c_o_mark_others",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
      -- dofile(vim.g.base46_cache .. "whichkey")
      return {}
    end,
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
      {
        "S",
        mode = { "n", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "s",
        mode = { "n", "o" },
        function()
          require("flash").treesitter() -- { jump = {pos = "start" }} -- use o to go end and start { labels = "hjkluionm," }
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "bkad/camelcasemotion",
    lazy = false,
    config = function()
      vim.cmd "nmap <silent> <M-w> <Plug>CamelCaseMotion_w"
      vim.cmd "nmap <silent> <M-b> <Plug>CamelCaseMotion_b"
      vim.cmd "nmap <silent> <M-e> <Plug>CamelCaseMotion_e"
      vim.cmd "omap <silent> <M-w> <Plug>CamelCaseMotion_w"
      vim.cmd "omap <silent> <M-b> <Plug>CamelCaseMotion_b"
      vim.cmd "omap <silent> <M-e> <Plug>CamelCaseMotion_e"
      vim.cmd "xmap <silent> <M-w> <Plug>CamelCaseMotion_w"
      vim.cmd "xmap <silent> <M-b> <Plug>CamelCaseMotion_b"
      vim.cmd "xmap <silent> <M-e> <Plug>CamelCaseMotion_e"
    end,
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  {
    "nvim-telescope/telescope-frecency.nvim",
    lazy = false,
    -- install the latest stable version
    version = "*",
    opts = {
      matcher = "fuzzy",
    },
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "frecency"
    end,
  },

  {
    "sindrets/diffview.nvim",
    lazy = false,
    config = function()
      dofile(vim.g.base46_cache .. "diffview")
      require("diffview").setup()
    end,
  },

  -- disable, this breaks c-o insert mode
  { "windwp/nvim-autopairs", enabled = false },

  -- themes
  -- { "bkegley/gloombuddy" },
  -- { "vigoux/oak" },
  -- { "mhartington/oceanic-next" },
  -- { "bluz71/vim-moonfly-colors" },
  -- { "sainnhe/sonokai" },
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "NLKNguyen/papercolor-theme" },
  -- { "catppuccin/nvim", name = "catppuccin" },
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000, -- recommended if you use tairiki as your default theme
    config = function()
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd [[colorscheme ayu-dark]]
    end,
  },
  -- {
  --   "deparr/tairiki.nvim",
  --   lazy = false,
  --   priority = 1000, -- recommended if you use tairiki as your default theme
  --   branch = "v2",
  --   opts = {},
  --   config = function()
  --     vim.o.background = "dark" -- or "light" for light mode
  --     vim.cmd [[colorscheme retrobox]]
  --   end,
  -- },

  -- breadcrumbs
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" }, -- Ensure LSP is configured
  },
  {
    "SmiteshP/nvim-navbuddy",
    cmd = { "Navbuddy" }, -- Load only when :Navbuddy is invoked
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      window = {
        size = "60%",
      },
      lsp = { auto_attach = true },
    },
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    lazy = false,
    config = function()
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
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
    cmd = "Neogit",
  },

  -- we use this to have an editable quickfixlist, use :w after edit
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "configs.telescope"
    end,
  },
}
