;;;; Text and images to put inside controls.

(defclass cell ()
  (object-value :accessor object-value)
  (has-valid-object-value-p :accessor has-valid-object-value-p)
  (int-value)
  (integer-value)
  (string-value)
  (double-value)
  (float-value)
  (cell-attributes)
  (cell-type); :null-cell :text-cell :image-cell
  (enabledp)
  (allows-undo-p)
  (bezeledp :accessor bezeledp)
  (borderedp :accessor borderedp)
  (opaquep :accessor opaquep)
  (background-style); :raised :lowered :normal :emphasized
  (interior-background-style)
  (allows-mixed-state)
  (next-state) ; :on :off :mixed
  (state)      ; :on :off :mixed
  (editablep)
  (selectablep)
  (scrollablep)
  (alignment) ; :left :right :center :justified :natural
  (font)
  (line-break-mode); :break-by-word-wrapping :break-by-char-wrapping :break-by-clipping :break-by-truncating-head :break-by-truncating-tail :break-by-truncating-middle
  (trunates-last-visible-line-p)
  (wrapsp)
  (base-writing-direction)
  (attributed-string-value)
  (allows-editing-text-attributes-p)
  (imports-graphics-p)
  ;setUpFieldEditorAttributes
  (title)
  (action)
  (target)
  (continuousp)
  ;sendActionOn
  (image)
  (tag)
  (formatter)
  (default-menu)
  (menu)
  ;menuForEvent:inRect:ofView
  ;compare
  (accepts-first-responder-p)
  (shows-first-responder-p)
  (refuses-first-responder-p)
  ;performClick
  )