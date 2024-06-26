return {
  "skywind3000/asynctasks.vim",
  dependencies = {
    { "skywind3000/asyncrun.vim" },
  },
  init = function()
    vim.cmd [[
                    let g:asyncrun_open = 8
                    let g:asynctask_template = '~/.config/nvim/lua/user/task_template.ini'
                    let g:asynctasks_extra_config = ['~/.config/nvim/lua/user/tasks.ini']
                ]]
  end,
  event = { "BufRead", "BufNew" },
}
