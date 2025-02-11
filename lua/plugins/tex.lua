return {
  "lervag/vimtex",
  ft = "tex",
  init = function()
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = "-pdf",
      pdflatex = "-pdf",
      lualatex = "-pdflua",
      xelatex = "-xelatex -pdfxe"
    }
    vim.g.vimtex_view_general_viewer = "qpdfview"
    vim.g.vimtex_view_general_options = "--unique @pdf#src:@tex:@line:@col"
  end
}
