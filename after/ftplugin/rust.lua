local bufnr = vim.api.nvim_get_current_buf()
-- rust code actions for leader a, shows quick fixes and things
vim.keymap.set(

  "n", 
  "<leader>a", 
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)

-- rust shift K action, jumps to defininitions
vim.keymap.set(
  "n", 
  "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({'hover', 'actions'})
  end,
  { silent = true, buffer = bufnr }
)

-- rust run code action
vim.keymap.set(
	"n",
	"<leader>r",
	function()
		vim.cmd.RustLsp('run')
	end,
	{ silent = true, buffer = bufnr }
)
