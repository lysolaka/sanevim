-- Completion Plugins --

-- completion type icons for cmp-nvim
local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}

-- completion source names for cmp-nvim
local source_names = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  luasnip = "[LuaSnip]",
  path = "[Path]",
  vimtex = "[VimTeX]",
  nvim_lsp_signature_help = "",
}

return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    version = "v2.*",
    build = "make install_jsregexp",
    opts = {
      update_events = { "TextChanged", "TextChangedI" },
      delete_check_events = "TextChanged",
      cut_selection_keys = "<Tab>",
    },
    config = function(_, opts)
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_lua").lazy_load({
        paths = vim.fn.stdpath("config") .. "/snippets/",
      })
    end,
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
    opts = function()
      local cmp = require("cmp")
      local ls = require("luasnip")

      return {
        preselect = cmp.PreselectMode.Item,
        expand = function(args)
          ls.lsp_expand(args.body)
        end,
        mapping = {
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if ls.expandable() then
                ls.expand()
              else
                cmp.confirm({ select = true })
              end
            else
              fallback()
            end
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-J>"] = cmp.mapping(function(fallback)
            if ls.locally_jumpable(1) then
              ls.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-K>"] = cmp.mapping(function(fallback)
            if ls.locally_jumpable(-1) then
              ls.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        formatting = {
          format = function(entry, item)
            item.kind = ("%s %s"):format(kind_icons[item.kind], item.kind)
            item.menu = source_names[entry.source.name]
            return item
          end,
        },
        sources = cmp.config.sources(
          {
            { name = "luasnip" },
          },
          {
            { name = "nvim_lsp" },
            { name = "vimtex" },
          },
          {
            { name = "buffer" },
            { name = "path" },
            { name = "nvim_lsp_signature_help" },
          }
        )
      }
    end,
  },
}
