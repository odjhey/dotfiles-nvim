# Neovim Configuration Cleanup Research & Recommendations

**Date:** 2025-12-16  
**Config Path:** `/Users/odz/mystow/nvim/.config/nvim`  
**Objective:** Apply 80-20 principle - keep what you use 80% of the time, remove/refactor the rest

---

## 📊 Current Structure Analysis

### File Organization

```
.
├── init.lua                    # Entry point (41 lines)
├── lazy-lock.json             # Plugin versions
├── .stylua.toml               # Lua formatter config
├── LICENSE
├── after/
│   └── ftplugin/
│       └── gdscript.lua       # Godot-specific LSP (8 lines)
├── compile-scripts/
│   ├── check-pnpm.sh
│   └── check-yarn-build.sh
└── lua/
    ├── autocmds.lua           # 1 autocmd (16 lines)
    ├── chadrc.lua             # NvChad theme config (26 lines)
    ├── mappings.lua           # 579 LINES - NEEDS CLEANUP
    ├── options.lua            # 43 lines
    ├── configs/
    │   ├── conform.lua        # Formatter config (46 lines)
    │   ├── lazy.lua           # Plugin manager config (47 lines)
    │   ├── lspconfig.lua      # LSP setup (125 lines)
    │   └── telescope.lua      # Telescope config (43 lines)
    ├── custom/
    │   ├── swap_index_file.lua   # Utility (19 lines)
    │   ├── swap_test_file.lua    # Utility (24 lines)
    │   ├── test1.lua             # ⚠️ JUNK FILE (2 lines)
    │   └── test2.lua             # ⚠️ JUNK FILE (2 lines)
    └── plugins/
        └── init.lua           # 628 LINES - NEEDS REVIEW
```

---

## 🚨 Critical Issues Found

### 1. **Mappings.lua is MASSIVE (579 lines)**

This is your biggest problem. It contains:

- Telescope configuration logic (lines 33-112)
- Quickfix functions (lines 156-169)
- File history tracking system (lines 345-402)
- Git diff comparison tool (lines 405-472)
- Text object recording system (lines 501-551)
- Harpoon setup
- Multiple inline function definitions

**Problem:** Mixing configuration, utilities, and mappings in one file makes it unmaintainable.

### 2. **Test Files in Production**

- [`lua/custom/test1.lua`](lua/custom/test1.lua:1) - Contains "hello world"
- [`lua/custom/test2.lua`](lua/custom/test2.lua:1) - Contains "hello world"

**Action:** DELETE immediately.

### 3. **Commented Code Everywhere**

- [`lua/options.lua`](lua/options.lua:19-30) - 12 lines of commented navic config
- [`lua/plugins/init.lua`](lua/plugins/init.lua:45-53) - Commented vim-surround
- [`lua/plugins/init.lua`](lua/plugins/init.lua:310-318) - Commented hop.nvim
- [`lua/plugins/init.lua`](lua/plugins/init.lua:420-458) - Multiple commented themes
- [`lua/configs/lspconfig.lua`](lua/configs/lspconfig.lua:56-77) - Commented inlay hints
- [`lua/configs/lspconfig.lua`](lua/configs/lspconfig.lua:81-125) - 44 lines of commented code

**Problem:** Makes files harder to read and maintain.

### 4. **Duplicate/Redundant Mappings**

- [`lua/mappings.lua`](lua/mappings.lua:244-245) - `<leader>tx` mapped twice
- [`lua/mappings.lua`](lua/mappings.lua:121) and line 125 - `<leader>fr` mapped twice

### 5. **Unused/Rarely Used Plugins** (Based on code analysis)

- **nvim-tree** - You have Oil.nvim which is likely your primary file explorer
- **vim-dispatch** - Only loaded on command, no mappings found
- **nvim-treesitter/playground** - Debug tool, rarely needed
- **Harpoon** - Configured but you noted "sometimes we use it when reading code, but mostly rely on <leader>fc"
- **marks.nvim** - No mappings configured
- **nvim-scrollbar** - Visual enhancement, not workflow-critical
- **nvim-hlslens** - Search enhancement, no custom config
- **smear-cursor** - Visual effect only
- **nvim-cursorline** - Visual enhancement
- **markdown-preview** - Only if you work with markdown frequently

### 6. **Compile Scripts**

- [`compile-scripts/check-pnpm.sh`](compile-scripts/check-pnpm.sh:1)
- [`compile-scripts/check-yarn-build.sh`](compile-scripts/check-yarn-build.sh:1)

**Question:** Are these actively used? Referenced in [`lua/mappings.lua`](lua/mappings.lua:300-309) via `Set_makeprg()` function.

---

## 📋 80-20 Analysis: What You Actually Use

### Core Workflow (80% usage)

Based on mapping frequency and configuration depth:

1. **Telescope** - Heavily configured, multiple custom functions
2. **LSP** (ts_ls, eslint, biome) - Core development
3. **Git Integration** (fugitive, gitsigns, diffview, neogit)
4. **Treesitter** - Text objects, syntax
5. **Flash.nvim** - Navigation (replaced hop)
6. **Conform** - Auto-formatting
7. **Trouble** - Diagnostics
8. **CamelCaseMotion** - Text navigation
9. **Copilot** - AI assistance
10. **nvim-surround** - Text manipulation
11. **Quickfix** - Heavily customized with many mappings
12. **File swapping utilities** - Custom swap_test_file, swap_index_file

### Moderate Usage (15% usage)

- **which-key** - Using custom fork
- **todo-comments** - Configured but minimal mappings
- **barbecue/navic** - Breadcrumbs
- **Oil.nvim** - File management
- **Twilight** - Occasional dimming

### Rarely Used (5% usage)

- **Harpoon** - You admitted mostly using git status instead
- **vim-matchup** - Loaded but no custom config
- **tailwind-tools** - Only if working with Tailwind
- **nvim-ts-autotag** - Auto-close tags
- **quicker.nvim** - Editable quickfix
- **snacks.nvim** - Multiple features, unclear usage
- **Visual enhancements** - scrollbar, hlslens, smear-cursor, cursorline

---

## 🎯 Recommended Actions

### IMMEDIATE (Delete/Clean)

1. **DELETE test files:**

   ```bash
   rm lua/custom/test1.lua
   rm lua/custom/test2.lua
   ```

2. **Remove ALL commented code blocks:**

   - Clean up [`lua/options.lua`](lua/options.lua:19-30)
   - Clean up [`lua/plugins/init.lua`](lua/plugins/init.lua:45-53) (vim-surround)
   - Clean up [`lua/plugins/init.lua`](lua/plugins/init.lua:310-318) (hop)
   - Clean up [`lua/plugins/init.lua`](lua/plugins/init.lua:420-458) (themes)
   - Clean up [`lua/configs/lspconfig.lua`](lua/configs/lspconfig.lua:56-125)
   - Clean up [`lua/configs/conform.lua`](lua/configs/conform.lua:24-28)

3. **Fix duplicate mappings:**
   - Remove duplicate [`lua/mappings.lua`](lua/mappings.lua:245)
   - Remove duplicate [`lua/mappings.lua`](lua/mappings.lua:125)

### HIGH PRIORITY (Refactor)

4. **Split mappings.lua into modules:**

   ```
   lua/mappings/
   ├── init.lua              # Load all mapping modules
   ├── core.lua              # Basic vim mappings
   ├── telescope.lua         # All telescope config + mappings
   ├── git.lua               # Git-related mappings
   ├── quickfix.lua          # Quickfix functions + mappings
   ├── buffers.lua           # Buffer management
   ├── lsp.lua               # LSP mappings
   └── custom.lua            # Custom utilities (file history, etc)
   ```

5. **Move utility functions to proper modules:**

   - File history tracker (lines 345-402) → `lua/utils/file_history.lua`
   - Git branch diff (lines 405-472) → `lua/utils/git_diff.lua`
   - Text object repeater (lines 501-551) → `lua/utils/text_objects.lua`
   - Quickfix toggle (lines 156-169) → `lua/utils/quickfix.lua`

6. **Consolidate custom utilities:**
   ```
   lua/utils/
   ├── file_swapper.lua      # Merge swap_test_file + swap_index_file
   ├── file_history.lua      # From mappings.lua
   ├── git_diff.lua          # From mappings.lua
   ├── text_objects.lua      # From mappings.lua
   └── quickfix.lua          # From mappings.lua
   ```

### MEDIUM PRIORITY (Evaluate & Remove)

7. **Remove unused plugins** (if confirmed):

   - **nvim-tree** - You have Oil.nvim
   - **vim-dispatch** - No active usage found
   - **playground** - Debug tool
   - **marks.nvim** - No mappings
   - **nvim-scrollbar** - Visual only
   - **nvim-hlslens** - No custom config
   - **smear-cursor** - Visual effect
   - **nvim-cursorline** - Visual enhancement
   - **Harpoon** - You prefer `<leader>fc` for git files

8. **Conditional plugins** (keep only if actively used):
   - **tailwind-tools** - Only for Tailwind projects
   - **markdown-preview** - Only if you write markdown
   - **gdscript** ftplugin - Only for Godot development

### LOW PRIORITY (Optimize)

9. **Lazy loading improvements:**

   - Many plugins set `lazy = false` - review if they need immediate loading
   - Example: [`lua/plugins/init.lua`](lua/plugins/init.lua:6) plenary could be lazy
   - Example: [`lua/plugins/init.lua`](lua/plugins/init.lua:12) conform could be on event

10. **Theme cleanup:**
    - You're using `ayu-dark` - remove all commented theme plugins
    - Keep gruvbox only if you switch between light/dark

---

## 📐 Proposed New Structure

```
.
├── init.lua                    # Entry point (keep as-is)
├── lazy-lock.json
├── .stylua.toml
├── after/
│   └── ftplugin/
│       └── gdscript.lua       # Keep if using Godot
├── lua/
│   ├── core/
│   │   ├── autocmds.lua       # Renamed from autocmds.lua
│   │   ├── options.lua        # Renamed from options.lua
│   │   └── lazy.lua           # Renamed from configs/lazy.lua
│   ├── configs/
│   │   ├── conform.lua        # Keep
│   │   ├── lspconfig.lua      # Keep (cleaned)
│   │   └── telescope.lua      # Keep
│   ├── mappings/
│   │   ├── init.lua           # Load all mappings
│   │   ├── core.lua           # Basic vim mappings
│   │   ├── telescope.lua      # Telescope-specific
│   │   ├── git.lua            # Git mappings
│   │   ├── quickfix.lua       # Quickfix mappings
│   │   ├── buffers.lua        # Buffer management
│   │   ├── lsp.lua            # LSP mappings
│   │   └── custom.lua         # Misc custom mappings
│   ├── utils/
│   │   ├── file_swapper.lua   # Merged swap utilities
│   │   ├── file_history.lua   # File navigation history
│   │   ├── git_diff.lua       # Git branch comparison
│   │   ├── text_objects.lua   # Text object repeater
│   │   └── quickfix.lua       # Quickfix utilities
│   └── plugins/
│       └── init.lua           # Cleaned plugin list
└── compile-scripts/           # Keep if actively used
    ├── check-pnpm.sh
    └── check-yarn-build.sh
```

---

## 🔍 Questions to Answer

Before proceeding with cleanup, answer these:

1. **Do you use nvim-tree or Oil.nvim?** (Keep only one)
2. **Do you actively use Harpoon?** (You mentioned preferring git status)
3. **Do you work with Godot/GDScript?** (Keep gdscript.lua?)
4. **Do you use the compile-scripts?** (Referenced in makeprg function)
5. **Do you write markdown frequently?** (Keep markdown-preview?)
6. **Do you work with Tailwind CSS?** (Keep tailwind-tools?)
7. **Do you switch between light/dark themes?** (Keep gruvbox?)
8. **Do you use the visual enhancements?** (scrollbar, hlslens, smear-cursor, cursorline)

---

## 📊 Estimated Impact

### Current State

- **Total lines:** ~1,600+ lines of Lua code
- **Plugins:** 50+ plugins
- **Mappings file:** 579 lines (unmaintainable)
- **Commented code:** ~100+ lines

### After Cleanup (Estimated)

- **Total lines:** ~1,200 lines (25% reduction)
- **Plugins:** 35-40 plugins (20-30% reduction)
- **Largest file:** <200 lines (65% reduction)
- **Commented code:** 0 lines (100% removal)
- **Maintainability:** Significantly improved

---

## 🚀 Implementation Plan

### Phase 1: Immediate Cleanup (30 minutes)

1. Delete test files
2. Remove all commented code
3. Fix duplicate mappings
4. Remove obviously unused plugins

### Phase 2: Refactor Mappings (2-3 hours)

1. Create `lua/mappings/` directory structure
2. Split mappings.lua into logical modules
3. Move utility functions to `lua/utils/`
4. Update init.lua to load new structure

### Phase 3: Plugin Optimization (1 hour)

1. Review and remove unused plugins
2. Improve lazy loading
3. Clean up plugin configurations

### Phase 4: Testing (1 hour)

1. Test all core workflows
2. Verify mappings work correctly
3. Check LSP functionality
4. Ensure formatters work

**Total estimated time:** 4-5 hours

---

## 💡 Best Practices Going Forward

1. **One concern per file** - Don't mix mappings with utility functions
2. **No commented code** - Delete or move to a separate "archive" branch
3. **Document decisions** - Add comments explaining WHY, not WHAT
4. **Regular audits** - Review plugins quarterly
5. **Test before adding** - Try plugins in a separate config first
6. **Lazy load everything possible** - Faster startup times
7. **Use descriptive names** - `telescope.lua` not `t.lua`
8. **Keep utilities separate** - Don't embed functions in mapping files

---

## 📝 Notes

- Your config is based on **NvChad v2.5** - maintain compatibility
- You're using a **custom which-key fork** - document why
- Heavy **Telescope customization** - this is clearly core to your workflow
- Strong **Git integration** - multiple plugins working together
- **TypeScript/JavaScript focus** - LSP and formatters configured for this

---

## ✅ Success Criteria

After cleanup, you should have:

- ✅ No file over 200 lines
- ✅ Zero commented code blocks
- ✅ Clear separation of concerns
- ✅ Only plugins you use weekly
- ✅ Fast startup time (<100ms)
- ✅ Easy to find any configuration
- ✅ No duplicate mappings
- ✅ No test/junk files

---

**Next Steps:** Review this document, answer the questions, and let me know which phase you'd like to start with!
