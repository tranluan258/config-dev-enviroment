return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji", "hrsh7th/cmp-nvim-lsp" },
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }
    opts.completion = {
      completeopt = "menu,menuone,noinsert",
    }

    table.insert(opts.sources, { name = "emoji" })
  end,
}
