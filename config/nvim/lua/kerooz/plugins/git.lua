local prefix_diffs = "<leader>df"
local prefix_conflicts = "<leader>gc"
local function toggle_diffview(cmd)
    if next(require("diffview.lib").views) == nil then
        vim.cmd(cmd)
    else
        vim.cmd("DiffviewClose")
    end
end

return {
    {
        "lewis6991/gitsigns.nvim",
        event = "BufEnter",
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            on_attach = function()
                local gs = package.loaded.gitsigns
                -- Actions
                -- vim.keymap.set({ 'n', 'v' }, '<leader>ghs', gs.stage_hunk, { desc="Git [h]unk [s]tage"})
                -- vim.keymap.set({ 'n', 'v' }, '<leader>ghr', 'gs.reset_hunk, { desc="Git [h]unk [r]eset"})
                -- vim.keymap.set('n', '<leader>ghS', gs.stage_buffer, { desc="Git [h]unk [S]tage"})
                -- vim.keymap.set('n', '<leader>ghu', gs.undo_stage_hunk, { desc="Git [h]unk [U]ndo"})
                -- vim.keymap.set('n', '<leader>ghR', gs.reset_buffer, { desc="Git [h]unk [R]eset buffer"})
                vim.keymap.set("n", "<leader>gpi", gs.preview_hunk_inline, { desc = "Git - Preview inline" })
                vim.keymap.set("n", "<leader>gb", function()
                    gs.blame_line({ full = true })
                end, { desc = "Git - Blame" })
                -- vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame)
                vim.keymap.set("n", "<leader>gd", gs.diffthis, { desc = "Git - Diff" })
                -- vim.keymap.set('n', '<leader>ghD', function() gs.diffthis('~') end)
                -- vim.keymap.set('n', '<leader>gtd', gs.toggle_deleted, { desc="Git [t]oggle [d]eleted"})

                -- Text object
                -- vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end,
        },
    },
    {
        "sindrets/diffview.nvim",
        lazy = false,
        -- stylua: ignore
        keys = {
            { prefix_diffs .. "o", function() toggle_diffview("DiffviewOpen") end,          mode = "n",                        desc = "Open diff tool" },
            { prefix_diffs .. "f", function() toggle_diffview("DiffviewFileHistory %") end, desc = "Diff Current File History" },
        },
        opts = function(_, opts)
            local actions = require("diffview.actions")
            opts.enhanced_diff_hl = true
            opts.view = {
                default = { winbar_info = true },
                file_history = { winbar_info = true },
            }
            opts.keymaps = {
                -- stylua: ignore
                view = {
                    { "n", prefix_conflicts .. "o", actions.conflict_choose("ours"),       { desc = "Ours" } },
                    { "n", prefix_conflicts .. "t", actions.conflict_choose("theirs"),     { desc = "Theirs" } },
                    { "n", prefix_conflicts .. "b", actions.conflict_choose("base"),       { desc = "Base" } },
                    { "n", prefix_conflicts .. "a", actions.conflict_choose("all"),        { desc = "All" } },
                    { "n", prefix_conflicts .. "d", actions.conflict_choose("none"),       { desc = "Delete" } },
                    { "n", prefix_conflicts .. "O", actions.conflict_choose_all("ours"),   { desc = "Ours (File)" } },
                    { "n", prefix_conflicts .. "T", actions.conflict_choose_all("theirs"), { desc = "Theirs (File)" } },
                    { "n", prefix_conflicts .. "B", actions.conflict_choose_all("base"),   { desc = "Base (File)" } },
                    { "n", prefix_conflicts .. "A", actions.conflict_choose_all("all"),    { desc = "All (File)" } },
                    { "n", prefix_conflicts .. "D", actions.conflict_choose_all("none"),   { desc = "Delete (File)" } },
                },
                -- stylua: ignore
                file_panel = {
                    { "n", prefix_conflicts .. "O", actions.conflict_choose_all("ours"),   { desc = "Ours (File)" } },
                    { "n", prefix_conflicts .. "T", actions.conflict_choose_all("theirs"), { desc = "Theirs (File)" } },
                    { "n", prefix_conflicts .. "B", actions.conflict_choose_all("base"),   { desc = "Base (File)" } },
                    { "n", prefix_conflicts .. "A", actions.conflict_choose_all("all"),    { desc = "All (File)" } },
                    { "n", prefix_conflicts .. "X", actions.conflict_choose_all("none"),   { desc = "Delete (File)" } },
                },
            }
        end,
    },
}
