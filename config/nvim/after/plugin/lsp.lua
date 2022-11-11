local Remap = require("kerooz.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

local cmp = require("cmp")
local lspkind = require("lspkind")
--local capabilities = require('cmp_nvim_lsp').default_capabilities()
local luasnip = require("luasnip")
local select_opts = {behavior = cmp.SelectBehavior.Select}

local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    path = "[Path]",
    cmp_tabnine = "[TN]"
}

-- Setup nvim-cpm 
cmp.setup({
    snippet = {
      expand = function(args)
          require("luasnip").lsp_expand(args.body)
      end,
    },

    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
		["<C-Space>"] = cmp.mapping.complete(),

        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item(select_opts)
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_opts)
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'}),
	}),

    window = {
        documentation = cmp.config.window.bordered()
    },
    -- Custome result formating 
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			if entry.source.name == "cmp_tabnine" then
				if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					menu = entry.completion_item.data.detail .. " " .. menu
				end
				vim_item.kind = ""
			end
			vim_item.menu = menu
			return vim_item
		end,
	},

    -- Sort is important  
    sources = {
      { name = 'cmp_tabnine' },
      { name = 'nvim_lsp' },
      { name = 'luasnip' , keyword_length = 2 },
      { name = 'path' },
      { name = 'buffer' },
    }
})

-- Tabnine init
local tabnine = require("cmp_tabnine.config")
tabnine.setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
})

-- LSP Configuration {{

-- Global binding on all LSP 
local function config(_config)
	return vim.tbl_deep_extend("force", {
		on_attach = function()
			nnoremap("gd", function() vim.lsp.buf.definition() end)
            nnoremap("fmt", function() vim.lsp.buf.format({async = true}) end)
			nnoremap("K", function() vim.lsp.buf.hover() end)
			nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
			nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
			nnoremap("$d", function() vim.diagnostic.goto_next() end)
			nnoremap("ùd", function() vim.diagnostic.goto_prev() end)
			nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
			nnoremap("<leader>vco", function() vim.lsp.buf.code_action({
                filter = function(code_action)
                    if not code_action or not code_action.data then
                        return false
                    end

                    local data = code_action.data.id
                    return string.sub(data, #data - 1, #data) == ":0"
                end,
                apply = true
            }) end)
			nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
			nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
			inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
		end,
	}, _config or {})
end

require("lspconfig").gopls.setup(config({
    cmd = { "gopls", "serve" },
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
}))

require("lspconfig").phpactor.setup(config({
     init_options = {
        ["language_server_phpstan.enabled"] = false,
        ["language_server_psalm.enabled"] = false,
     }
}))

require("lspconfig").sumneko_lua.setup(config({
--	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },

	cmd = { "lua-language-server" },
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
		},
	},
}))

require("luasnip.loaders.from_vscode").lazy_load()

-- }}

--  Floating window styles {{
    --
vim.diagnostic.config({
  float = {
    source = 'always',
    border = 'rounded',
  },
})
require('lspconfig.ui.windows').default_options.border = 'single'

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {border = 'rounded'}
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {border = 'rounded'}
)

-- }}
