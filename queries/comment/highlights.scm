; Taken from: https://github.com/nvim-treesitter/nvim-treesitter/blob/568ede7e79172a0fe7c9d631454a97ad968deaf2/runtime/queries/comment/highlights.scm
; Tweaks:
; 1. change priorities to 130, which makes the tree-sitter-comment highlights to display above LSP comment semantic tokens
; 2. change user highlight group to @attribute from @constant

((tag
  (name) @comment.todo @nospell
  ("(" @punctuation.bracket
    (user) @attribute
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.todo "TODO" "WIP")
  (#set! priority 130))

("text" @comment.todo @nospell
  (#any-of? @comment.todo "TODO" "WIP")
  (#set! priority 130))

((tag
  (name) @comment.note @nospell
  ("(" @punctuation.bracket
    (user) @attribute
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.note "NOTE" "XXX" "INFO" "DOCS" "PERF" "TEST")
  (#set! priority 130))

("text" @comment.note @nospell
  (#any-of? @comment.note "NOTE" "XXX" "INFO" "DOCS" "PERF" "TEST")
  (#set! priority 130))

((tag
  (name) @comment.warning @nospell
  ("(" @punctuation.bracket
    (user) @attribute
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.warning "HACK" "WARNING" "WARN" "FIX")
  (#set! priority 130))

("text" @comment.warning @nospell
  (#any-of? @comment.warning "HACK" "WARNING" "WARN" "FIX")
  (#set! priority 130))

((tag
  (name) @comment.error @nospell
  ("(" @punctuation.bracket
    (user) @attribute
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.error "FIXME" "BUG" "ERROR")
  (#set! priority 130))

("text" @comment.error @nospell
  (#any-of? @comment.error "FIXME" "BUG" "ERROR")
  (#set! priority 130))

("text" @number
  (#lua-match? @number "^#[0-9]+$")
  (#set! priority 130))

(uri) @string.special.url @nospell
