vim.keymap.set("n", "<C-s>", "<CMD>w<CR>", { desc = "Save the current buffer" })

-- Enter Command Mode with ;
vim.keymap.set({ "n", "v" }, ";", ":", { desc = "CMD enter command mode" })
vim.keymap.set("n", "<Esc>", "<CMD>noh<CR>", { desc = "Remove search highlight" })

-- Switch window
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- Move selected part with indent
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Merge the next line with current one without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "p", [["_dP]], { desc = "Put without losing current yank" })
vim.keymap.set("n", "<leader>sr", ":%s/", { desc = "Search and replace for this buffer" })
vim.keymap.set("x", "<leader>sr", ":s/", { desc = "Search and replace for this select" })

vim.keymap.set({ "n", "v" }, "<leader>ls", "<CMD> source % <CR>", { desc = "Reload the current lua file" })

-- Lazy keymaps
vim.keymap.set({ "n", "v" }, "<leader>lR", ":Lazy reload", { desc = "Reload a lazy plugin" })
vim.keymap.set({ "n", "v" }, "<leader>lS", ":Lazy sync", { desc = "Sync all lazy plugin" })

vim.keymap.set("n", ",", "N", { desc = "go to previousa highlight" })
vim.keymap.set("n", ".", "n", { desc = "go to next highlight" })

vim.keymap.set("n", "n", "^", { desc = "go to start of the line" })
vim.keymap.set("n", "m", "$", { desc = "go to end of the line" })

vim.keymap.set("n", "dn", "d^", { desc = "delete from start of the line" })
vim.keymap.set("n", "dm", "d$", { desc = "detete to end of the line" })

vim.keymap.set("n", "yn", "y^", { desc = "yank from start of the line" })
vim.keymap.set("n", "ym", "y$", { desc = "yank to end of the line" })

vim.keymap.set("n", "vn", "v^", { desc = "select from start of the line" })
vim.keymap.set("n", "vm", "v$", { desc = "select to end of the line" })
