-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- Leader keys (must be set before loading lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.updatetime = 250
vim.opt.clipboard = "unnamedplus"

-- Detect system dark/light theme (GNOME/GTK)
local function detect_background()
  local result = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null")
  if vim.v.shell_error == 0 and result:match("prefer%-dark") then
    return "dark"
  elseif vim.v.shell_error == 0 then
    return "light"
  end
  return "dark"
end

vim.o.background = detect_background()

-- Keymaps
require("config.keymaps")

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "default" } },
  checker = { enabled = true, notify = false },
})

-- Silently update plugins on startup (deferred so it doesn't block UI)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      require("lazy").update({ show = false })
    end, 1000)
  end,
})

-- Transparent background (lets Ghostty's opacity show through)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for _, group in ipairs({ "Normal", "NormalFloat", "NormalNC", "SignColumn", "EndOfBuffer" }) do
      vim.cmd("hi " .. group .. " guibg=NONE ctermbg=NONE")
    end
  end,
})

vim.cmd.colorscheme("default")
