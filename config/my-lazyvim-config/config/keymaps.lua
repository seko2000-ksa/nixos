-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
require("neo-tree").setup({
  source_selector = {
    winbar = true,
    statusline = false,
  },

  window = {
    position = "left",
    mappings = {
      ["e"] = function()
        vim.api.nvim_exec("Neotree focus filesystem left", true)
      end,
      ["b"] = function()
        vim.api.nvim_exec("Neotree focus buffers left", true)
      end,
      ["g"] = function()
        vim.api.nvim_exec("Neotree focus git_status left", true)
      end,
    },
  },

  event_handlers = {

    {
      event = "file_opened",
      handler = function(file_path)
        -- auto close
        -- vimc.cmd("Neotree close")
        -- OR
        require("neo-tree.command").execute({ action = "show" })
      end,
    },
  },
})
