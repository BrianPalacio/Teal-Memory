return {
  "Vigemus/iron.nvim",
  config = function()
    require("iron.core").setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          python = { command = { "ipython" } },
          lua = { command = { "lua" } },
          javascript = { command = { "node" } },
        },
        repl_open_cmd = "belowright split | resize 15",
      },
      keymaps = {
        send_motion = "<leader>sc",
        visual_send = "<leader>sc",
        send_file = "<leader>sf",
        send_line = "<leader>sl",
        send_mark = "<leader>sm",
        mark_motion = "<leader>mc",
        mark_visual = "<leader>mc",
        remove_mark = "<leader>md",
        cr = "<leader>s<CR>",
        interrupt = "<leader>s<Space>",
        exit = "<leader>sq",
        clear = "<leader>cl",
      },
    })
  end,
}

