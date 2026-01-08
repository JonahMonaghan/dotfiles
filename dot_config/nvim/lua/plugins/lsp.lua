return {
    -- 1. Mason (The Tool Manager)
    "williamboman/mason.nvim",
    dependencies = {
        "hrsh7th/nvim-cmp",         -- Autocompletion plugin
        "hrsh7th/cmp-nvim-lsp",     -- LSP source for cmp
        "L3MON4D3/LuaSnip",         -- Snippets source
    },
    config = function()
        -- Setup Mason (adds tools to your path)
        require("mason").setup()

        local cmp = require("cmp")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- Setup Autocompletion (The Menu)
        cmp.setup({
            snippet = {
                expand = function(args) require("luasnip").lsp_expand(args.body) end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
            }),
        })

        -- START THE SERVERS (Native Method)

        -- 1. C++ (clangd)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "c", "cpp", "objc", "objcpp" },
            callback = function(args)
                -- Logic: Try to find a project root, fallback to current folder if single file
                local root_dir = vim.fs.root(args.buf, { ".git", "compile_commands.json", "Makefile" })
                if not root_dir then
                    root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf))
                end

                vim.lsp.start({
                    name = "clangd",
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                    },
                    root_dir = root_dir,
                    capabilities = capabilities,
                })
            end,
        })

        -- 2. Lua (lua-language-server)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "lua" },
            callback = function(args)
                local root_dir = vim.fs.root(args.buf, { ".git", ".luarc.json" }) or vim.loop.cwd()
                vim.lsp.start({
                    name = "lua_ls",
                    cmd = { "lua-language-server" },
                    root_dir = root_dir,
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = { globals = { "vim" } },
                        },
                    },
                })
            end,
        })

	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "pico8" },
		callback = function(args)
			local root_dir = vim.fs.root(args.buf, { ".git", "*.p8"})
			if not root_dir then
				root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf))
			end

			vim.lsp.start({
				name = "pico8_ls",
				cmd = { "pico8-ls", "--stdio" },
				root_dir = root_dir,
				capabilities = capabilities,
			})
		end,
	})

        -- Keymaps (Only load when LSP attaches)
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            end,
        })
    end,
}
