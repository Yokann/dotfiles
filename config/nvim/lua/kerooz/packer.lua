local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('packer_user_config', { clear = true }),
    pattern = "packer.lua",
    command = "source <afile> | PackerSync"
})

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
    use {
        "wbthomason/packer.nvim", -- Have packer manage itself
        "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
        "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
        "nvim-lualine/lualine.nvim", -- Status bar
        "tpope/vim-surround",
        "tpope/vim-repeat",
        "airblade/vim-rooter", -- load root dir at vim startup on a file
        "ggandor/leap.nvim", -- intersting way to move
        "numToStr/Comment.nvim", -- comment block
        "rmagatti/auto-session", -- restore previous dir session
        "tweekmonster/startuptime.vim",
        {
            "windwp/nvim-autopairs",
            config = function() require("nvim-autopairs").setup {} end
        }
    }
    -- Nvim Tree
    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
            { "nvim-telescope/telescope-ui-select.nvim" }
        }
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            "JoosepAlviste/nvim-ts-context-commentstring"
        }
    }

    -- LSP Config
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "j-hui/fidget.nvim", config = function() require('fidget').setup() end } --loader for lsp
        }
    }

    -- Completion
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            {
                "tzachar/cmp-tabnine",
                run = "./install.sh",
            },
            { "onsails/lspkind-nvim", requires = "neovim/nvim-lspconfig" },
            -- Snippet
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                requires = { "rafamadriz/friendly-snippets" },
            },
        }
    }

    -- Colorscheme section
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require("catppuccin").setup {
                flavour = "macchiato", -- mocha, macchiato, frappe, latte
            }
            vim.api.nvim_command "colorscheme catppuccin"
        end
    }

    -- Git
    use {
        "kdheepak/lazygit.nvim",
        "lewis6991/gitsigns.nvim",
        -- { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }
    }

    -- UI
    use {
        "lukas-reineke/indent-blankline.nvim",
        "levouh/tint.nvim", -- highlight current buffer
    }
    use({
        -- Buffer navigation helper
        "ghillb/cybu.nvim",
        branch = "main", -- timely updates
        -- branch = "v1.x", -- won't receive breaking changes
        requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
    })

    -- Custom
    use({
        "ThePrimeagen/refactoring.nvim",
        "folke/todo-comments.nvim",
    })

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
