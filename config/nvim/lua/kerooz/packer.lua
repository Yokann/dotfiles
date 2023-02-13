local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
            install_path })
    print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end
    }
})

-- Install plugins here
return packer.startup(function(use)
        -- Base
        use("wbthomason/packer.nvim") -- Have packer manage itself
        use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
        use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
        use("nvim-lualine/lualine.nvim") -- Status bar
        use {
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons', -- optional, for file icons
            },
        }
        -- Telescope
        use("nvim-telescope/telescope.nvim")
        use({ "kelly-lin/telescope-ag", requires = { { "nvim-telescope/telescope.nvim" } } })
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        }
        -- Git
        --use {
        --  "TimUntersberger/neogit",
        --  requires = {"nvim-lua/plenary.nvim"}
        --}
        use {
            "kdheepak/lazygit.nvim"
        }
        -- All the things
        use("hrsh7th/cmp-nvim-lsp")
        use("hrsh7th/cmp-buffer")
        use("hrsh7th/nvim-cmp")
        use("hrsh7th/cmp-path")
        use("hrsh7th/cmp-cmdline")
        use("onsails/lspkind-nvim")
        -- use("glepnir/lspsaga.nvim") -- c'est vachement bien mais je sais pas encore m'en servir
        use("neovim/nvim-lspconfig")
        use {
            "tzachar/cmp-tabnine",
            run = "./install.sh",
            requires = { "hrsh7th/nvim-cmp" }
        }
        use("rafamadriz/friendly-snippets")
        use("L3MON4D3/LuaSnip")
        use("saadparwaiz1/cmp_luasnip")

        -- Colorscheme section
        use {
            "catppuccin/nvim",
            as = "catppuccin",
            config = function()
                require("catppuccin").setup {
                    flavour = "macchiato", -- mocha, macchiato, frappe, latte
                    background = {
                        dark = "mocha"
                    }
                }
                vim.api.nvim_command "colorscheme catppuccin"
            end
        }

        -- Git
        use("f-person/git-blame.nvim")
        use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })
        use("airblade/vim-gitgutter")
        use({
            "ghillb/cybu.nvim",
            branch = "main", -- timely updates
            -- branch = "v1.x", -- won't receive breaking changes
            requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
            config = function()
                local ok, cybu = pcall(require, "cybu")
                if not ok then
                    return
                end
                cybu.setup()
                vim.keymap.set("n", "<A-k>", "<Plug>(CybuPrev)")
                vim.keymap.set("n", "<A-j>", "<Plug>(CybuNext)")
                vim.keymap.set({ "n", "v" }, "<c-s-tab>", "<plug>(CybuLastusedPrev)",
                    { desc = "Previous last used buffer" })
                vim.keymap.set({ "n", "v" }, "<c-tab>", "<plug>(CybuLastusedNext)", { desc = "Next last used buffer " })
            end
        })

        -- Custom
        use("ThePrimeagen/refactoring.nvim")

        -- Debugger
        use {
            "mfussenegger/nvim-dap",
            opt = true,
            event = "BufReadPre",
            module = { "dap" },
            wants = { "nvim-dap-virtual-text", "nvim-dap-ui" },
            requires = {
                "theHamsta/nvim-dap-virtual-text",
                "rcarriga/nvim-dap-ui",
                "nvim-telescope/telescope-dap.nvim",
                { "leoluz/nvim-dap-go",                module = "dap-go" },
                { "jbyuki/one-small-step-for-vimkind", module = "osv" },
            },
            config = function()
                require("kerooz.dap").setup()
            end,
        }
        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugin
        if PACKER_BOOTSTRAP then
            require('packer').sync()
        end
    end)
