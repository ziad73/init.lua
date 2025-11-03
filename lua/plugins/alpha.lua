return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- 🌀 Header
    dashboard.section.header.val = {
      [[                                                   ]],
      [[                                              ___  ]],
      [[                                           ,o88888 ]],
      [[                                        ,o8888888' ]],
      [[                  ,:o:o:oooo.        ,8O88Pd8888"  ]],
      [[              ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"    ]],
      [[            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"      ]],
      [[           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"        ]],
      [[          , ..:.::o:ooOoOO8O888O8O,COCOO"          ]],
      [[         , . ..:.::o:ooOoOOOO8OOOOCOCO"            ]],
      [[          . ..:.::o:ooOoOoOO8O8OCCCC"o             ]],
      [[             . ..:.::o:ooooOoCoCCC"o:o             ]],
      [[             . ..:.::o:o:,cooooCo"oo:o:            ]],
      [[          `   . . ..:.:cocoooo"'o:o:::'            ]],
      [[          .`   . ..::ccccoc"'o:o:o:::'             ]],
      [[         :.:.    ,c:cccc"':.:.:.:.:.'              ]],
      [[       ..:.:"'`::::c:"'..:.:.:.:.:.'               ]],
      [[     ...:.'.:.::::"'    . . . . .'                 ]],
      [[    .. . ....:."' `   .  . . ''                    ]],
      [[  . . . ...."'                                     ]],
      [[  .. . ."'                                         ]],
      [[ .                                                 ]],
      [[                                                   ]],
    }
    -- 🗂️ Buttons
    dashboard.section.buttons.val = {
      dashboard.button('SPC sf', '  Search Files', ':Telescope find_files<CR>'),
      dashboard.button('SPC sg', '  Live Search Grep', ':Telescope live_grep<CR>'),
      dashboard.button('SPC sb', '󰓩  Search Buffers', ':Telescope buffers<CR>'),
      dashboard.button('SPC e', '  File Explorer', ':Neotree toggle position=left<CR>'),
      dashboard.button('SPC q', '  Quit Neovim', ':qa<CR>'),
    }

    alpha.setup(dashboard.opts)

    -- ⚙️ Always show Alpha when starting with no files or a directory
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        local arg = vim.fn.argv(0)
        if arg == '' then
          -- launched with just `nvim`
          require('alpha').start(true)
        elseif vim.fn.isdirectory(arg) == 1 then
          -- launched with `nvim .`
          vim.cmd 'enew' -- open empty buffer
          vim.cmd 'Alpha' -- launch dashboard
          vim.cmd 'bd#' -- close the directory buffer
        end
      end,
    })
  end,
}
