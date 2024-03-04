return {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "jayp0521/mason-null-ls.nvim",
    config = function()
        local mason_null_ls = require("mason-null-ls")

        mason_null_ls.setup({
            ensure_installed = {
                "prettier",
                -- "stylua",
                -- "eslint_d",
            },
        })

        local null_ls = require("null-ls")

        local formatting = null_ls.builtins.formatting
        -- local diagnostics = null_ls.builtins.diagnostics

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup({
            sources = {
                formatting.prettier.with({
                    extra_args = function(params)
                        return params.options
                            and params.options.tabSize
                            and {
                                "--tab-width",
                                params.options.tabSize,
                            }
                    end,
                }),
                -- formatting.stylua,
                -- diagnostics.eslint_d,
            },
            -- configure format on save
            on_attach = function(current_client, bufnr)
                if current_client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({
                                filter = function(client)
                                    -- only use null-ls for formatting instead of lsp server
                                    return client.name == "null-ls"
                                end,
                                bufnr = bufnr,
                            })
                        end,
                    })
                end
            end,
        })
    end,
}
