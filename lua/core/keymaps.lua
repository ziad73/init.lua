-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Toggle/Expand folds with Treesitter
-- zc   → close current block/fold
-- zo   → open current block/fold
-- <leader>zc  → close all blocks/folds
-- <leader>zo  → open all blocks/folds
-- vim.opt.foldmethod = 'expr'
vim.opt.foldmethod = 'manual'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = true
vim.opt.foldlevel = 99

-- For conciseness
local opts = { noremap = true, silent = true } -- no remap kaymap cannot be redefined, silent means command not shown in CLI

-- jj as Esc
vim.keymap.set('i', 'jj', '<Esc>', opts)

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
vim.keymap.set('n', '<Esc>', ':noh<CR>', opts)

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts) --'<cmd>' enter cmd mode, w save , '<CR>' enter

-- save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>', opts) --sn save a file not formated

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Resize with arrows
-- vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
-- vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
-- vim.keymap.set('n', '<Left>', ':vertical resize +2<CR>', opts)
-- vim.keymap.set('n', '<Right>', ':vertical resize -2<CR>', opts)

-- Buffers(files)

-- Navigate between buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts) -- <S-Tab> shift tab
vim.keymap.set('n', '<C-i>', '<C-i>', opts) -- to restore jump forward

vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', opts) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', opts) -- decrement

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits(tmux navigator)
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Move text up and down (normal mode)
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', opts) -- <A-j> Alt j
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', opts)

-- Move text up and down (insert mode)
-- vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
-- vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)

-- Move text up and down (visual mode)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Replace word under cursor in whole file
-- case insenstive
-- vim.keymap.set('n', '<leader>rw', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { desc = 'Replace word globally' })
vim.keymap.set('n', '<leader>rw', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left><Left>', { desc = 'Replace word globally' })

-- Yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+yy', { desc = 'Yank line to system clipboard' })

-- Toggle(hide) diagnostics(errors & warnings)
local diagnostics_active = true

-- on/off
vim.keymap.set('n', '<leader>do', function()
  diagnostics_active = not diagnostics_active

  if diagnostics_active then
    vim.diagnostic.enable(true)
  else
    vim.diagnostic.enable(false)
  end
end)

-- Move between diagnostic(errors & warnings)
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic(error) message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic(error) message' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Save and load session
vim.keymap.set('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })

-- URL: Open under cursor
vim.keymap.set('n', '<leader>uo', function()
  local url = vim.fn.expand '<cfile>'
  if url ~= '' then
    vim.fn.jobstart({ 'xdg-open', url }, { detach = true }) -- Linux
    -- macOS: {'open', url}
    -- Windows: {'cmd.exe','/C','start',url}
  else
    print 'No URL detected'
  end
end, { desc = 'Open URL under cursor' })

-- URL: Copy under cursor
vim.keymap.set('n', '<leader>uy', function()
  local url = vim.fn.expand '<cfile>'
  if url ~= '' then
    vim.fn.setreg('+', url) -- copy to system clipboard
    print('Copied URL: ' .. url)
  else
    print 'No URL detected'
  end
end, { desc = 'Copy URL under cursor' })
