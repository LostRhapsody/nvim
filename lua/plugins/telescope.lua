return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require('telescope').setup({})
    require('telescope').load_extension('fzf')

    -- telescope 0.1.x previews via nvim-treesitter.configs/parsers, both gone on
    -- treesitter's main branch. Use the native API instead; false falls back to
    -- telescope's regex highlighter.
    local putils = require('telescope.previewers.utils')
    putils.ts_highlighter = function(bufnr, ft)
      local lang = vim.treesitter.language.get_lang(ft) or ft
      return pcall(vim.treesitter.start, bufnr, lang)
    end

    vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
    vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Live grep' })
    vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Buffers' })
    vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Help tags' })
  end,
}
