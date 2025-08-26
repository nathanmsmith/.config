; inherits: jsx

(jsx_element) @scope.tag

(jsx_opening_element
  name: (_) @open.tag)

(jsx_closing_element
  name: (_) @close.tag
  (#offset! @close.tag 0 -1 0 0))

(jsx_self_closing_element
  name: (_) @open.selftag
  "/>" @close.selftag) @scope.selftag
