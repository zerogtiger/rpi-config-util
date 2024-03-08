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
vim.opt.conceallevel=2

-- %%%%% remap.lua %%%%%
vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

-- Keeps cursor in center during half-page scrolling
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- :noh
vim.keymap.set("n", "<leader>hl", "<cmd>noh<CR>")

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

    -- Floating termina via FRerm
    { 'numToStr/FTerm.nvim' },

    -- Git related
    { 'tpope/vim-fugitive' },
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
    -- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

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

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

require 'FTerm'.setup({
    border = 'double',
})

vim.api.nvim_create_user_command('FTermOpen', function()
    require('FTerm').open()
    vim.cmd.stopinsert()
end, { bang = true })
vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true })
vim.api.nvim_create_user_command('FTermExit', require('FTerm').exit, { bang = true })
vim.api.nvim_create_user_command('FTermToggle', function()
    require('FTerm').toggle()
    vim.cmd.stopinsert()
end, { bang = true })

vim.keymap.set('n', '<leader>t', vim.cmd.FTermToggle, { desc = '[F]loat terminal [T]oggle' })

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

-- -- %%%%% CODE %%%%%%
-- -- Author: Tiger Ding
-- -- Last updated: 2023/07/27
--
-- -- Writing code related infrastructure
--
-- -- Absolute file path
-- local target_file_path = vim.fn.expand('%:p')
-- local target_file_window_size = 60
-- local target_file_window_location = 2 -- 1: north; 2: east; 3: south; 4: west; 5: float
-- local locations = { 'North', 'East', 'South', 'West', 'Float' }
-- local location_cmd = { 'K', 'L', 'J', 'H', '' }
-- local location_split_cmd = { 'v', '', 'v', '', '' }
-- local resize_cmd = { '', 'vertical', '', 'vertical', '' }
--
-- local fterm = require('FTerm')
--
-- local targetfile_leader = [[<leader>\]]
--
-- -- Markings:
-- -- %fp: full file path
-- -- %fen: full file path without file extension
-- -- %fben: full file path without file extension with build directory
-- -- %fdb: full file path without file name or extension with build directory
-- -- %fn: file name (without extension)
-- local supported_languages = {
--     ['.cpp'] = {
--         name = 'C++',
--         ext = '.cpp',
--         compile_cmd = 'g++ -g -Wshadow -Wall -Wextra --std=c++17 %fp -o %fben',
--         execute_cmd = '%fben',
--         debug_cmd = nil,
--         debut_window_cmd = nil,
--         -- debug_cmd = 'gdb -tui %fben',
--         -- debut_window_cmd = 'tabe | set nowrap | startinsert | term ',
--     },
--     ['.c'] = {
--         name = 'C',
--         ext = '.c',
--         compile_cmd = 'gcc -g -Wshadow -Wall -Wextra -std=c99 %fp -o %fben',
--         execute_cmd = '%fben',
--         debug_cmd = nil,
--         debut_window_cmd = nil,
--         -- debug_cmd = 'gdb -tui %fben',
--         -- debut_window_cmd = 'tabe | set nowrap | startinsert | term ',
--     },
--     ['.rs'] = {
--         name = 'Rust',
--         ext = '.rs',
--         compile_cmd = 'rustc %fp',
--         execute_cmd = '%fen',
--         debug_cmd = nil,
--         debut_window_cmd = nil,
--         -- debug_cmd = 'gdb -tui %fben',
--         -- debut_window_cmd = 'tabe | set nowrap | startinsert | term ',
--     },
--     ['.java'] = {
--         name = 'Java',
--         ext = '.java',
--         compile_cmd = 'javac -d %fdb %fp',
--         execute_cmd = 'java -cp %fdb %fp',
--         debug_cmd = nil,
--         debut_window_cmd = nil,
--     },
--     ['.js'] = {
--         name = 'Javascript',
--         ext = '.js',
--         compile_cmd = nil,
--         execute_cmd = 'node %fp',
--         debug_cmd = nil,
--         debut_window_cmd = nil,
--     },
-- }
--
-- -- Keymappings
-- vim.keymap.set('n', targetfile_leader .. 'ps', vim.cmd.TargetFilePath, { desc = 'target file [P]ath [S]how' })
-- vim.keymap.set('n', targetfile_leader .. 'pr', vim.cmd.TargetFilePathReset, { desc = 'target file [P]ath [R]eset' })
-- vim.keymap.set('n', targetfile_leader .. "pc", vim.cmd.TargetFilePathCustom, { desc = 'target file [P]ath [C]ustom' })
-- vim.keymap.set('n', targetfile_leader .. "e", vim.cmd.TargetFileExecute, { desc = '[E]xecute target file' })
-- vim.keymap.set('n', targetfile_leader .. "c", vim.cmd.TargetFileCompile, { desc = '[C]ompile target file' })
-- vim.keymap.set('n', targetfile_leader .. "<space>", vim.cmd.TargetFileCompileExecute,
--     { desc = 'compiles & executes target file' })
-- vim.keymap.set('n', targetfile_leader .. "d", vim.cmd.TargetFileDebug, { desc = '[D]ebugs target file' })
-- vim.keymap.set('n', targetfile_leader .. "ws", vim.cmd.TargetFileWindow, { desc = 'target file [W]indow preview [S]how' })
-- vim.keymap.set('n', targetfile_leader .. "wr", vim.cmd.TargetFileWindowReset, { desc = 'target file [W]indow [R]eset' })
-- vim.keymap.set('n', targetfile_leader .. "ss", vim.cmd.TargetFileWindowSize,
--     { desc = 'target file window [S]ize [S]how' })
-- vim.keymap.set('n', targetfile_leader .. "sr", vim.cmd.TargetFileWindowSizeReset,
--     { desc = 'target file window [S]ize [R]eset' })
-- vim.keymap.set('n', targetfile_leader .. "sc", vim.cmd.TargetFileWindowSizeCustom,
--     { desc = 'target file window [S]ize [C]ustom' })
-- vim.keymap.set('n', targetfile_leader .. "ls", vim.cmd.TargetFileWindowLocation,
--     { desc = 'target file window [L]ocation [S]how' })
-- vim.keymap.set('n', targetfile_leader .. "lr", vim.cmd.TargetFileWindowLocationReset,
--     { desc = 'target file window [L]ocation [R]eset' })
-- vim.keymap.set('n', targetfile_leader .. "lc", vim.cmd.TargetFileWindowLocationCustom,
--     { desc = 'target file window [L]ocation [C]ustom' })
--
-- -- vim.keymap.set('i', '<C-e>', '<C-o>A', { desc = 'Puts cursor at the end of the line without exiting insert mode' })
-- -- vim.keymap.set('n', '<leader>e', function() vim.cmd [[NERDTreeToggle]] end, { desc = 'Open file explorer (NERDTree)' })
--
-- -- print(expand_to_cmd(compile_cmd['.cpp']))
--
-- -- User commands
-- vim.api.nvim_create_user_command("TargetFilePath", function()
--     print(target_file_path)
-- end, {})
--
-- vim.api.nvim_create_user_command("TargetFilePathReset", function()
--     file_path_reset()
--     print(target_file_path)
-- end, {})
--
-- vim.api.nvim_create_user_command("TargetFilePathCustom", function()
--     file_path_reset(vim.fn.input("Absolute target file path > "))
-- end, {})
--
-- vim.api.nvim_create_user_command("TargetFileExecute", function()
--     local filetype = supported_languages[file_ext(target_file_path)]
--     if filetype == nil then
--         print 'No assigned executable for current file type'
--         return
--     elseif filetype.execute_cmd ~= nil then
--         if target_file_window_location <= 4 then
--             vim.cmd(window_open_cmd().open_cmd .. 'term ' .. expand_to_cmd(filetype.execute_cmd))
--         else
--             fterm.run(expand_to_cmd(filetype.execute_cmd))
--             vim.cmd('stopinsert')
--         end
--     end
-- end, {})
--
-- vim.api.nvim_create_user_command("TargetFileCompile", function()
--     local filetype = supported_languages[file_ext(target_file_path)]
--     if filetype == nil then
--         print 'No assigned compiler for current file type'
--         return
--     elseif filetype.compile_cmd ~= nil then
--         if target_file_window_location <= 4 then
--             vim.cmd(window_open_cmd().open_cmd .. 'term ' .. expand_to_cmd(filetype.compile_cmd))
--         else
--             fterm.run(expand_to_cmd(filetype.compile_cmd))
--             vim.cmd('stopinsert')
--         end
--     end
-- end, {})
--
-- vim.api.nvim_create_user_command("TargetFileCompileExecute", function()
--     local window_cmds = window_open_cmd()
--     local filetype = supported_languages[file_ext(target_file_path)]
--     if filetype == nil then
--         print('No assigned compiler / executable for current file type')
--         return
--     elseif filetype.compile_cmd ~= nil then
--         if target_file_window_location <= 4 then
--             vim.cmd(window_cmds.open_cmd .. 'term ' .. expand_to_cmd(filetype.compile_cmd))
--             local exit_code = vim.fn.jobwait({ vim.b.terminal_job_id }, -1)[1]
--             if (exit_code == 0) then
--                 vim.cmd(window_cmds.split_cmd .. 'term ' .. expand_to_cmd(filetype.execute_cmd))
--             end
--         else
--             fterm.run(expand_to_cmd(filetype.compile_cmd))
--             fterm.run(expand_to_cmd(filetype.execute_cmd))
--             vim.cmd('stopinsert')
--         end
--     elseif filetype.execute_cmd then
--         if target_file_window_location <= 4 then
--             vim.cmd(window_open_cmd().open_cmd .. 'term ' .. expand_to_cmd(filetype.execute_cmd))
--         else
--             fterm.run(expand_to_cmd(filetype.execute_cmd))
--             vim.cmd('stopinsert')
--         end
--     end
-- end, {})
--
-- vim.api.nvim_create_user_command("TargetFileDebug", function()
--     local filetype = supported_languages[file_ext(target_file_path)]
--     if filetype == nil then
--         print 'No assigned debugger for current file type'
--     elseif filetype.debug_cmd ~= nil then
--         vim.cmd(filetype.debut_window_cmd .. expand_to_cmd(filetype.debug_cmd))
--     end
-- end, {})
--
--
-- -- Window
-- -- Shows a brief preview of window
-- vim.api.nvim_create_user_command("TargetFileWindow", function()
--     vim.cmd(window_preview_cmd())
-- end, {})
--
-- -- Resets to default window size and location
-- vim.api.nvim_create_user_command("TargetFileWindowReset", function()
--     window_reset()
--     vim.cmd(window_preview_cmd())
-- end, {})
--
-- -- Displays windows size
-- vim.api.nvim_create_user_command("TargetFileWindowSize", function()
--     print(target_file_window_size)
-- end, {})
--
-- -- Resets default window size
-- vim.api.nvim_create_user_command("TargetFileWindowSizeReset", function()
--     window_size_reset()
--     vim.cmd(window_preview_cmd())
-- end, {})
--
-- -- Sets a custom window size from uesr
-- vim.api.nvim_create_user_command("TargetFileWindowSizeCustom", function()
--     window_size_reset(vim.fn.input("Window size > "))
--     vim.cmd(window_preview_cmd())
-- end, {})
--
-- -- Displays windows location
-- vim.api.nvim_create_user_command("TargetFileWindowLocation", function()
--     print(locations[target_file_window_location])
-- end, {})
--
-- -- Resets default window location
-- vim.api.nvim_create_user_command("TargetFileWindowLocationReset", function()
--     window_location_reset()
--     vim.cmd(window_preview_cmd())
-- end, {})
--
-- -- Sets a custom window location from user
-- vim.api.nvim_create_user_command("TargetFileWindowLocationCustom", function()
--     window_location_reset(vim.fn.input("\n1: North\n2: East\n3: South\n4: West\n5: Float\nWindow location > "))
--     vim.cmd(window_preview_cmd())
-- end, {})
--
-- -- Window
-- -- Generates command to open the specified window
-- function window_open_cmd()
--     if target_file_window_location <= 4 then
--         local open_cmd = 'new | wincmd ' ..
--             location_cmd[target_file_window_location] ..
--             ' | ' ..
--             resize_cmd[target_file_window_location] ..
--             ' resize ' ..
--             target_file_window_size ..
--             ' | set nowrap | redraw | '
--         local split_cmd = location_split_cmd[target_file_window_location] .. 'new | set nowrap | redraw | '
--         return { open_cmd = open_cmd, split_cmd = split_cmd }
--     else
--         return 'FTermOpen \n'
--     end
-- end
--
-- -- Generates command to preview the window
-- function window_preview_cmd()
--     local window_cmds = window_open_cmd()
--     if target_file_window_location <= 4 then
--         return (window_cmds.open_cmd .. window_cmds.split_cmd .. 'sleep 500m | bd! | bd!')
--     else
--         return (window_cmds .. 'redraw \n sleep 500m \n FTermClose')
--     end
-- end
--
-- function window_reset()
--     target_file_window_size = 60
--     target_file_window_location = 2
-- end
--
-- function window_size_reset(window_size)
--     window_size = tonumber(window_size)
--     target_file_window_size = 20
--     if (target_file_window_location % 2 == 0) then
--         target_file_window_size = 60
--     end
--     target_file_window_size = window_size or target_file_window_size
-- end
--
-- function window_location_reset(window_location)
--     window_location = tonumber(window_location)
--     local old_location = target_file_window_location
--     target_file_window_location = window_location or target_file_window_location
--     if old_location % 2 ~= target_file_window_location % 2 then
--         window_size_reset()
--     end
-- end
--
-- -- Target file related
-- function file_path_reset(file_path)
--     if file_path == '' or file_path == nil then
--         file_path = vim.fn.expand('%:p')
--     end
--     target_file_path = file_path
--     print(target_file_path)
-- end
--
-- function file_ext(flnm)
--     return flnm:match("(%.%w+)$") or ""
-- end
--
-- function file_name(flnm)
--     return flnm:sub(string.find(flnm, "/[^/]*$") + 1, #flnm - #file_ext(flnm))
-- end
--
-- function expand_to_cmd(unexpanded_cmd)
--     local expanded_cmd = string.gsub(unexpanded_cmd, "%%fp", target_file_path)
--     expanded_cmd = string.gsub(expanded_cmd, "%%fen",
--         target_file_path:sub(0, #target_file_path - #file_ext(target_file_path)))
--     expanded_cmd = string.gsub(expanded_cmd, "%%fben",
--         target_file_path:sub(0, #target_file_path - #file_ext(target_file_path) - #file_name(target_file_path)) ..
--         '.build/' .. file_name(target_file_path))
--     expanded_cmd = string.gsub(expanded_cmd, "%%fdb",
--         target_file_path:sub(0, #target_file_path - #file_ext(target_file_path) - #file_name(target_file_path)) ..
--         '.build/')
--     expanded_cmd = string.gsub(expanded_cmd, "%%fn", file_name(target_file_path))
--     return expanded_cmd
-- end


