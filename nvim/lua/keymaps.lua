vim.api.nvim_set_keymap("i", "jj", "<Esc>", {noremap=false})

-- Files
vim.api.nvim_set_keymap("n", "QQ", ":q!<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "WW", ":w!<enter>", {noremap=false})
vim.api.nvim_set_keymap("n", "E", "$", {noremap=false})
vim.api.nvim_set_keymap("n", "B", "^", {noremap=false})
vim.api.nvim_set_keymap("n", "ss", ":noh<CR>", {noremap=true})

-- Splits
vim.api.nvim_set_keymap("n", "<C-W>,", ":vertical resize -10<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<C-W>.", ":vertical resize +10<CR>", {noremap=true})
vim.keymap.set('n', '<space><space>', "<cmd>set nohlsearch<CR>")
vim.keymap.set("n", "<leader>qq", ":q<CR>", {silent = true, noremap = true})

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Word wrap navigation
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Twilight
vim.api.nvim_set_keymap("n", "tw", ":Twilight<enter>", {noremap=false})
