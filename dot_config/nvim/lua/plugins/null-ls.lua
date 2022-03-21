local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- Python
		null_ls.builtins.formatting.black,
		null_ls.builtins.diagnostics.pylama,
		null_ls.builtins.formatting.reorder_python_imports,

		-- Shell
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.shellharden,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.code_actions.shellcheck,

		-- CSS
		null_ls.builtins.formatting.stylelint,
		null_ls.builtins.diagnostics.stylelint,

		-- C/C++
		-- null_ls.builtins.formatting.uncrustify, -- Java and C# too
		null_ls.builtins.diagnostics.cppcheck,

		-- Others
        -- null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.nginx_beautifier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.terraform_fmt,
		null_ls.builtins.diagnostics.hadolint, -- Dockerfiles
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.formatting.golines, -- Includes gofmt and goimports
		null_ls.builtins.formatting.mix, -- Elixir
	},
})

