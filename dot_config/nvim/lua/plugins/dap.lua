return {
    {
        "mfussenegger/nvim-dap",
        keys = {
            { "<leader>d",  "",                                                                                   desc = "+debug",                 mode = { "n", "v" } },
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
            { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
            { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
            { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
            { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
            { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
            { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
            { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
            { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
        },
        dependencies = {
            {
                "nvim-telescope/telescope-dap.nvim",
                config = function()
                    require('telescope').load_extension('dap')
                end
            },
            {
                "rcarriga/nvim-dap-ui",
                opts = {},
                config = function(_, opts)
                    local dap, dapui = require("dap"), require("dapui")
                    dapui.setup(opts)

                    -- Open and close dap ui when we start/stop debugging
                    dap.listeners.after.event_initialized["dapui_config"] = function()
                        dapui.open()
                    end
                    dap.listeners.before.event_terminated["dapui_config"] = function()
                        dapui.close()
                    end
                    dap.listeners.before.event_exited["dapui_config"] = function()
                        dapui.close()
                    end
                end,
                keys = {
                    { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                    { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
                },
            },
            {
                "theHamsta/nvim-dap-virtual-text",
                dependencies = {
                    "nvim-treesitter/nvim-treesitter"
                },
                opts = {}
            },
            {
                "jayp0521/mason-nvim-dap.nvim",
                dependencies = {
                    "williamboman/mason.nvim",
                },
                cmd = { "DapInstall", "DapUninstall" },
                opts = {
                    ensure_installed = { "codelldb" }
                }
            },
        },
        config = function()
            local dap = require("dap")

            -- Signs
            vim.fn.sign_define("DapStopped",
                { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" })
            vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointCondition", {
                text = " ",
                texthl = "DiagnosticInfo",
                linehl = "",
                numhl =
                ""
            })
            vim.fn.sign_define("DapBreakpointRejected", {
                text = " ",
                texthl = "DiagnosticError",
                linehl = "",
                numhl =
                ""
            })
            vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo", linehl = "", numhl = "" })

            -- Adapters config
            local function get_codelldb()
                local mason_registry = require "mason-registry"
                local codelldb = mason_registry.get_package "codelldb"
                local extension_path = codelldb:get_install_path() .. "/extension/"
                local codelldb_path = extension_path .. "adapter/codelldb"
                local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
                return codelldb_path, liblldb_path
            end
            local codelldb_path, _ = get_codelldb()

            dap.adapters.codelldb = {
                type = 'server',
                port = "${port}",
                executable = {
                    command = codelldb_path,
                    args = { "--port", "${port}" },
                },
            }

            -- Language configuration
            dap.configurations.cpp = {
                {
                    name = 'Launch file',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    args = {},

                    -- 💀
                    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
                    --
                    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
                    --
                    -- Otherwise you might get the following error:
                    --
                    --    Error on launch: Failed to attach to the target process
                    --
                    -- But you should be aware of the implications:
                    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
                    -- runInTerminal = false,
                },
            }

            dap.configurations.c = dap.configurations.cpp

            dap.configurations.rust = {
                {
                    name = 'Launch debug',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        local metadata_json = vim.fn.system "cargo metadata --format-version 1 --no-deps"
                        local metadata = vim.fn.json_decode(metadata_json)
                        local target_name = metadata.packages[1].targets[1].name
                        local target_dir = metadata.target_directory
                        return target_dir .. "/debug/" .. target_name
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                    sourceLanguages = { "rust" },
                },
            }
        end,
    },
}
