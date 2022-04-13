(in-package :dexter)

(defstruct event
  "An XEvent"
  display
  event-key
  event-code
  send-event-p
  code
  sequence
  time
  root
  window
  child
  root-x
  root-y
  x
  y
  state
  same-screen-p
  hint-p
  kind
  mode
  focus-p
  keymap
  width
  height
  count
  drawable
  minor
  major
  parent
  border-width
  override-redirect-p
  configure-p
  above-sibling
  stack-mode
  value-mask
  atom
  event-window
  selection
  requestor
  target
  property
  colormap
  new-p
  installed-p
  format
  type
  data
  request
  start)

(defgeneric key-press (responder event) ; code sequence time root window child root-x root-y x y state same-screen-p)
  (:documentation ""))
(defgeneric key-release (responder event); code sequence time root window child root-x root-y x y state same-screen-p)
  (:documentation ""))
(defgeneric button-press (responder event);code sequence time root window child root-x root-y x y state same-screen-p)
  (:documentation ""))
(defgeneric button-release (responder event); code sequence time root window child root-x root-y x y state same-screen-p)
  (:documentation ""))
(defgeneric motion-notify (responder event); hint-p sequence time root window child root-x root-y x y state same-screen-p)
  (:documentation ""))
(defgeneric enter-notify (responder event); kind sequence time root window child root-x root-y x y state mode focus-p same-screen-p)
  (:documentation ""))
(defgeneric leave-notify (responder event); kind sequence time root window child root-x root-y x y state mode focus-p same-screen-p)
  (:documentation ""))
(defgeneric focus-in (responder event); kind sequence window mode)
  (:documentation ""))
(defgeneric focus-out (responder event); kind sequence window mode)
  (:documentation ""))
(defgeneric keymap-notify (responder event); keymap)
  (:documentation ""))
(defgeneric exposure (responder event); sequence window x y width height count)
  (:documentation ""))
(defgeneric graphics-exposure (responder event); sequence drawable x y width height minor count major)
  (:documentation ""))
(defgeneric no-exposure (responder event); sequence drawable minor major)
  (:documentation ""))
(defgeneric visibility-notify (responder event); sequence window state)
  (:documentation ""))
(defgeneric create-notify (responder event); sequence parent window x y width height border-width override-redirect-p)
  (:documentation ""))
(defgeneric destroy-notify (responder event); sequence window)
  (:documentation ""))
(defgeneric unmap-notify (responder event); sequence window configure-p)
  (:documentation ""))
(defgeneric map-notify (responder event); sequence window override-redirect-p)
  (:documentation ""))
(defgeneric map-request (responder event); sequence parent window)
  (:documentation ""))
(defgeneric reparent-notify (responder event); sequence window parent x y override-redirect-p)
  (:documentation ""))
(defgeneric configure-notify (responder event); sequence window above-sibling x y width height border-width override-redirect-p)
  (:documentation ""))
(defgeneric configure-request (responder event); stack-mode sequence parent window above-sibling x y width height border-width value-mask)
  (:documentation ""))
(defgeneric property-notify (responder event); sequence window event-window atom time state)
  (:documentation ""))
(defgeneric selection-clear (responder event); sequence time window selection)
  (:documentation ""))
(defgeneric selection-request (responder event); sequence time window requestor selection target property)
  (:documentation ""))
(defgeneric selection-notify (responder event); sequence time window selection target property)
  (:documentation ""))
(defgeneric colormap-notify (responder event); sequence window colormap new-p installed-p)
  (:documentation ""))
(defgeneric client-message (responder event); format sequence window type data)
  (:documentation ""))
(defgeneric mapping-notify (responder event); sequence request start count)
  (:documentation ""))

(defclass responder ()
  ((id :accessor id
       :initarg :id
       :initform ""
       :type string
       :documentation "A string ID for the responder.")))