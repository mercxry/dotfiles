local dap = require("dap")

-- Signs
vim.fn.sign_define("DapStopped", { text="󰁕 ", texthl="DiagnosticWarn", linehl="DapStoppedLine", numhl="DapStoppedLine" })
vim.fn.sign_define("DapBreakpoint", { text=" ", texthl="DiagnosticInfo", linehl="", numhl="" })
vim.fn.sign_define("DapBreakpointCondition", { text=" ", texthl="DiagnosticInfo", linehl="", numhl="" })
vim.fn.sign_define("DapBreakpointRejected", { text=" ", texthl="DiagnosticError", linehl="", numhl="" })
vim.fn.sign_define("DapLogPoint", { text=".>", texthl="DiagnosticInfo", linehl="", numhl="" })

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
