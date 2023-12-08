return {
  "nvim-treesitter/nvim-treesitter-angular",
  lazy = true,
  config = function()
    require("nvim-treesitter.configs").setup({
      angular = {
        enable = true,
        disable = {},
        -- disable = { "javascript", "typescript" },
        -- is_supported = true,
      },
    })
  end,
}
