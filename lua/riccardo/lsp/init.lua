local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "riccardo.lsp.lsp-installer"
require("riccardo.lsp.handlers").setup()
require "riccardo.lsp.null-ls"
