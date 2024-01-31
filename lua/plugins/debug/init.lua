return {
    {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = {'mfussenegger/nvim-dap'}
    },
    {
        'mfussenegger/nvim-dap',
        config = function ()
            local dap = require('dap')

            dap.adapters.php = {
                type = "executable",
                command = "node",
                args = { os.getenv("HOME") .. "/Software/vscode-php-debug/out/phpDebug.js" }
            }

            dap.configurations.php = {
                {
                    type = "php",
                    request = "launch",
                    name = "Listen for Xdebug",
                    port = 9003
                }
            }
            vim.keymap.set('n', '<Leader>tl', function() require('dap').continue() end, {desc = "Debug: Listen/Next Breakpoint"})
            vim.keymap.set('n', '<Leader>to', function() require('dap').step_over() end, {desc = "Debug: Step Over"})
            vim.keymap.set('n', '<Leader>ti', function() require('dap').step_into() end, {desc = "Debug: Step Into"})
            vim.keymap.set('n', '<Leader>te', function() require('dap').step_out() end, {desc = "Debug: Step Out"})
            vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, {desc = 'Toggle Breakpoint'})
            vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end, {desc = 'Set Breakpoint'})
            vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
            vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
            vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        keys = {
            {
                "<leader>du",
                function()
                    require("dapui").toggle()
                end,
                silent = true,
            },
        },
        opts = {
            mappings = {
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            layouts = {
                -- {
                --   elements = {
                --     { id = "repl", size = 0.30 },
                --     { id = "console", size = 0.70 },
                --   },
                --   size = 0.19,
                --   position = "bottom",
                -- },
                {
                    elements = {
                        { id = "scopes", size = 0.50 },
                        { id = "breakpoints", size = 0.20 },
                        { id = "stacks", size = 0.20 },
                        { id = "watches", size = 0.10 },

                    },
                    size = 0.20,
                    position = "left",
                },
            },
            controls = {
                enabled = true,
                element = "repl",
            },
            floating = {
                max_height = 0.9,
                max_width = 0.5,
                border = vim.g.border_chars,
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
        },
        config = function(_, opts)
            -- local icons = require("core.icons").dap
            -- for name, sign in pairs(icons) do
            --   ---@diagnostic disable-next-line: cast-local-type
            --   sign = type(sign) == "table" and sign or { sign }
            --   vim.fn.sign_define("Dap" .. name, { text = sign[1] })
            -- end
            require("dapui").setup(opts)
        end,
    }
}
