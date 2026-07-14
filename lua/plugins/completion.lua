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
  path = "[Path]",
  vimtex = "[VimTeX]",
  nvim_lsp_signature_help = "",
}

return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    opts = function()
      local cmp = require("cmp")

      return {
        preselect = cmp.PreselectMode.Item,
        mapping = {
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
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
