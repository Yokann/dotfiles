local M = {}

local builtin = require('telescope.builtin')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp.default_capabilities()
local lsp_flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
}



--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local configs = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                    -- Setup your lua path
                    path = vim.split(package.path, ";"),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    },
                },
                format = {
                    enable = true,
                    defaultConfig = {
                        indent_style = "space",
                        indent_size = "4"
                    }
                }
            },
        }
    },
    gopls = {
        settings = {
            gopls = {
                gofumpt = true,
                codelenses = {
                    gc_details = false,
                    generate = true,
                    regenerate_cgo = true,
                    run_govulncheck = true,
                    test = true,
                    tidy = true,
                    upgrade_dependency = true,
                    vendor = true,
                },
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
                analyses = {
                    fieldalignment = true,
                    nilness = true,
                    unusedparams = true,
                    unusedwrite = true,
                    useany = true,
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                semanticTokens = true,
            }
        },
        init_options = {
            usePlaceholders = true,
        }
    }
}

-- Customization for the LSP client
local custom_on_attach = {
    gopls = function(client, bufnr)

    end,
}

M.configure = function(server_name)
    local config = configs[server_name] or {}
    local on_attach = custom_on_attach[server_name] or function() end

    return vim.tbl_deep_extend("force", {
        on_attach = function(client, bufnr)
            vim.keymap.set("n", "gd", function() builtin.lsp_definitions() end, { desc = "[G]o [D]efinition" })
            vim.keymap.set("n", "gtd", function() builtin.lsp_type_definitions() end,
                { desc = "[G]o [T]ype [D]efinition" })
            vim.keymap.set("n", "gr", function() builtin.lsp_references() end, { desc = "[G]oto [R]eferences" })
            vim.keymap.set("n", "<leader>fs", function() builtin.lsp_document_symbols() end,
                { desc = "[F]ind [S]ymbols" })
            vim.keymap.set("n", "<leader>fws", function() builtin.lsp_workspace_symbols() end,
                { desc = "[F]ind [W]orkspace [S]ymbols" })
            vim.keymap.set("n", "gi", function() builtin.lsp_implementations() end, { desc = "[G]o [I]mplemention" })
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "[C]ode [A]ction" })
            vim.keymap.set("n", "fmt", function() vim.lsp.buf.format({ async = true }) end, { desc = "[F]or[M]a[T]" })
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end,
                { desc = "Go to next [D]iagnostic message" })
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end,
                { desc = "Go to previous [D]iagnostic message" })
            vim.keymap.set("n", "<leader>cc", function() vim.lsp.buf.code_action() end,
                { desc = "[V]iew [C]ode [A]ction" })
            vim.keymap.set("n", "<leader>co", function()
                vim.lsp.buf.code_action({
                    filter = function(code_action)
                        if not code_action or not code_action.data then
                            return false
                        end

                        local data = code_action.data.id
                        return string.sub(data, #data - 1, #data) == ":0"
                    end,
                    apply = true
                })
            end, { desc = "[V]iew [C]ode actions [O]thers" })
            vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "[R]e[N]ame" })
            vim.keymap.set({ "n", "i" }, "<A-h>", function() vim.lsp.buf.signature_help() end,
                { desc = "View code signature" })

            vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
            -- -- Autoformat on save
            if client.supports_method("textDocument/formatting") then
                local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end

            on_attach(client, bufnr)
        end,
        capabilities = capabilities,
        flags = lsp_flags
    }, config)
end

return M
