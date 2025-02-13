-- QOL Plugins --

local cfg = require("config.plugins.completion")

return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    version = "v2.*",
    build = "make install_jsregexp",
    opts = cfg["LuaSnip"],
    config = function(_, opts)
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_lua").lazy_load({
        paths = vim.fn.stdpath("config") .. "/lua/snippets/",
      })
    end,
  },
  {
    "danymat/neogen",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>na", "<cmd>Neogen<CR>" }
    },
    opts = cfg["neogen"],
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = cfg["nvim-cmp"],
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)
      cmp.setup.filetype({ "tex" }, {
        sources = cmp.config.sources(
          {
            { name = "luasnip" }
          },
          {
            { name = "vimtex" }, { name = "nvim_lsp" }
          },
          {
            { name = "buffer" }, { name = "path" }
          }
        )
      })
    end
  },
}
