local M = {}

M.theme = {
  name = "catppuccin",
  catppuccin_flavour = "frappe",
  ayucolor = "dark",
  rose_pine = { variant = "moon" },
}

M.mappings = {
  custom = {
    ["<leader>t"] = { "<cmd>FloatermNew --width=0.8 --height=0.8<cr>", "Open terminal" },
    ["<c-\\>"] = { "<cmd>FloatermToggle!<cr>", "Toggle Terminal", mode = { "t", "n" } },
    ["<c-q>"] = { "<cmd>:qa<cr>", "Close all buffers" },
    -- Gitsigns
    ["<leader>h"] = {
      name = " Git",
      c = { ":Gitsigns toggle_current_line_blame<CR>", "Toggle current line blame" },
      d = { ":Gitsigns toggle_deleted<CR>", "Toggle deleted" },
      l = { ":Gitsigns toggle_linehl<CR>", "Toggle line" },
      n = { ":Gitsigns toggle_numhl<CR>", "Toggle number" }
    },
    ["<leader>R"] = {
      name = " Replace",
      f = { "<cmd>lua require('spectre').open_file_search()<CR>", "Current Buffer" },
      p = { "<cmd>lua require('spectre').open()<CR>", "Project" },
      w = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Replace Word" },
    },
  },
}

M.lsps = {
  tailwindcss = {},
  ["rescriptls@latest-master"] = {},
  bashls = {
    settings = {
      allowlist = { "sh", "bash" },
    },
  },
  tsserver = {
    on_attach = function(client, bufnr)
      require "twoslash-queries".attach(client, bufnr)
    end,
  },
}

M.nvim_tree = {
  update_cwd = false,
  update_focused_file = {
    update_cwd = false,
  },
  view = {
    adaptive_size = false,
  },
  filters = {
    dotfiles = false,
    exclude = { "github.*" },
  },
}

M.treesitter = "all"

M.plugins = {
  { "Exafunction/codeium.vim" },
  { "nkrkv/nvim-treesitter-rescript" },
  { "devongovett/tree-sitter-highlight" },
  { "rescript-lang/vim-rescript" },
  { "wakatime/vim-wakatime" },
  { "windwp/nvim-spectre" },
  { "voldikss/vim-floaterm" },
  { "mg979/vim-visual-multi" },
  { "amadeus/vim-mjml" },
  {
    "marilari88/twoslash-queries.nvim",
    opts = {
      multi_line = true,  -- to print types in multi line mode
      highlight = "Type", -- to set up a highlight group for the virtual text
    },
  },
}

local terminal_opened_status = function()
  local terminals = vim.inspect(vim.api.nvim_call_function("floaterm#buflist#gather", {}))
  local is_terminal_opened = #terminals > 2
  return is_terminal_opened and "󰆍" or ""
end

M.lualine = {
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    a = { "mode" },
    b = { "branch" },
    c = { "filename", terminal_opened_status },
    x = { "encoding", "fileformat", "filetype" },
    y = { "progress" },
    z = { "location" },
  },
}

M.noice = {
  cmdline = {
    format = {
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
    },
  },
  messages = {
    enabled = true,
    view = "mini",
    view_error = "mini",
    view_warn = "mini",
    view_history = "messages",
    view_search = "virtualtext",
  },
}

M.flags = {
  disable_tabs = true,
  format_on_save = true,
}

M.hooks = {
  after_setup = function()
    -- Shortcuts
    vim.cmd [[
    set number
    augroup numbertoggle
      let ignore = ['dashboard', 'NvimTree', 'floaterm', 'TelescopePrompt', 'mason', 'noice']
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave * if index(ignore, &ft) < 0 | set relativenumber | endif
      autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup END
    vnoremap t :'<,'>sort<CR>
    nnoremap <S-A-j> :m .+1<CR>==
    nnoremap <S-A-k> :m .-2<CR>==
    vnoremap <S-A-j> :m '>+1<CR>gv=gv
    inoremap <S-A-j> <Esc>:m .+1<CR>==gi
    inoremap <S-A-k> <Esc>:m .-2<CR>==gi
    vnoremap <S-A-k> :m '<-2<CR>gv=gv
    nnoremap ,, <S-a>,<ESC>
    inoremap ,, <ESC><S-a>,<ESC>
    nnoremap ;; <S-a>;<ESC>
    inoremap ;; <ESC><S-a>;<ESC>
  ]]
    -- Floatterm config
    vim.g.floaterm_title = ""
    -- Vim Settings
    vim.o.backupdir = "/tmp/.nvim/backup"
    vim.o.directory = "/tmp/.nvim/swap"
    vim.o.undodir = "/tmp/.nvim/undo"
    -- Web devicons
    require("nvim-web-devicons").set_icon {
      res = {
        icon = "",
        color = "#e6484f",
        name = "ReScript"
      },
      zsh = {
        icon = "",
        color = "#428850",
        name = "Zsh"
      },
      [".eslintrc.json"] = {
        icon = "",
        color = "#4b32c3",
        name = "Eslint"
      },
      ["tailwind.config.js"] = {
        icon = "󱏿",
        color = "#3b82f6",
        name = "TailwindCSS"
      },
      ["babel.config.js"] = {
        icon = "󰨥",
        color = "#f5da55",
        name = "Babel"
      }
    }
    -- Sepctre
    require("spectre").setup {
      color_devicons = true,
      highlight = {
        ui = "String",
        search = "DiffChange",
        replace = "DiffDelete",
      },
      mapping = {
        ["toggle_line"] = {
          map = "t",
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "toggle current item",
        },
        ["enter_file"] = {
          map = "<cr>",
          cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = "goto current file",
        },
        ["send_to_qf"] = {
          map = "Q",
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all item to quickfix",
        },
        ["replace_cmd"] = {
          map = "c",
          cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
          desc = "input replace vim command",
        },
        ["show_option_menu"] = {
          map = "o",
          cmd = "<cmd>lua require('spectre').show_options()<CR>",
          desc = "show option",
        },
        ["run_replace"] = {
          map = "R",
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = "replace all",
        },
        ["change_view_mode"] = {
          map = "m",
          cmd = "<cmd>lua require('spectre').change_view()<CR>",
          desc = "change result view mode",
        },
        ["toggle_ignore_case"] = {
          map = "I",
          cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
          desc = "toggle ignore case",
        },
        ["toggle_ignore_hidden"] = {
          map = "H",
          cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
          desc = "toggle search hidden",
        },
      },
      find_engine = {
        ["rg"] = {
          cmd = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          options = {
            ["ignore-case"] = {
              value = "--ignore-case",
              icon = "[I]",
              desc = "ignore case",
            },
            ["hidden"] = {
              value = "--hidden",
              desc = "hidden file",
              icon = "[H]",
            },
          },
        },
        ["ag"] = {
          cmd = "ag",
          args = {
            "--vimgrep",
            "-s",
          },
          options = {
            ["ignore-case"] = {
              value = "-i",
              icon = "[I]",
              desc = "ignore case",
            },
            ["hidden"] = {
              value = "--hidden",
              desc = "hidden file",
              icon = "[H]",
            },
          },
        },
      },
      replace_engine = {
        options = {
          ["ignore-case"] = {
            value = "--ignore-case",
            icon = "[I]",
            desc = "ignore case",
          },
        },
      },
      default = {
        find = {
          cmd = "rg",
          options = { "ignore-case" },
        },
        replace = {
          cmd = "sed",
        },
      },
      replace_vim_cmd = "cdo",
      is_open_target_win = true, --open file on opener window
      is_insert_mode = false,    -- start open panel on is_insert_mode
    }
  end,
}

return M
