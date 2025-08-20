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
