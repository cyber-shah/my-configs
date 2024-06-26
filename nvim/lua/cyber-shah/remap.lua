vim.g.mapleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.wo.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.showtabline = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.api.nvim_set_keymap("n", "<S-T>", ":tabnext<CR>", { noremap = true })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "[l]azy [g]it" })

vim.keymap.set("n", "<leader>fm", "<cmd>set foldmethod=manual<cr>", { desc = "[f]old [m]anual" })
vim.keymap.set("n", "<leader>fi", "<cmd>set foldmethod=indent<cr>", { desc = "[f]old [i]ndent" })

vim.keymap.set("n", "<C-w>D", "<cmd>bdelete<CR>", { desc = "[b]uffer [D]elete" })

vim.keymap.set({ "n", "v" }, "<Leader>cB", "<Cmd>CBccbox7<CR>", { desc = "[c]omment [d]ouble box" })
vim.keymap.set({ "n", "v" }, "<Leader>cb", "<Cmd>CBccbox<CR>", { desc = "[c]omment [b]ox" })
vim.keymap.set({ "n", "v" }, "<Leader>ct", "<Cmd>CBlcline2<CR>", { desc = "[c]omment [t]itle" })
vim.keymap.set({ "n", "v" }, "<Leader>cc", "<Cmd>CBlcline15<CR>", { desc = "[c]omment [c]omment" })
vim.keymap.set("n", "<Leader>cl", "<Cmd>CBline<CR>", { desc = "[c]omment [l]ine" })
vim.keymap.set({ "n", "v" }, "<Leader>cq", "<Cmd>CBllbox18<CR>", { desc = "[c]omment [q]uote" })
vim.keymap.set("n", "<leader>cn", "/\\S\\zs\\s*╭<CR>zt", { desc = "[c]omment [n]ext" })
vim.keymap.set("n", "<leader>cN", "?\\S\\zs\\s*╭<CR>zt", { desc = "[c]omment [N] previous" })

-- vim.keymap.set("n", "<leader>n", "<cmd>Navbuddy<cr>", { desc = "[N]avbuddy" })

vim.keymap.set("n", "<leader>lj", "<cmd>%!jq .<cr>", { desc = "[l]sp format [j]son (uses `jq`)" })
