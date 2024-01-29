return {
    {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = {'mfussenegger/nvim-dap'}
    },
    'mfussenegger/nvim-dap',
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
