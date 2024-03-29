local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.setup = function()
  local signs = {

    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set
  keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)
  -- keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", opts)
  -- keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
  -- keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)
  keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
  keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap("n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  keymap("n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
  end

  if client.name == "sumneko_lua" then
    client.server_capabilities.document_formatting = false
  end

  lsp_keymaps(bufnr)

  local illuminate_status_ok, illuminate = pcall(require, "illuminate")
  if not illuminate_status_ok then
    return
  end
  illuminate.on_attach(client)

  local navic_status_ok, navic = pcall(require, "nvim-navic")
  if not navic_status_ok then
    return
  elseif client.name ~= "html" or client.name ~= "cssls"  then
    navic.attach(client, bufnr)
  end
end

return M
