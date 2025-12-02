return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui', -- Debugger UI panels (variables, breakpoints, stack, etc.)
    'nvim-neotest/nvim-nio', -- Needed by dap-ui

    -- Installs the debug adapters for you
    'williamboman/mason.nvim', -- Package manager
    'jay-babu/mason-nvim-dap.nvim', -- Installs debug adapters automatically

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go', -- Go debugging support (optional)
    -- 'mfussenegger/nvim-dap-python', -- Python debugging support
    'mfussenegger/nvim-dap', -- Core debugging engine

    'theHamsta/nvim-dap-virtual-text', -- Shows variable values inline in the code
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'debugpy', -- Python
        -- 'delve', -- Go
        'codelldb', -- C/C++/Rust
        -- 'js-debug-adapter', -- JavaScript/TypeScript
      },
    }

    -- C / C++ / Rust debugger configuration using codelldb
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb',
        args = { '--port', '${port}' },
      },
    }

    dap.configurations.c = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        console = 'integratedTerminal', -- this makes printf work
      },
    }

    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = dap.configurations.c

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Continue / Start' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Step Over' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Step Into' })
    vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Step Out' })
    vim.keymap.set('n', '<F6>', dap.terminate, { desc = 'Terminate' })
    vim.keymap.set('n', '<leader>dr', dap.restart, { desc = 'Restart' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Run Last Debug' })
    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Toggle DAP UI' })
    vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint, { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup()
    require('nvim-dap-virtual-text').setup()
    -- require('dap-python').setup()
  end,
}
