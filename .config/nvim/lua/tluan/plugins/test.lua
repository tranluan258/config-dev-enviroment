return {
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = function(_, opts)
      table.insert(opts.adapters, require("neotest-jest"))
    end,
  },
}
