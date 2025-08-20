-- Grug Far search and replace launch
vim.keymap.set(
'n', 
'<leader>sr',
function () require('grug-far').toggle_instance(
	{ 
		instanceName = "far", 
		staticTitle = "Find and Replace"
	}
	) 
end, {desc = 'Search and Replace'})

-- Window navigation with Ctrl + h/j/k/l
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Window splitting
vim.keymap.set('n', '<leader>|', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>-', '<C-w>s', { desc = 'Split window horizontally' })


