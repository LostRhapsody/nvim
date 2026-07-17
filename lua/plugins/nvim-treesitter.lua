return {
  "nvim-treesitter/nvim-treesitter",
  -- `main` is the rewrite that supports Neovim 0.12+. The old `master`
  -- branch is locked and explicitly does not support 0.12, which caused
  -- the `node:range (nil value)` highlight crash.
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup()

    -- Parsers to keep installed (main-branch install is async).
    local parsers = {
      "typescript", "javascript", "tsx",
      "vue",
      "python",
      "yaml", "json", "toml",
      "bash",
      "lua", "rust",
    }
    ts.install(parsers)

    -- Highlighting is provided by Neovim itself on the main branch: start
    -- the treesitter highlighter per buffer via a FileType autocommand.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "typescript", "javascript", "javascriptreact", "typescriptreact",
        "vue",
        "python",
        "yaml", "json", "jsonc", "toml",
        "sh", "bash",
        "lua", "rust",
      },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
