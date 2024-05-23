vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "File save" })

-- Enter Command Mode with ;
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "CMD enter command mode" })

-- Move selected part with indent
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Merge the next line with current one without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Put without losing current yank" })
vim.keymap.set("n", "<leader>sr", ":%s/", { desc = "Search and replace for this buffer" })

vim.keymap.set({ "n", "v" }, "<leader>ls", "<CMD> source % <CR>", { desc = "Reload the current lua file" })

-- Tabufine
-- local tabufline = require("nvchad.tabufline")
-- vim.keymap.set("n", "<tab>", function() tabufline.next() end, { desc = "Buffer goto next" })
-- vim.keymap.set("n", "<S-tab>", function() tabufline.prev() end, { desc = "Buffer goto prev" })
-- vim.keymap.set("n", "<leader>x", function() tabufline.close_buffer() end, { desc = "Buffer close" })

-- Comments

-- whichkey
