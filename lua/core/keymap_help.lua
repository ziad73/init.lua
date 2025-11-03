-- Keymap Help Popup (grouped by sections)
-- Author: Ziad El-Sayed
-- date:1 Nov 2025
-- version: v2
-- Usage: require("keymap_help").open()

local M = {}

local sections = {
  General = {
    { 'jj', 'Exit insert mode' },
    { '<C-s>', '[C]trl + [S]ave file' },
    { '<leader>sn', '[S]ave [N]o-format (no autoformat)' },
    { '<C-q>', '[Q]uit current buffer' },
    { '<Space>', 'Disable default Space behavior' },
    { '<leader>lw', 'Toggle [L]ine [W]rapping' },
    { '<leader>+ / <leader>-', 'Increment / Decrement numbers' },
    { '<Esc>', 'Clear search highlights' },
    { '<C-d> / <C-u>', 'Scroll half page and center' },
    { 'n / N', 'Search next / previous and center' },
    { 'j / k', 'Move through wrapped lines' },
    { 'x', 'Delete char without copying to register' },
    { '<C-i>', 'Restore jump forward' },
  },

  Folding = {
    { 'zc', 'Close current fold' },
    { 'zo', 'Open current fold' },
    { '<leader>zc', 'Close all folds' },
    { '<leader>zo', 'Open all folds' },
  },

  Buffers = {
    { '<Tab> / <S-Tab>', 'Next / Previous [B]uffer' },
    { '<leader>x', 'Close [B]uffer' },
    { '<leader>b', 'New empty [B]uffer' },
    { '<leader>ss', '[S]ave [S]ession' },
    { '<leader>sl', '[S]ession [L]oad' },
  },

  Windows = {
    { '<leader>v', 'Split [V]ertical' },
    { '<leader>h', 'Split [H]orizontal' },
    { '<leader>se', '[S]plit [E]qualize size' },
    { '<leader>xs', 'Close [S]plit' },
    { '<C-h>/<C-j>/<C-k>/<C-l>', 'Move between splits' },
    { '<Up>/<Down>/<Left>/<Right>', 'Resize splits' },
  },

  Tabs = {
    { '<leader>to', '[T]ab [O]pen new' },
    { '<leader>tx', '[T]ab e[X]it' },
    { '<leader>tn / <leader>tp', '[T]ab [N]ext / [P]rev' },
  },

  Clipboard = {
    { '<leader>y / yy / Y', '[Y]ank to system clipboard' },
    { 'v + p', '[P]aste without overwriting register' },
  },

  Editing = {
    { '<A-j> / <A-k>', 'Move selected text down/up' },
    { '< / >', '[I]ndent / [D]edent keeping selection' },
    { '<leader>rw', 'Replace word under cursor globally' },
  },

  Diagnostics = {
    { '<leader>do', '[D]iagnostics [O]n/Off toggle' },
    { '[d / ]d', 'Prev / Next [D]iagnostic' },
    { '<leader>d', 'Show [D]iagnostic popup' },
    { '<leader>q', '[Q]uickfix diagnostic list' },
  },

  LSP = {
    { 'gd', '[G]oto [D]efinition' },
    { 'gr', '[G]oto [R]eferences' },
    { 'gI', '[G]oto [I]mplementation' },
    { '<leader>D', '[T]ype [D]efinition' },
    { '<leader>ds', '[D]ocument [S]ymbols' },
    { '<leader>ws', '[W]orkspace [S]ymbols' },
    { 'K', '[K] Hover documentation' },
    { '<leader>rn', '[R]e[n]ame symbol' },
    { '<leader>ca', '[C]ode [A]ction' },
    { '<leader>wa / <leader>wr / <leader>wl', '[W]orkspace [A]dd / [R]emove / [L]ist folders' },
    { '<leader>th', '[T]oggle inlay [H]ints' },
  },

  Neotree = {
    { '<leader>w', '[W]indow Float File Explorer' },
    { '<leader>e', '[E]xplorer Left Panel' },
    { '<leader>ngs', '[N]eoTree [G]it [S]tatus' },
  },

  ['Telescope Files'] = {
    { '<leader>sf', '[S]earch [F]iles' },
    { '<leader>sb', '[S]earch [B]uffers' },
    { '<leader>so', '[S]earch [O]ldfiles (recent)' },
    { '<leader>/', 'Fuzzy search in current buffer' },
    { '<leader><tab> / <leader><leader>', 'Quick [B]uffer switch' },
  },

  ['Telescope Git'] = {
    { '<leader>gf', '[G]it [F]iles' },
    { '<leader>gs', '[G]it [S]tatus' },
    { '<leader>gc / <leader>gcf / <leader>gb', '[G]it [C]ommits / File Commits / [B]ranches' },
  },

  ['Telescope Search'] = {
    { '<leader>sg', '[S]earch by [G]rep' },
    { '<leader>sw', '[S]earch current [W]ord' },
    { '<leader>s/', '[S]earch [/] in open files' },
    { '<leader>sd', '[S]earch [D]iagnostics' },
    { '<leader>sds', '[S]earch LSP [D]ocument [S]ymbols' },
    { '<leader>sm', '[S]earch [M]arks' },
    { '<leader>sh', '[S]earch [H]elp tags' },
    { '<leader>sr', '[S]earch [R]esume previous' },
  },

  Treesitter = {
    { '<leader>tsu', '[T]ree[S]itter [U]pdate parsers' },
    { '<C-Space>', '[C]ontrol + [Space] incremental select' },
    { '<C-s>', '[C]ontrol + [S]cope select' },
    { '<M-Space>', '[M]eta + [Space] deselect node' },
    { 'aa / ia', '[A]rg outer / inner' },
    { 'af / if', '[F]unction outer / inner' },
    { 'ac / ic', '[C]lass outer / inner' },
    { ']m / [m / ]] / [[', 'Move between functions/classes' },
    { '<leader>a / <leader>A', 'Swap parameters next / previous' },
  },

  Autocompletion = {
    { '<C-Space>', '[C]ompletion trigger' },
    { '<CR>', '[Enter] accept completion' },
    { '<C-j> / <C-k>', 'Select [N]ext / [P]revious completion' },
    { '<C-l> / <C-h>', 'Jump [L]aterally in snippet' },
    { '<C-c>', '[C]omplete manually' },
    { '<Tab> / <S-Tab>', '[Tab] cycle through completions/snippets' },
  },

  vim_tmux_navigator = {
    { '<C-h>/<C-j>/<C-k>/<C-l>', 'Navigate splits + tmux panes' },
  },
}

function M.open()
  local buf = vim.api.nvim_create_buf(false, true)

  local width = 76
  local total_lines = 4
  for _, maps in pairs(sections) do
    total_lines = total_lines + #maps + 2
  end

  local win_opts = {
    relative = 'editor',
    width = width,
    height = total_lines,
    row = math.floor((vim.o.lines - total_lines) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = 'minimal',
    border = 'rounded',
  }

  local win = vim.api.nvim_open_win(buf, true, win_opts)

  local lines = { ' Keymap Help:', '' }
  for section, maps in pairs(sections) do
    table.insert(lines, section .. ':')
    for _, m in ipairs(maps) do
      table.insert(lines, string.format(' %-32s — %s', m[1], m[2]))
    end
    table.insert(lines, '')
  end
  table.insert(lines, 'Press <ESC> to close')

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  vim.keymap.set('n', '<ESC>', function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, silent = true })
end

return M
