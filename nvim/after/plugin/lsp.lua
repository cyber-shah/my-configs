-- Setup language servers.
local lspconfig = require("lspconfig")
local navbuddy = require("nvim-navbuddy")

local function on_attach(client, bufnr)
	navbuddy.attach(client, bufnr)
	require("lsp_signature").on_attach(signature_setup, bufnr)
end

-- List of language servers to setup
local servers = {
	{
		lsp = lspconfig.lua_ls,
		config = {},
	},
	{
		lsp = lspconfig.clangd,
		config = {
			on_attach = on_attach,
		},
	},
	{
		lsp = lspconfig.pyright,
		config = {
			on_attach = on_attach,
		},
	},
	{
		lsp = lspconfig.tsserver,
		config = {
			on_attach = on_attach,
		},
	},
	{
		lsp = lspconfig.gopls,
		config = {
			on_attach = on_attach,
		},
	},
}

-- Setup each language server
for _, server in ipairs(servers) do
	server.lsp.setup(server.config)
end
--
-- lspconfig.lua_ls.setup({})
--
-- lspconfig.clangd.setup({
-- 	on_attach = function(client, bufnr)
-- 		navbuddy.attach(client, bufnr)
-- 		require("lsp_signature").on_attach(signature_setup, bufnr)
-- 	end,
-- })
--
-- lspconfig.pyright.setup({
-- 	on_attach = function(client, bufnr)
-- 		navbuddy.attach(client, bufnr)
-- 		require("lsp_signature").on_attach(signature_setup, bufnr)
-- 	end,
-- })
--
-- lspconfig.tsserver.setup({
-- 	on_attach = function(client, bufnr)
-- 		print("ts signature attach")
-- 		navbuddy.attach(client, bufnr)
-- 		require("lsp_signature").on_attach(signature_setup, bufnr) -- Note: add in lsp client on-attach
-- 	end,
-- })
--
-- lspconfig.gopls.setup({
-- 	on_attach = function(client, bufnr)
-- 		print("go pls attach")
-- 		navbuddy.attach(client, bufnr)
-- 		require("lsp_signature").on_attach(signature_setup, bufnr) -- Note: add in lsp client on-attach
-- 	end,
-- 	settings = {
-- 		gopls = {
-- 			gofumpt = true,
-- 		},
-- 	},
-- })
--
-- lspconfig.rust_analyzer.setup({
-- 	-- Server-specific settings. See `:help lspconfig-setup`
-- 	settings = {
-- 		["rust-analyzer"] = {},
-- 	},
-- })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})
