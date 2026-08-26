-- Runs automatically whenever a markdown buffer opens.

-- Visual guide at column 80. A bare "80" draws the highlight *on* column 80.
vim.opt_local.colorcolumn = "80"

-- prettier does the wrapping on save, but textwidth lets you also reflow a
-- paragraph by hand with the `gw` motion (e.g. `gwip` = reflow the paragraph
-- under the cursor) so manual tidy-ups match what save will do.
vim.opt_local.textwidth = 80
