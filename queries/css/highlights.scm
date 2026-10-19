; extends

; The upstream CSS query groups units and color literals as strings. Reclassify
; them at a slightly higher Tree-sitter priority; LSP semantics still win at 125.
((unit) @number
  (#set! priority 101))

((color_value) @constant
  (#set! priority 101))
