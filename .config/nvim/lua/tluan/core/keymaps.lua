-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------
keymap.set("i", "<C-c>", "esc")

-- n N
keymap.set("n", "n", "nzzzv", { desc = "Move to next search result" })
keymap.set("n", "N", "Nzzzv", { desc = "Move to next search result" })

-- Select all
keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

keymap.set("v", "<leader>p", '"_dP', { desc = "Paste without overwriting clipboard" })
keymap.set("n", "<leader>p", '"_dP', { desc = "Paste without overwriting clipboard" })
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set("i", "<C-c>", "<ESC>", { desc = "Exit insert mode with <C-c>" })

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')
--
-- move up/down by visual lines
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- tmux navigation
keymap.set("n", "<C-h>", "<C-w-h>", { desc = "Navigate left" })
keymap.set("n", "<C-j>", "<C-w-j>", { desc = "Navigate down" })
keymap.set("n", "<C-k>", "<C-w-k>", { desc = "Navigate up", silent = true })
keymap.set("n", "<C-l>", "<C-w-l>", { desc = "Navigate right", silent = true })

-- lazygit
-- keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open lazygit" })

--undo tree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
