{ pkgs,
  ...
} : {
  # Install Neovim and dependencies
  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    gcc
    lua-language-server
    tree-sitter
    stylua
    nil
    nixpkgs-fmt
    nodejs
    unzip
    luajitPackages.jsregexp
    ueberzugpp
    imagemagick
    viu
    chafa
    zoxide
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (p: with p; [ nix python lua rust ]))
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
        require('Comment').setup({
          padding = true,
          sticky = true,
          mappings = {
          basic = true,
          extra = true,
          },
        })
      '';
      }
      {
        plugin = nvim-treesitter;
        type = "lua";
        config = ''
        require('nvim-treesitter').setup {
          highlight = { enable = true },
          indent = { enable = true },
          ensure_installed = {
            "bash",
            "python",
            "lua",
          },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
                                                              },
                                  },
                                }
      '';
      }
      {
        plugin = friendly-snippets;
        type = "lua";
      }
      {
        plugin = luasnip;
        type = "lua";
        config = ''
        require('luasnip.loaders.from_vscode').lazy_load()
        '';
      }
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
        require("gitsigns").setup({
          signs = {
            add          = { text = '▎' },
            change       = { text = '▎' },
            delete       = { text = '▎' },
            topdelete    = { text = '▎' },
            changedelete = { text = '▎' },
          },

          signcolumn = true,
          numhl      = false,
          linehl     = false,
          word_diff  = false,

          current_line_blame = false,
          current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol',
            delay = 500,
            ignore_whitespace = false,
          },

          on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            -- Keymaps
            local function map(mode, lhs, rhs, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, lhs, rhs, opts)
            end

            -- Navigation
            map("n", "]h", gs.next_hunk)
            map("n", "[h", gs.prev_hunk)

            -- Actions
            map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" } )
            map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" } )
            map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
            map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
            map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" } )
            map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Stage Hunk" } )
            map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" } )
            map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" } )
            map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line (full)" })

            -- Toggle options
            map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Toggle Current Line Blame"} )
            map("n", "<leader>tw", gs.toggle_word_diff, { desc = "Toggle Word Diff" } )
          end,
            })
      '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("nil_ls")
      '';
      }
      {
        plugin = mason-nvim;
        type = "lua";
        config = ''
        require('mason').setup()
      '';
      }
      {
        plugin = mason-lspconfig-nvim;
        type = "lua";
        config = ''
        require('mason-lspconfig').setup {
          ensure_installed = { 
            "lua_ls", "pyright"
          },
        }
      '';
      }
      {
        plugin = fzf-lua;
        type = "lua";
      }
      {
        plugin = nvim-lsp-file-operations;
        type = "lua";
        config = ''
        require("lsp-file-operations").setup()
        '';
      }
      nui-nvim
      {
        plugin = nvim-window-picker;
        type = "lua";
        config = ''
        require'window-picker'.setup ({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            bo = {
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              buftype = { "terminal", "quickfix" },
            },
          },

          vim.keymap.set("n", "<leader>wS", function()
            local picker = require("window-picker")
            local win = picker.pick_window()

            if win then
              local curr = vim.api.nvim_get_current_win()
              vim.api.nvim_win_set_buf(curr, vim.api.nvim_win_get_buf(win))
            end
          end, { desc = "Swap window buffer" })

          --vim.keymap.set("n", "<leader>ww", function()
          --  local win = require("window-picker").pick_window()
          --  if win then vim.api.nvim_set_current_win(win) end
          --end, { desc = "Pick window" })

          --vim.keymap.set("n", "<leader>wV", function()
          --  vim.cmd("vsplit")
          --  local win = require("window-picker").pick_window()
          --  if win then vim.api.nvim_set_current_win(win) end
          --end)
        })
      '';
      }
      {
        plugin = image-nvim;
        type = "lua";
        config = ''
        require('image').setup({
        })
      '';
      }
      {
        plugin = neo-tree-nvim;
        type = "lua";
        config = ''
        require("neo-tree").setup {
          close_if_last_window = false,
        }
      vim.keymap.set("n", "<leader>ee", "<Cmd>Neotree reveal<CR>")
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
          -- set an empty statusline till lualine loads
            vim.o.statusline = " "
        else
        -- hide the statusline on the starter page
          vim.o.laststatus = 0
        end

        require('lualine').setup {
          options = {
            theme = "nord",
          },
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
        }
      '';
      }
      {
        plugin = nord-nvim;
        type = "lua";
        config = ''
        require('lualine').setup { { theme = 'nord'} }
      vim.cmd.colorscheme 'nord'
        '';
      }
      {
        plugin = todo-comments-nvim;
        type = "lua";
        config = ''
        require('todo-comments').setup {
          sign = true,
          sign_priority = 8,

          keywords = {
            FIX   = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
            TODO  = { icon = " ", color = "info" },
            WARN  = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            HACK  = { icon = " ", color = "warning" },
            PERF  = { icon = " ", color = "hint", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE  = { icon = " ", color = "hint", alt = { "INFO" } },
          },

          merge_keywords = true,

          highlight = {
            multiline = true,
            multiline_pattern = "^.",    -- treat whole paragraph as one block
            multiline_context = 10,
            before = "", -- "fg" or "bg" or ""
            keyword = "wide", -- "fg", "bg", "wide"
            after = "fg",
            pattern = [[.*<(KEYWORDS)\s*:?]], -- match TODO/FIX/NOTE patterns
            comments_only = true,
            max_line_len = 400,
            exclude = {},
          },

          colors = {
            error   = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            warning = { "DiagnosticWarn",  "WarningMsg", "#FBBF24" },
            info    = { "DiagnosticInfo",  "#2563EB" },
            hint    = { "DiagnosticHint",  "#10B981" },
            default = { "Identifier", "#7C3AED" },
                      },

          search = {
            command = "rg",
            args = {
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
            },
          },        
                      }

        local todo = require("todo-comments")

        vim.keymap.set("n", "]t", function()
          todo.jump_next()
        end, { desc = "Next TODO comment" })

        vim.keymap.set("n", "[t", function()
          todo.jump_prev()
        end, { desc = "Previous TODO comment" })
      '';
      }
      nvim-notify
      plenary-nvim
      {
        plugin = noice-nvim;
        type = "lua";
        config = ''
        require("noice").setup({
          lsp = {
            progress = { enabled = false },
            hover = { enabled = true },
            signature = { enabled = true },
            message = { enabled = true },
            documentation = {
              view = "hover",
              opts = { border = "rounded" },
            },
          },

          presets = {
            bottom_search = true,       -- classic bottom cmdline
            command_palette = true,     -- grouped cmdline & popupmenu
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true,
          },

          views = {
            cmdline_popup = {
              position = {
                row = "30%",
                col = "50%",
              },
              size = {
                width = 60,
                height = "auto",
              },
            },
            popupmenu = {
              relative = "editor",
              position = {
                row = "40%",
                col = "50%",
              },
              size = {
                width = 60,
                height = 10,
              },
              border = {
                style = "rounded",
                padding = { 1, 2 },
              },
            },
          }
        })

      vim.keymap.set("n", "<leader>nh", function()
        require("noice").cmd("history")
      end, { desc = "Noice Message History" })

      vim.keymap.set("n", "<leader>nm", "<cmd>Noice<CR>", { desc = "Noice Menu" })
      vim.keymap.set("n", "<leader>nl", "<cmd>Noice last<CR>", { desc = "Last message" })
      vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<CR>", { desc = "Dismiss messages" })

      vim.notify = require("notify")
      '';
      }
      {
        plugin = fidget-nvim;
        type = "lua";
        config = ''
        require("fidget").setup({
          progress = {
            suppress_on_insert = false,
            ignore_done_already = true,
            ignore_empty_message = true,

            display = {
              render_limit = 8,
              done_ttl = 3,   -- remove completed tasks after 3 seconds
            },
          },
          notification = {
            window = {
              border = "rounded",
            },
          },
          logger = {
            level = vim.log.levels.WARN,
          },
        })
      '';
      }
      {
        plugin = toggleterm-nvim;
        type = "lua";
        config = ''
        require('toggleterm').setup {
          open_mapping = [[<leader>vv]],
          auto_scroll = true,
        }
      '';
      }
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
      '';
      }
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = ''
        require('nvim-web-devicons').setup()
      '';
      }
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
        require("nvim-autopairs").setup({
            disable_filetype = { "TelescopePrompt", "vim" },
            disable_in_macro = false,
            disable_in_visualblock = false,
            ignored_next_char = "[%w%.]", -- ignore letters & dot
            enable_moveright = true,
            enable_afterquote = true,
            enable_check_bracket_line = true,
            enable_bracket_in_quote = true,
            map_bs = true,
            map_c_h = false,
            map_c_w = false,
        })
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")

        cmp.event:on(
          "confirm_done",
        cmp_autopairs.on_confirm_done()
        )
      '';
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
        local ibl = require("ibl")

        ibl.setup({
          indent = {
          char = "│",
          },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
        },
        })

      local hooks = require "ibl.hooks"

      hooks.register(
        hooks.type.SCOPE_HIGHLIGHT,
        hooks.builtin.scope_highlight_from_extmark
      )

      ibl.setup({
        exclude = {
          filetypes = {
          "help",
          "dashboard",
          "lazy",
          "neo-tree",
          "NvimTree",
          "Trouble",
          },
        },
      })      

      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
                    }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup { indent = { highlight = highlight } }

      local highlight = {
        "CursorColumn",
        "Whitespace",
                                              }
      require("ibl").setup {
        indent = { highlight = highlight, char = "" },
          whitespace = {
            highlight = highlight,
            remove_blankline_trail = false,
          },
          scope = { enabled = false },
      }
      '';
      }
      {
        plugin = lazydev-nvim;
        type = "lua";
        config = ''
        require("lazydev").setup({
          library = {
            -- load runtime Neovim Lua types for completion
            { path = "vim.env", words = { "vim" } },
            { path = "nvim-lua/plenary.nvim" },
          },
        })

      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        }
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
      '';
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp_luasnip
      {
        plugin = nvim-cmp;
        type= "lua";
        config = ''
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
         snippet = {
           expand = function(args)
             require("luasnip").lsp_expand(args.body)
           end,
         },
         mapping = cmp.mapping.preset.insert({
           ['<C-b>'] = cmp.mapping.scroll_docs(-4),
           ['<C-f>'] = cmp.mapping.scroll_docs(4),
           ['<C-Space>'] = cmp.mapping.complete(),
           ['<C-e>'] = cmp.mapping.abort(),
           ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
         }),
         sources = cmp.config.sources({
           { name = "nvim_lsp" },
           { name = "luasnip" },
         }, {
           { name = "buffer" },
         }),
         cmp.setup.cmdline('/', {
           mapping = cmp.mapping.preset.cmdline(),
           sources = {
           { name = 'buffer' }
           }
         }),
         cmp.setup.cmdline(':', {
           mapping = cmp.mapping.preset.cmdline(),
           sources = cmp.config.sources({
               { name = 'path' }
           }, {
               { name = 'cmdline' }
           }),
           matching = { disallow_symbol_nonprefix_matching = false }
         }),
        })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("lspconfig").lua_ls.setup({
        capabilities = capabilities,
      })
      '';
      }
      {
        plugin = nvim-spider;
        type = "lua";
        config = ''
        require('spider').setup {
          subwordMovement = true,
        }

      vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>")
      vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
      vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>")
      '';
      }
      {
        plugin = nvim-surround;
        type = "lua";
        config = ''
        require('nvim-surround').setup{}
      '';
      }
      promise-async
      zoxide-vim
      {
        plugin = nvim-ufo;
        type = "lua";
        config = ''
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zr', require('ufo').closeAllFolds)

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
              dynamicRegistration = false,
                  lineFoldingOnly = true
                             }
        require('ufo').setup({	    
          provider_selector = function(bufnr, filetype, buftype)
            return {'treesitter', 'indent'}
          end
        })
      '';
      }
    ];
    extraLuaConfig = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '

      -- basic
      vim.o.number = true
      vim.o.cursorline = true
      vim.o.wrap = false
      vim.o.scrolloff = 10
      vim.o.sidescrolloff = 8

      -- indentation
      vim.o.tabstop = 2
      vim.o.softtabstop = 2
      vim.o.shiftwidth = 2
      vim.o.expandtab = true
      vim.o.smartindent = true
      vim.o.autoindent = true
      vim.o.breakindent = true -- Every wrapped line will continue visually indented.

      -- behavior
      vim.opt.hidden = true
      vim.opt.errorbells = false
      vim.opt.clipboard:append("unnamedplus")
      vim.opt.backspace = "indent,eol,start"
      vim.opt.autochdir = true
      vim.opt.mouse = 'a'
      vim.opt.path:append("**")
      --vim.opt.selection = "exclusive"
      vim.opt.modifiable = true
      vim.opt.encoding = "UTF-8"
      vim.opt.inccommand = 'split'
      vim.opt.confirm = true
      vim.opt.iskeyword:append("-")

      -- search
      vim.o.ignorecase = true
      vim.o.smartcase = true
      vim.o.hlsearch = true
      vim.o.incsearch = true

      -- visual settings
      vim.o.termguicolors = true
      vim.o.signcolumn = 'yes'
      --vim.o.colorcolumn = "100"
      vim.o.showmatch = true
      vim.o.cmdheight = 1
      vim.o.completeopt = "menuone,noinsert,noselect" 
      vim.o.showmode = false -- Don't show mode in command line.
      vim.o.pumheight = 10
      vim.o.conceallevel = 0
      vim.o.splitright = true
      vim.o.splitbelow = true
      vim.o.list = true
      vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

    -- file handling
      vim.o.backup = false
      vim.o.writebackup = false
      vim.o.swapfile = false
      vim.o.undofile = true
      vim.o.updatetime = 250
      vim.o.timeoutlen = 300
      vim.o.ttimeoutlen = 300
      vim.o.autoread = true
      vim.o.autowrite = false

      -- fold
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldlevel = 99

      -- Command-line completion
      vim.opt.wildmenu = true
      vim.opt.wildmode = "longest:full,full"
      vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })


      -- keybindings
      local wk = require("which-key")

      wk.add({
        mode = { "n", "v" },
        { "<leader> ", "<cmd>FzfLua files<cr>", desc = "Find File" },
        { "<leader>:", "<cmd>FzfLua commands<cr>", desc = "Find File" },

        { "<leader>b", group = "+buffer" },
        { "<leader>b[", "<cmd>bprevious<cr>", desc = "Previous Buffers" },
        { "<leader>b]", "<cmd>bnext<cr>", desc = "Previous Buffers" },
        { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffers" },
        { "<leader>bn", "<cmd>bnext<cr>", desc = "Previous Buffers" },
        { "<leader>bb", "<cmd>FzfLua buffers<cr>", desc = "All Buffers" },
        { "<leader>bo", "<cmd>e #<cr>", desc = "Other Buffer" },

        { "<leader>e", group = "+e" },

        { "<leader>f", group = "+file" },
        { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find File" },
        { "<leader>fd", "<cmd>FzfLua zoxide<cr>", desc = "Find Recent Directories" },
        { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Find File History" },

        { "<leader>h", group = "+h" },

        { "<leader>t", group = "+t" },

        { "<leader>v", group = "+v" },

        { "<leader>q", group = "+quit" },

        { "<leader>/", group = "+search" },
        { "<leader>//", "<cmd>FzfLua grep_visual<cr>", desc = "FZF visual grep" },
        })
      vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
      vim.keymap.set("n", "<C-g>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

      -- Resize window using <ctrl> arrow keys
      vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
      vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
      vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
      vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

      -- tabs
      vim.keymap.set("n", "<leader><tab>h", "<cmd>tabprevious<cr>")
      vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>")
      vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnew<cr>")
      vim.keymap.set("n", "<leader><tab>l", "<cmd>tabNext<cr>")

      -- Editing

      -- Move lines up/down
      vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
      vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
      vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
      vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

      -- better indenting
      vim.keymap.set("v", "<", "<gv")
      vim.keymap.set("v", ">", ">gv")

      -- quit
      vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

      local augroup = vim.api.nvim_create_augroup("UserConfig", {})

      -- Highlight yanked text
      vim.api.nvim_create_autocmd("TextYankPost", {
          group = augroup,
          callback = function()
          vim.highlight.on_yank()
          end,
      })

    -- Disable line numbers in terminal
      vim.api.nvim_create_autocmd("TermOpen", {
          group = augroup,
          callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = "no"
          end,
      })

    -- Create directories when saving files
      vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          callback = function()
          local dir = vim.fn.expand('<afile>:p:h')
          if vim.fn.isdirectory(dir) == 0 then
          vim.fn.mkdir(dir, 'p')
          end
          end,
      })
    '';
  };
}
