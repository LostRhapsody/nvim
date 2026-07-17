return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    require('mini.pairs').setup()
    require('mini.surround').setup()
    require('mini.hipatterns').setup({
      highlighters = {
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
        todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
        note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
        -- Highlight hex colors inline
        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
      },
    })
  end,
}
