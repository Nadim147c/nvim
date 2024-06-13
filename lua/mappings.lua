vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "File save" })

-- Enter Command Mode with ;
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "CMD enter command mode" })
vim.keymap.set("n", "<Esc>", "<CMD>noh<CR>", { desc = "Remove search highlight" })

-- Move selected part with indent
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Merge the next line with current one without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Put without losing current yank" })
vim.keymap.set("n", "<leader>sr", ":%s/", { desc = "Search and replace for this buffer" })

vim.keymap.set({ "n", "v" }, "<leader>ls", "<CMD> source % <CR>", { desc = "Reload the current lua file" })

-- Lazy keymaps
vim.keymap.set({ "n", "v" }, "<leader>lR", ":Lazy reload", { desc = "Reload a lazy plugin" })
vim.keymap.set({ "n", "v" }, "<leader>lS", ":Lazy sync", { desc = "Sync all lazy plugin" })
