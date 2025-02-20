require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "v" }, "<leader>q", "<cmd> q <cr>")
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("i", "jj", "<ESC>")



-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
