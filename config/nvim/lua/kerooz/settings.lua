local opts_info = vim.api.nvim_get_all_options_info()

local opt = setmetatable(
                {}, {
      __newindex = function(_, key, value)
        vim.o[key] = value
        local scope = opts_info[key].scope
        if scope == 'win' then
          vim.wo[key] = value
        elseif scope == 'buf' then
          vim.bo[key] = value
        end
      end
    }
)

local function add(value, str, sep)
  sep = sep or ','
  str = str or ''
  value = type(value) == 'table' and table.concat(value, sep) or value
  return str ~= '' and table.concat({ value, str }, sep) or value
end

vim.g.mapleader = " "

-- Numbers {{{

vim.o.number = true
vim.o.relativenumber = true

-- }}}

-- Window splitting and buffers {{{

opt.ruler = true
vim.o.hidden = true
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.splitbelow = true
vim.o.splitright = true
-- exclude usetab as we do not want to jump to buffers in already open tabs
-- do not use split or vsplit to ensure we don't open any new windows
vim.o.switchbuf = 'useopen,uselast'
vim.o.fillchars = add {
  'vert:▕', -- alternatives │
  'fold: ',
  'eob: ', -- suppress ~ at EndOfBuffer
  'diff:─', -- alternatives: ⣿ ░
  'msgsep:‾',
  'foldopen:▾',
  'foldsep:│',
  'foldclose:▸'
}
opt.laststatus = 3

-- }}}


-- Display {{{

-- opt.conceallevel = 2
-- opt.breakindentopt = 'sbr'
opt.linebreak = true -- lines wrap at words rather than random characters
opt.synmaxcol = 1024 -- don't syntax highlight long lines
vim.o.cmdheight = 1 -- Set command line height to two lines
vim.o.showbreak = [[↪ ]] -- Options include -> '…', '↳ ', '→','↪ '
-- vim.g.vimsyn_embed = 'lPr' -- allow embedded syntax highlighting for lua,python and ruby
vim.opt.termguicolors = true
vim.opt.errorbells = false
vim.opt.guicursor = ""
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "128"

-- }}}

-- Indentation {{{

opt.wrap = false
opt.wrapmargin = true
opt.tabstop = 4
opt.softtabstop = 4
opt.textwidth = 1024
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
vim.o.shiftround = true
vim.o.emoji = false

-- }}}

-- Timings {{{

opt.updatetime = 50

-- }}}

-- these only read ".vim" files {{{

vim.o.secure = true -- Disable autocmd etc for project local vimrc files.
vim.o.exrc = true -- Allow project local vimrc files example .nvimrc see :h exrc

-- }}}

-- BACKUP AND SWAPS {{{

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- }}}

vim.opt.incsearch = true
vim.g.gitblame_enabled = 0
