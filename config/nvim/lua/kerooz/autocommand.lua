vim.cmd([[
  augroup tmux_user_config
    autocmd!
    autocmd BufWritePost .tmux.conf execute ':!tmux source-file %'
  augroup end
]])
