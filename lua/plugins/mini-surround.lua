-- source: https://www.youtube.com/watch?v=96FS45IaUgo

return {
  'kylechui/nvim-surround',
  version = '^3.0.0',
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {
      keymaps = {
        insert = false,
        insert_line = false,

        -- NORMAL MODE
        normal = false, -- disable y s <motion>
        normal_cur = 'ys', -- ys<char> surrounds the whole line
        normal_line = false,
        normal_cur_line = false,

        -- VISUAL MODE
        visual = 'S', -- S<char> surrounds selection
        visual_line = false,

        -- DISABLE delete/change for now
        delete = false,
        change = false,
      },
    }

    -- --- Instant Visual Surrounds ---
    vim.keymap.set('x', '(', 'S(', { remap = true, desc = 'Surround selection with ()' })
    vim.keymap.set('x', '"', 'S"', { remap = true, desc = 'Surround selection with ""' })
    vim.keymap.set('x', "'", "S'", { remap = true, desc = "Surround selection with ''" })
    vim.keymap.set('x', '`', 'S`', { remap = true, desc = 'Surround selection with ``' })
    vim.keymap.set('x', '[', 'S[', { remap = true, desc = 'Surround selection with []' })
    vim.keymap.set('x', '{', 'S{', { remap = true, desc = 'Surround selection with {}' })
  end,
}
