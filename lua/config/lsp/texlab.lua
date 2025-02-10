local engines = {
  pdf = {
    executable = "latexmk",
    args = {
      "-pdf",
      "-interaction=nonstopmode",
      "-synctex=1",
      "-pv",
      "%f"
    },
  },
  lua = {
    executable = "latexmk",
    args = {
      "-pdflua",
      "-interaction=nonstopmode",
      "-synctex=1",
      "-pv",
      "%f"
    },
  },
  xet = {
    executable = "latexmk",
    args = {
      "-xelatex",
      "-pdfxe",
      "-interaction=nonstopmode",
      "-synctex=1",
      "-pv",
      "%f"
    },
  },
}

return {
  settings = {
    texlab = {
      build = {
        executable = engines.pdf.executable,
        args = engines.pdf.args,
        forwardSearchAfter = true,
        onSave = false,
      },
      chcktex = {
        onEdit = true,
        onOpenAndSave = true,
      },
      forwardSearch = {
        executable = "qpdfview",
        args = { "--unique", "%p#src:%f:%l:1" },
      },
    },
  },
  -- commands = {
  --   TexlabBuild = {
  --     require("texbuild").build,
  --     description = "Build the current buffer",
  --   },
  -- },
}
