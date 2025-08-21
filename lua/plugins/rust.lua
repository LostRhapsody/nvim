return {
	-- Rust Language Support
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end
	},
        {
		'mrcjkb/rustaceanvim',
		version = '^6', -- Recommended
	  	lazy = false, -- This plugin is already lazy
 	},
	-- Cargo.toml dependency management
	{
		"saecki/crates.nvim",
		ft = {"rust", "toml" },
		config = function()
			require("crates").setup({
				text = {
					loading = "   Loading",
					version = "   %s",
					prerelease = "   %s",
					yanked = "   %s",
					nomatch = "   No match",
					upgrade = "   %s",
					error = "   Error fetching crate",
				},
			})
		end,
	},
}

