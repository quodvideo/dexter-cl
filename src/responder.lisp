;;;; The foundation of most of Dexter.

(in-package :dexter)
#|
  All events have:
    display: The X display.
    event-key: A lisp symbol matching the event.
    event-code: The numeric value of the event-key.
    send-event-p: Whether or not the event was sent from a client.
  All events except keymap-notify have:
    sequence: The sequence number of the event.
|#
(defgeneric key-press (responder event) ; code time root window child root-x root-y x y state same-screen-p)
  (:documentation ""))
(defgeneric key-release (responder event); code time root window child root-x root-y x y state same-screen-p)
  (:documentation ""))
(defgeneric button-press (responder event);code time root window child root-x root-y x y state same-screen-p)
  (:documentation ""))
(defgeneric button-release (responder event); code time root window child root-x root-y x y state same-screen-p)
  (:documentation ""))
(defgeneric motion-notify (responder event); hint-p time root window child root-x root-y x y state same-screen-p)
  (:documentation ""))
(defgeneric enter-notify (responder event); kind time root window child root-x root-y x y state mode focus-p same-screen-p)
  (:documentation ""))
(defgeneric leave-notify (responder event); kind time root window child root-x root-y x y state mode focus-p same-screen-p)
  (:documentation ""))
(defgeneric focus-in (responder event); kind window mode)
  (:documentation ""))
(defgeneric focus-out (responder event); kind window mode)
  (:documentation ""))
(defgeneric keymap-notify (responder event); keymap)
  (:documentation ""))
(defgeneric exposure (responder event); window x y width height count)
  (:documentation ""))
(defgeneric graphics-exposure (responder event); drawable x y width height minor count major)
  (:documentation ""))
(defgeneric no-exposure (responder event); drawable minor major)
  (:documentation ""))
(defgeneric visibility-notify (responder event); window state)
  (:documentation ""))
(defgeneric create-notify (responder event); parent window x y width height border-width override-redirect-p)
  (:documentation ""))
(defgeneric destroy-notify (responder event); window)
  (:documentation ""))
(defgeneric unmap-notify (responder event); window configure-p)
  (:documentation ""))
(defgeneric map-notify (responder event); window override-redirect-p)
  (:documentation ""))
(defgeneric map-request (responder event); parent window)
  (:documentation ""))
(defgeneric reparent-notify (responder event); window parent x y override-redirect-p)
  (:documentation ""))
(defgeneric configure-notify (responder event); window above-sibling x y width height border-width override-redirect-p)
  (:documentation ""))
(defgeneric configure-request (responder event); stack-mode parent window above-sibling x y width height border-width value-mask)
  (:documentation ""))
;(defgeneric gravity-notify (responder event) (:documentation ""))
;(defgeneric resize-request (responder event) (:documentation ""))
;(defgeneric circulate-notify (responder event) (:documentation ""))
;(defgeneric circulate-request (responder event) (:documentation ""))
(defgeneric property-notify (responder event); window event-window atom time state)
  (:documentation ""))
(defgeneric selection-clear (responder event); time window selection)
  (:documentation ""))
(defgeneric selection-request (responder event); time window requestor selection target property)
  (:documentation ""))
(defgeneric selection-notify (responder event); time window selection target property)
  (:documentation ""))
(defgeneric colormap-notify (responder event); window colormap new-p installed-p)
  (:documentation ""))
(defgeneric client-message (responder event); format window type data)
  (:documentation ""))
(defgeneric mapping-notify (responder event); request start count)
  (:documentation ""))

(defgeneric become-first-responder (responder)
  (:documentation "Return t if now first responder, nil if not."))
(defgeneric resign-first-responder (responder)
  (:documentation "Return t if resigned, nil if not.")
  (:method (obj)
    t))


(defclass responder ()
  ((id :accessor id
       :initarg :id
       :initform ""
       :type string
       :documentation "A string ID for the responder.")
   (next :accessor next
         :initform nil
         :type responder
         :documentation "The next responder.")
   (first-responder-p :accessor first-responder-p
                      :initform nil
                      :type boolean
                      :documentation "")
   (can-become-first-responder-p :accessor can-become-first-responder-p
                                 :initform nil
                                 :type boolean
                                 :documentation "")
   (can-resign-first-responder-p :accessor can-resign-first-responder-p
                                 :initform t
                                 :type boolean
                                 :documentation "")
         ))