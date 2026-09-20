-- tinymist Configuration --

return {
  settings = {
    exportPdf = "onSave",
    formatterIndentSize = 4,
    formatterMode = "typstyle",
    formatterPrintWidth = 80,
    formatterProseWrap = "fill",
    lint = {
      enabled = true,
      when = "onSave",
    },
  },
}
