; extends

; HEEx tag textobjects for injected HEEx inside ~H sigils
; These will only match when inside injected HEEx code
[
  (tag)
  (self_closing_tag)
  (component)
  (self_closing_component)
  (slot)
  (self_closing_slot)
] @tag.outer

(tag
  (start_tag)
  .
  (_)* @tag.inner
  .
  (end_tag))

(component
  (start_component)
  .
  (_)* @tag.inner
  .
  (end_component))

(slot
  (start_slot)
  .
  (_)* @tag.inner
  .
  (end_slot))
