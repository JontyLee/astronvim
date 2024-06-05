return {
  "eshion/vim-sync",
  config = function() vim.g.sync_async_upload = 1 end,
  event = "LspAttach",
}
