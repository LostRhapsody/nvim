return {
  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup({
        transparent_background = false,
        terminal_colors = true,
        devicons = true,
        styles = {
          comment = { italic = true },
          keyword = { italic = true },

          type = { italic = true },

          storageclass = { italic = true },

          structure = { italic = true },
          parameter = { italic = true },
          annotation = { italic = true },

          tag_attribute = { italic = true },
        },

        filter = "pro", -- pro | octagon | machine | ristretto | spectrum | classic
        background_clear = { "telescope" }, -- Clear background for telescope
        inc_search = "background",
      })

      -- Set as active colorscheme
      vim.cmd([[colorscheme monokai-pro]])
    end
  }
}

