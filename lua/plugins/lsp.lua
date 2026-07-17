return {
  -- LSP server definitions (nvim-lspconfig populates vim.lsp.config for each server)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",   -- TypeScript / JavaScript
          "vue_ls",  -- Vue (Volar v2)
          "pyright", -- Python
          "yamlls",  -- YAML
          "jsonls",  -- JSON
          "taplo",   -- TOML
          "bashls",  -- Bash / Shell
        },
      })

      local caps = require("blink.cmp").get_lsp_capabilities()

      -- Keymaps applied whenever any LSP attaches (modern Nvim 0.11 pattern)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
          end
          map("gd",         vim.lsp.buf.definition,    "Go to definition")
          map("gD",         vim.lsp.buf.declaration,   "Go to declaration")
          map("gi",         vim.lsp.buf.implementation,"Go to implementation")
          map("K",          vim.lsp.buf.hover,         "Hover docs")
          map("gr",         vim.lsp.buf.references,    "References")
          map("<leader>rn", vim.lsp.buf.rename,        "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action,   "Code action")
          map("<leader>f",  vim.lsp.buf.format,        "Format buffer")
          map("[d",         vim.diagnostic.goto_prev,  "Prev diagnostic")
          map("]d",         vim.diagnostic.goto_next,  "Next diagnostic")
          map("<leader>e",  vim.diagnostic.open_float, "Diagnostic float")
        end,
      })

      -- ts_ls needs the Vue TypeScript plugin so vue_ls hybrid mode works
      local vue_plugin_path = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/@vue/typescript-plugin"

      vim.lsp.config("ts_ls", {
        capabilities = caps,
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        init_options = {
          plugins = {
            { name = "@vue/typescript-plugin", location = vue_plugin_path, languages = { "vue" } },
          },
        },
      })

      -- All other servers just need capabilities merged in
      local servers = { "vue_ls", "pyright", "yamlls", "jsonls", "taplo", "bashls" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = caps })
      end

      vim.lsp.enable(vim.list_extend({ "ts_ls" }, servers))
    end,
  },

  -- Completion
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = { preset = "default" },
      appearance = { nerd_font_variant = "mono" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
