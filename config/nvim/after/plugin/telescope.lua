local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

telescope.setup({
    defaults = {
        file_ignore_patterns = { "^%.git/" }
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown(
                {
                    layout_strategy = "vertical",
                    layout_config = {
                        prompt_position = "bottom",
                        vertical = {
                            width = 0.5,
                            height = 20,
                        },
                    },
                }
            )
        }
    },
    pickers = {
        find_files = {
            hidden = true,
            no_ignore = true,
        },
        live_grep = {
            additional_args = function(opts)
                return { "--hidden" }
            end
        }
    }
})
telescope.load_extension('fzf')
telescope.load_extension('ui-select')
local builtin = require('telescope.builtin')

-- Find 
vim.keymap.set("n", '<leader><space>', builtin.find_files, { desc = "[F]ind in all [F]iles" })
vim.keymap.set("n", '<leader>fg', builtin.git_files, { desc = "[F]ind in [G]it files" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [r]ecently opened files" })
vim.keymap.set("n", '<leader>fb', builtin.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", '<leader>fh', builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymap" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fs", builtin.treesitter, { desc = "[F]ind [S]ymbols" })
-- Search
vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "[L]ive [G]rep" })
-- LSP
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
