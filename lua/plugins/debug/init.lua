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
            expand_lines = false,
            layouts = {
                {
                    elements = {
                        { id = "repl", size = 0.25 },
                        { id = "breakpoints", size = 0.25 },
                        { id = "stacks", size = 0.25 },
                        { id = "watches", size = 0.25 }
                    },
                    position = "left",
                    size = 40
                },
                {
                    elements = {
                        { id = "scopes",size = 1 },
                    },
                    position = "bottom",
                    size = 10
                }
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
            render = {
                max_type_length = 100,
                max_value_lines = 50
            }
        },
        config = function(_, opts)
            -- local icons = require("core.icons").dap
            -- for name, sign in pairs(icons) do
            --   ---@diagnostic disable-next-line: cast-local-type
            --   sign = type(sign) == "table" and sign or { sign }
            --   vim.fn.sign_define("Dap" .. name, { text = sign[1] })
            -- end
            require("dapui").setup(opts)
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup(opts)
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end,
    },
    {
        'leoluz/nvim-dap-go',
        config = function ()
            require('dap-go').setup {
                -- Additional dap configurations can be added.
                -- dap_configurations accepts a list of tables where each entry
                -- represents a dap configuration. For more details do:
                -- :help dap-configuration
                dap_configurations = {
                    {
                        -- Must be "go" or it will be ignored by the plugin
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                    },
                },
                -- delve configurations
                delve = {
                    -- the path to the executable dlv which will be used for debugging.
                    -- by default, this is the "dlv" executable on your PATH.
                    path = "dlv",
                    -- time to wait for delve to initialize the debug session.
                    -- default to 20 seconds
                    initialize_timeout_sec = 20,
                    -- a string that defines the port to start delve debugger.
                    -- default to string "${port}" which instructs nvim-dap
                    -- to start the process in a random available port
                    port = "${port}",
                    -- additional args to pass to dlv
                    args = {},
                    -- the build flags that are passed to delve.
                    -- defaults to empty string, but can be used to provide flags
                    -- such as "-tags=unit" to make sure the test suite is
                    -- compiled during debugging, for example.
                    -- passing build flags using args is ineffective, as those are
                    -- ignored by delve in dap mode.
                    build_flags = "",
                },
            }
        end
    },
}
