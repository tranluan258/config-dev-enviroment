local opt = vim.opt -- for conciseness

--spell checker in vim
opt.spelllang = "en_us"
opt.spell = true

-- disable copilot default
vim.g.copilot_disable = true
vim.filetype.add({ extension = { templ = "templ" } })

-- title
-- opt.title = false -- set title of window to the value of the titlestring option

opt.showtabline = 0 -- hide tabline

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentations
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- config background color dynamically
local function setBgColor()
  local time = os.date("*t")
  if time.hour >= 6 and time.hour < 18 then
    opt.background = "light"
    vim.cmd.colorscheme("catppuccin")
    -- vim.cmd.colorscheme("cyberdream")
  else
    opt.background = "dark"
    vim.cmd.colorscheme("catppuccin")
    -- vim.cmd.colorscheme("cyberdream")
  end
end

setBgColor()
