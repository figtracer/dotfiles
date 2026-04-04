require('dapui').setup()
require('nvim-dap-virtual-text').setup()
local dap = require('dap')
dap.defaults.fallback.terminal_win_cmd = 'belowright new'
vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#ff7b72' })
vim.api.nvim_set_hl(0, 'DapBreakpointLine', {})

-- Use the new extmarks-based signs
local sign = vim.fn.sign_define
sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint' })
sign('DapBreakpointCondition', { text = '◐', texthl = 'DapBreakpoint' })
sign('DapStopped', { text = '▶', texthl = 'DapBreakpoint' })

-- Debugger
vim.api.nvim_set_keymap("n", "<leader>dt", ":DapUiToggle<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>dc", ":DapContinue<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>dx", ":DapTerminate<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<Leader>do", ":DapStepOver<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>", {noremap=true})
