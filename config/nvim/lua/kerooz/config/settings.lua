vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Numbers {{{

vim.opt.number = true
vim.opt.relativenumber = true

-- }}}

-- Window splitting and buffers {{{

vim.opt.ruler = true
vim.opt.hidden = true
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.splitbelow = true
vim.opt.splitright = true
-- exclude usetab as we do not want to jump to buffers in already open tabs
-- do not use split or vsplit to ensure we don't open any new windows
vim.opt.switchbuf = 'useopen,uselast'
-- o.fillchars:append { diff = " " }
vim.opt.laststatus = 3

-- }}}


-- Display {{{

-- opt.conceallevel = 2
-- opt.breakindentopt = 'sbr'
vim.opt.showmode = false
vim.opt.linebreak = true -- lines wrap at words rather than random characters
vim.opt.synmaxcol = 1024 -- don't syntax highlight long lines
vim.opt.cmdheight = 1 -- Set command line height to two lines
vim.opt.showbreak = [[↪ ]] -- Options include -> '…', '↳ ', '→','↪ '
-- vim.g.vimsyn_embed = 'lPr' -- allow embedded syntax highlighting for lua,python and ruby
vim.opt.termguicolors = true
vim.opt.errorbells = false
vim.opt.guicursor = "a:block-Cursor"
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "128"
vim.opt.cursorline = true
vim.opt.fillchars:append({
    eob = ' ',
    vert = '▕',
    fold = ' ',
    diff = ' ',
    msgsep = '‾',
    foldopen = '▾',
    foldsep = '│',
    foldclose = '▸'
})
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- }}}

-- Indentation {{{

vim.opt.wrap = false
-- o.wrapmargin = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.textwidth = 1024
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.shiftround = true
vim.opt.emoji = false

-- }}}

-- Timings {{{

vim.opt.updatetime = 250

-- }}}

-- these only read ".vim" files {{{

vim.opt.secure = true -- Disable autocmd etc for project local vimrc files.
vim.opt.exrc = true   -- Allow project local vimrc files example .nvimrc see :h exrc

-- }}}

-- BACKUP AND SWAPS {{{

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- }}}

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.gitblame_enabled = 0
vim.g.user_emmet_leader_key = "<A-e>"
vim.opt.clipboard:append 'unnamedplus' -- use system clipboard
vim.opt.mouse = 'a'                    -- enable mouse for all modes
vim.opt.mousemoveevent = true          -- Allow hovering in bufferline

-- Environments
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
