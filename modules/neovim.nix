{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-autopairs
      (nvim-treesitter.withPlugins (p: [
        p.nix
        p.lua
        p.go
      ]))
      telescope-nvim
      plenary-nvim
      telescope-fzf-native-nvim
    ];

    extraLuaConfig = ''
      require("nvim-autopairs").setup {}

      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<M-Up>",
            node_incremental = "<M-Up>",
            scope_incremental = false,
            node_decremental = "<M-Down>",
          },
        },
      }

      local builtin = require('telescope.builtin')

      local function find_files_from_project_root()
        vim.fn.system("git rev-parse --is-inside-work-tree")

        if vim.v.shell_error == 0 then
          builtin.git_files()
        else
          builtin.find_files()
        end
      end

      vim.keymap.set('n', '<leader>ff', find_files_from_project_root, { desc = 'Find files (Smart)' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

      require('telescope').setup {
        defaults = {
          file_ignore_patterns = { "node_modules", ".git" },
          layout_strategy = 'horizontal',
          layout_config = {
            prompt_position = "bottom",
            width = 0.9, -- Take up 90% of screen
          },
        },
      }

      vim.opt.cursorline = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.mouse = ""
      vim.opt.scrolloff = 7
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.breakindent = true

      -- Return to last edit position when opening files
      vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*",
        callback = function()
          local mark = vim.api.nvim_buf_get_mark(0, '"')
          local lcount = vim.api.nvim_buf_line_count(0)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end,
      })
    '';
  };
}
