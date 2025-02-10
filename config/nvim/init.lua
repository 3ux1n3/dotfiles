-- INIT.LUA CONFIG FILE

-- Plugins setup
require('packer').startup(function()
    -- Package manager itself
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'ellisonleao/gruvbox.nvim'

    -- LSP, autocompletion, and snippets
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'

    -- nvim-tree plugin (with dependencies)
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    -- Tmux navigator
    use 'christoomey/vim-tmux-navigator'
end)

-- Theme setup
require('gruvbox').setup({
    contrast = "hard",                   -- Options: "soft", "medium", "hard"
    overrides = {                        -- Custom highlight overrides (optional)
        SignColumn = { bg = "#1d2021" }, -- Example override
    },
})

-- Set background mode and apply the theme
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- LSP setup
require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { "gopls", "pyright", "ts_ls", "dockerls" },
    automatic_installation = true,
})

local lspconfig = require('lspconfig')
lspconfig.gopls.setup({})
lspconfig.pyright.setup({})
lspconfig.ts_ls.setup({})
lspconfig.dockerls.setup({})

-- Autocompletion setup with updated key mappings
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)  -- You can replace this with LuaSnip or another snippet plugin
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Optional, may conflict with some terminals
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),  -- Confirm with Enter (without auto-selecting)
        ['<Tab>'] = cmp.mapping.select_next_item(),          -- Navigate suggestions with Tab
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),        -- Navigate backwards with Shift + Tab
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
    }),
})

-- Tmux navigator setup
vim.g.tmux_navigator_no_mappings = 1

-- Setup nvim-tree with updated options
require('nvim-tree').setup({
    disable_netrw = true, -- Disable Neovim's built-in file explorer
    hijack_netrw = true,  -- Override netrw behavior
    update_focused_file = {
        enable = true,    -- Focus the file you're editing
        update_cwd = true,
    },
    view = {
        width = 30,             -- Set the width of the file tree
        side = "left",          -- Position it on the left side
    },
    renderer = {
        highlight_opened_files = "all", -- Highlight currently opened file
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
    git = {
        enable = true, -- Show git status in the file tree
    },
    diagnostics = {
        enable = true, -- Show diagnostics (like LSP errors) in the file tree
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
})

-- Custom keybindings for nvim-tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
