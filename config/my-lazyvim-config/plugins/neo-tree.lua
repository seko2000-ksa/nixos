return {
  "nvim-neo-tree/neo-tree.nvim",
   config = function()
    vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { silent = true })
  end,  
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          '.git',
        },
        never_show = {},
      },
      lazy = false,
    }
  }
}

