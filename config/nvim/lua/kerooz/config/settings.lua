local opts_info = vim.api.nvim_get_all_options_info()
local o = vim.opt

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

local function setup()
    vim.g.mapleader = " "

    -- Numbers {{{

    o.number = true
    o.relativenumber = true

    -- }}}

    -- Window splitting and buffers {{{

    o.ruler = true
    o.hidden = true
    o.encoding = 'utf-8'
    o.fileencoding = 'utf-8'
    o.splitbelow = true
    o.splitright = true
    -- exclude usetab as we do not want to jump to buffers in already open tabs
    -- do not use split or vsplit to ensure we don't open any new windows
    o.switchbuf = 'useopen,uselast'
    o.fillchars = add {
        'vert:▕', -- alternatives │
        'fold: ',
        'eob: ', -- suppress ~ at EndOfBuffer
        'diff:─', -- alternatives: ⣿ ░
        'msgsep:‾',
        'foldopen:▾',
        'foldsep:│',
        'foldclose:▸'
    }
    o.fillchars:append { diff = " " }
    o.laststatus = 3

    -- }}}


    -- Display {{{

    -- opt.conceallevel = 2
    -- opt.breakindentopt = 'sbr'
    o.linebreak = true -- lines wrap at words rather than random characters
    o.synmaxcol = 1024 -- don't syntax highlight long lines
    o.cmdheight = 1 -- Set command line height to two lines
    o.showbreak = [[↪ ]] -- Options include -> '…', '↳ ', '→','↪ '
    -- vim.g.vimsyn_embed = 'lPr' -- allow embedded syntax highlighting for lua,python and ruby
    o.termguicolors = true
    o.errorbells = false
    o.guicursor = "a:block-Cursor"
    o.scrolloff = 8
    o.colorcolumn = "128"

    -- }}}

    -- Indentation {{{

    o.wrap = false
    -- o.wrapmargin = true
    o.tabstop = 4
    o.softtabstop = 4
    o.textwidth = 1024
    o.shiftwidth = 4
    o.expandtab = true
    o.smarttab = true
    o.autoindent = true
    o.smartindent = true
    o.breakindent = true
    o.shiftround = true
    o.emoji = false

    -- }}}

    -- Timings {{{

    o.updatetime = 90

    -- }}}

    -- these only read ".vim" files {{{

    o.secure = true -- Disable autocmd etc for project local vimrc files.
    o.exrc = true -- Allow project local vimrc files example .nvimrc see :h exrc

    -- }}}

    -- BACKUP AND SWAPS {{{

    o.swapfile = false
    o.backup = false
    o.undodir = os.getenv("HOME") .. "/.vim/undodir"
    o.undofile = true

    -- }}}

    o.incsearch = true
    vim.g.gitblame_enabled = 0
    vim.g.user_emmet_leader_key = "<A-e>"
    o.clipboard = { 'unnamed', 'unnamedplus' } --- Copy-paste between vim and everything else
end

return {
    setup = setup
}
