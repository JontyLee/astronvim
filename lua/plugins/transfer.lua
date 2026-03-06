return {
  "coffebar/transfer.nvim",
  lazy = true,
  cmd = { "TransferInit", "DiffRemote", "TransferUpload", "TransferDownload", "TransferDirDiff", "TransferRepeat" },
  opts = {},
  dependencies = { "nvim-neo-tree/neo-tree.nvim", "folke/snacks.nvim" },
  specs = {
    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        window = {
          mappings = {
            -- upload (sync files)
            uu = {
              function(state) vim.cmd("TransferUpload " .. state.tree:get_node().path) end,
              desc = "upload file or directory",
              nowait = true,
            },
            -- download (sync files)
            ud = {
              function(state) vim.cmd("TransferDownload" .. state.tree:get_node().path) end,
              desc = "download file or directory",
              nowait = true,
            },
            -- diff directory with remote
            uf = {
              function(state)
                local node = state.tree:get_node()
                local context_dir = node.path
                if node.type ~= "directory" then
                  -- if not a directory
                  -- one level up
                  context_dir = context_dir:gsub("/[^/]*$", "")
                end
                vim.cmd("TransferDirDiff " .. context_dir)
                vim.cmd "Neotree close"
              end,
              desc = "diff with remote",
            },
          },
        },
      },
    },
    {
      "folke/snacks.nvim",
      opts = {
        picker = {
          actions = {
            transfer_up = function(_, item) vim.cmd.TransferUpload(item.file) end,
            transfer_down = function(_, item) vim.cmd.TransferDownload(item.file) end,
            transfer_diff = function(_, item)
              if item.dir then
                vim.cmd.TransferDirDiff(item.file)
              else
                vim.cmd.DiffRemote(item.file)
              end
            end,
          },
          win = {
            list = {
              keys = {
                ["tu"] = "transfer_up",
                ["td"] = "transfer_down",
                ["tD"] = "transfer_diff",
              },
            },
          },
        },
      },
    },
  },
}
