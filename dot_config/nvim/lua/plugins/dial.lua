return {
  {
    "monaqa/dial.nvim",
  -- stylua: ignore
  keys = {
    { "<C-a>",  function() require("dial.map").inc_normal() end,  mode = "n", desc = "Increment normal mode" },
    { "<C-x>",  function() require("dial.map").dec_normal() end,  mode = "n", desc = "Decrement normal mode" },
    { "<C-a>",  function() require("dial.map").inc_visual() end,  mode = "v", desc = "Increment visual mode" },
    { "<C-x>",  function() require("dial.map").dec_visual() end,  mode = "v", desc = "Decrement visual mode" },
    { "g<C-a>", function() require("dial.map").inc_gvisual() end, mode = "v", desc = "Increment global visual mode" },
    { "g<C-x>", function() require("dial.map").dec_gvisual() end, mode = "v", desc = "Decrement global visual mode" },
  },
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal_int,
          augend.constant.alias.bool,
          augend.integer.alias.hex,
          augend.integer.alias.octal,
          augend.integer.alias.binary,
          augend.semver.alias.semver,
          augend.date.alias["%d/%m/%y"],
          augend.date.alias["%d/%m/%Y"],
        },
      }
    end,
  },
}
