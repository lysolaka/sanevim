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

return {
  ["LuaSnip"] = {
    history = true,
    delete_check_events = "TextChanged",
    update_events = "TextChanged,TextChangedI",
  },
  ["neogen"] = {
    input_after_comment = false,
    languages = {
      rust = {
        template = {
          annotation_convention = "rustdoc",
        },
      },
    },
  },
  ["nvim-cmp"] = function()
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
          elseif ls.locally_jumpable(1) then
            ls.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif ls.locally_jumpable(-1) then
            ls.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        -- ["<ESC>"] = cmp.mapping.close(),
      },
      formatting = {
        format = function(entry, item)
          item.kind = ("%s %s"):format(kind_icons[item.kind], item.kind)
          item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            path = "[Path]",
            vimtex = item.menu,
            nvim_lsp_signature_help = "",
          })[entry.source.name]
          return item
        end,
      },
      sources = cmp.config.sources(
        {
          { name = "nvim_lsp" }, { name = "luasnip" }
        },
        {
          { name = "vimtex" }, { name = "buffer" }, { name = "path" }
        },
        {
          { name = "nvim_lsp_signature_help" }
        }
      )
    }
  end,
}
