; extends

; Keep existing function textobjects
(tag) @function.outer

(tag
  (start_tag)
  .
  (_) @function.inner
  .
  (end_tag))

(tag
  (start_tag)
  _+ @function.inner
  (end_tag))

(attribute_value) @attribute.inner
(attribute) @attribute.outer

; Add tag textobjects
[
  (tag)
  (self_closing_tag)
  (component)
  (self_closing_component)
  (slot)
  (self_closing_slot)
] @tag.outer

; Inner content of tags
(tag
  (start_tag)
  .
  (_)* @tag.inner
  .
  (end_tag))

; Inner content of components
(component
  (start_component)
  .
  (_)* @tag.inner
  .
  (end_component))

; Inner content of slots
(slot
  (start_slot)
  .
  (_)* @tag.inner
  .
  (end_slot))
