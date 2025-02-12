return {
  {
    "lervag/vimtex",
    ft = "tex",
    init = function()
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-pdf --shell-escape",
        pdflatex = "-pdf --shell-escape",
        lualatex = "-pdflua --shell-escape",
        xelatex = "-xelatex -pdfxe --shell-escape"
      }
      vim.g.vimtex_view_general_viewer = "qpdfview"
      vim.g.vimtex_view_general_options = "--unique @pdf#src:@tex:@line:@col"
    end,
  },
  {
    "micangl/cmp-vimtex",
    ft = "tex",
  },
}
