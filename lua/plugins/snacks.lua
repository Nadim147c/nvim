local supported =
  { "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "heic", "avif", "mp4", "mov", "avi", "mkv", "webm" }
local config_dir = vim.fn.stdpath "config"

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    picker = {
      layout = {
        cycle = true,
        preset = function() return vim.o.columns >= 120 and "default" or "vertical" end,
      },
      matcher = {
        fuzzy = true, -- use fuzzy matching
        smartcase = true, -- use smartcase
        ignorecase = true, -- use ignorecase
        sort_empty = false, -- sort results when the search string is empty
        filename_bonus = true, -- give bonus for matching file names (last part of the path)
        file_pos = true, -- support patterns like `file:line:col` and `file:line`
        cwd_bonus = false, -- give bonus for matching files in the cwd
        frecency = true, -- frecency bonus
        history_bonus = true, -- give more weight to chronological order
      },
    },
    bigfile = { enabled = true },
    image = {
      formats = supported,
      force = true,
      markdown = {
        enabled = true,
        max_width = 80,
        max_height = 40,
      },
    },
    dashboard = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Picker: Buffers" },
    {
      "<leader>fc",
      function() Snacks.picker.files { cwd = config_dir } end,
      desc = "Picker: Find Config File",
    },
    { "<leader>fn", function() Snacks.picker.files() end, desc = "Picker: Find Files" },
    {
      "<leader>ff",
      function()
        Snacks.picker.pick("files", {
          cmd = "rg",
          args = { "--files", "--hidden", "--color=never", "--glob=!.git" },
        })
      end,
      desc = "Picker: Find Git Files",
    },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Picker: Recent" },

    -- Git logs
    { "<leader>fgb", function() Snacks.picker.git_branches() end, desc = "Picker: Git Branches" },
    { "<leader>fgl", function() Snacks.picker.git_log() end, desc = "Picker: Git Log" },
    { "<leader>fgL", function() Snacks.picker.git_log_line() end, desc = "Picker: Git Log Line" },
    { "<leader>fgs", function() Snacks.picker.git_status() end, desc = "Picker: Git Status" },
    { "<leader>fgS", function() Snacks.picker.git_stash() end, desc = "Picker: Git Stash" },
    { "<leader>fgd", function() Snacks.picker.git_diff() end, desc = "Picker: Git Diff (Hunks)" },
    { "<leader>fgf", function() Snacks.picker.git_log_file() end, desc = "Picker: Git Log File" },

    -- Live grep
    { "<leader>fsb", function() Snacks.picker.grep_buffers() end, desc = "Picker: Grep Open Buffers" },
    { "<leader>fsg", function() Snacks.picker.grep() end, desc = "Picker: Grep" },
    { "<leader>fsw", function() Snacks.picker.git_grep() end, desc = "Picker: Git grep" },
    { "<leader>fw", function() Snacks.picker.git_grep() end, desc = "Picker: Git grep" },
  },
}
