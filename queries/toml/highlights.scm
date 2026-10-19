; extends

; Distinguish table headers from ordinary key/value properties. The small
; priority bump wins over the upstream @property captures on the same key nodes.
((table
  (dotted_key) @type)
  (#set! priority 105))

((table_array_element
  (bare_key) @type)
  (#set! priority 105))
