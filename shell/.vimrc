" Encodage par défaut des buffers en utf-8
set encoding=utf-8
" Encodage par défaut des fichiers en utf-8
set fileencoding=utf-8

" Fait une copie de sauvegarde lors de l'écrasement d'un fichier
set backup
" Dossier contenant la sauvegarde. N'oubliez pas de le créer et de lui faire un
" chmod 700
set backupdir=~/.cache/vim/backup

" ## Sessions et Views
set viewdir=~/.local/var/vim/views

" Indetation
set autoindent
set shiftwidth=2
set softtabstop=2 
set tabstop=1

let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
set number
syntax on
colorscheme desert
set mouse=a
set expandtab
set hlsearch
set showmatch
filetype on

augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END
