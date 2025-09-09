return {
  ["tokyonight"] = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      -- floats = "transparent",
    },
    style = "night",
  },
  ["neo-tree"] = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
  },
  ["lualine"] = {
    options = {
      component_separators = { left = "│", right = "│" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "neo-tree" },
      always_divide_middle = false,
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          "filename",
          path = 1,
        },
      },
      lualine_c = { "branch",
        {
          "diagnostics",
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
      },
      lualine_x = { "selectioncount", "searchcount" },
      lualine_y = { "location" },
      lualine_z = { "progress" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "progress" },
      lualine_y = {},
      lualine_z = {}
    },
  },
}
