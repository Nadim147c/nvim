local config_dir = vim.fn.stdpath "config"

return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  config = function()
    local fzf = require "fzf-lua"
    fzf.setup {
      winopts = {
        height = 0.8,
        width = 0.8,
        preview = {
          horizontal = "right:50%",
        },
      },
      fzf_colors = {
        ["gutter"] = "-1",
      },
    }

    ---@param key string
    ---@param func function
    ---@param desc string
    local function map(key, func, desc)
      vim.keymap.set("n", "<leader>f" .. key, func, { desc = "fzf " .. desc })
    end

    -- stylua: ignore start
    map("f", fzf.files, "files")
    map("a", function() fzf.files { raw_cmd = "find" } end, "all files")
    map("b", fzf.buffers, "buffers")
    map("g", fzf.git_files, "git files")
    map("l", fzf.git_commits, "git commits")
    map("q", fzf.quickfix, "quickfix")
    map("w", fzf.live_grep, "live grep")
    map("s", fzf.grep_curbuf, "current buffer")
    map("v", fzf.highlights, "highlights")
    map("h", fzf.help_tags, "help")
    map("c", function() fzf.files { cwd = config_dir } end, "config files")
    -- stylua: ignore end
  end,

  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(items, opts, on_choice)
      local ui_select = require "fzf-lua.providers.ui_select"

      -- Register the fzf-lua picker the first time we call select.
      if not ui_select.is_registered() then
        ui_select.register(function(ui_opts)
          if ui_opts.kind == "luasnip" then
            ui_opts.prompt = "Snippet choice: "
            ui_opts.winopts = { relative = "cursor", height = 0.35, width = 0.3 }
          elseif ui_opts.kind == "lsp_message" then
            ui_opts.winopts = { height = 0.4, width = 0.4 }
          else
            ui_opts.winopts = { height = 0.6, width = 0.5 }
          end

          return ui_opts
        end)
      end

      -- Don't show the picker if there's nothing to pick.
      if #items > 0 then
        return vim.ui.select(items, opts, on_choice)
      end
    end
  end,
}
