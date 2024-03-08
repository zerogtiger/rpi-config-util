-- %%%%% set.lua %%%%%
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Case insensitive search unless /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

-- vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- LaTeX
vim.g.tex_flavor = 'latex'

-- %%%%% remap.lua %%%%%
vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

-- Keeps cursor in center during half-page scrolling
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste but delete selected into void register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Delete but delete selected into void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Deals with line wrap stuff
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Allows change of word currently on for entire buffer
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Makes current file an executable
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- %%%%%% lazy.lua %%%%%
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

    -- File explorer via NvimTree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
    },

    -- Fuzzy finder via Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Undotree
    { 'mbbill/undotree' },

    -- Commenting code
    { 'numToStr/Comment.nvim' },

    -- Git related
    -- { 'tpope/vim-fugitive' },
    -- { 'tpope/vim-rhubarb' },
    { 'lewis6991/gitsigns.nvim' },

    -- Syntax highlighting via Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    -- Statusline via Lualine
    { 'nvim-lualine/lualine.nvim' },

    -- Indentation indicator
    { 'lukas-reineke/indent-blankline.nvim' },

    -- Colorschemes
    { 'morhetz/gruvbox',                name = 'gruvbox' },
    { 'lifepillar/vim-solarized8',        name = 'solarized8' },
    -- { 'nordtheme/vim',                  name = 'nordtheme' },
    -- { 'sainnhe/everforest',             name = 'everforest' },
    -- { 'NLKNguyen/papercolor-theme',     name = 'papercolor' },

    -- Games and other useless stuff
    -- { 'seandewar/nvimesweeper' },
})

-- %%%%% Plugin specific setups %%%%%

vim.cmd.colorscheme("solarized8_flat")

require('Comment').setup()

require('gitsigns').setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
}

require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
    }
}

vim.keymap.set('n', '<leader>fe', vim.cmd.NvimTreeToggle)

require("nvim-tree").setup {
    renderer = {
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
                modified = true,
            },
            glyphs = {
                default = "=",
                symlink = "%",
                bookmark = "@",
                modified = "*",
                folder = {
                    arrow_closed = ">",
                    arrow_open = "v",
                    default = "{}",
                    open = "{/",
                    empty = "[]",
                    empty_open = "[/",
                    symlink = "%",
                    symlink_open = "%",
                },
                git = {
                    unstaged = "x",
                    staged = "-/",
                    unmerged = "Y",
                    renamed = "-",
                    untracked = "#",
                    deleted = "~",
                    ignored = "o",
                },
            },
        },
    },
    diagnostics = {
        icons = {
            hint = "!)",
            info = "i)",
            warning = "!\\",
            error = "x)",
        },
    },
}

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Buffers' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>of', builtin.oldfiles, { desc = '[O]ld [F]iles' })
vim.keymap.set('n', '<leader>ht', builtin.help_tags, { desc = '[H]elp [T]ags' })
vim.keymap.set('n', '<leader>lg', builtin.live_grep, { desc = '[L]ive [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzy search in current buffer' })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = '[G]oto [R]eference' })
vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })
vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })

-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>gs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>cl', builtin.colorscheme, { desc = '[C]o[L]orscheme' })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'java', 'vim', 'lua', 'markdown', 'python', 'vimdoc', 'bash' },
    --
    -- 	-- Install parsers synchronously (only applied to `ensure_installed`)
    -- 	sync_install = false,
    --
    -- 	-- Automatically install missing parsers when entering buffer
    -- 	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    -- 	auto_install = false,
    --
    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "latex" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

}





