return {
    {
        "kdheepak/lazygit.nvim",
        lazy = false,
        keys = {
            { "<leader>git", "<Cmd>:LazyGit<CR>", desc = "Open LazyGit" }
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        event = 'BufEnter',
        opts = {
            signs                        = {
                add          = { text = '│' },
                change       = { text = '│' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir                 = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked          = true,
            current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts      = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority                = 6,
            update_debounce              = 100,
            status_formatter             = nil,   -- Use default
            max_file_length              = 40000, -- Disable if file is longer than this (in lines)
            preview_config               = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            on_attach                    = function()
                local gs = package.loaded.gitsigns
                -- Actions
                -- vim.keymap.set({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', { desc="Git [h]unk [s]tage"})
                -- vim.keymap.set({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', { desc="Git [h]unk [r]eset"})
                -- vim.keymap.set('n', '<leader>ghS', gs.stage_buffer, { desc="Git [h]unk [S]tage"})
                -- vim.keymap.set('n', '<leader>ghu', gs.undo_stage_hunk, { desc="Git [h]unk [U]ndo"})
                -- vim.keymap.set('n', '<leader>ghR', gs.reset_buffer, { desc="Git [h]unk [R]eset buffer"})
                vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { desc = "Git [p]review" })
                vim.keymap.set('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = "Git [b]lame" })
                -- vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame)
                vim.keymap.set('n', '<leader>ghd', gs.diffthis, { desc = "Git [H]unk [d]iff" })
                -- vim.keymap.set('n', '<leader>ghD', function() gs.diffthis('~') end)
                -- vim.keymap.set('n', '<leader>gtd', gs.toggle_deleted, { desc="Git [t]oggle [d]eleted"})

                -- Text object
                -- vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        }
    },
    {
        "sindrets/diffview.nvim",
        lazy = false,
        keys = {
            { "<leader>dfo", "<cmd>DiffviewOpen<CR>",  mode = "n", desc = "Open diff tool" },
            { "<leader>dfc", "<cmd>DiffviewClose<CR>", mode = "n", desc = "Close diff tool" }
        }
    }
}
