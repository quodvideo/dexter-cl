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
(defgeneric key-press (responder event) 
  (:documentation "code time root window child root-x root-y x y state same-screen-p")
  (:method (obj event) t))
(defgeneric key-release (responder event)
  (:documentation "code time root window child root-x root-y x y state same-screen-p")
  (:method (obj event) t))
(defgeneric button-press (responder event)
  (:documentation "code time root window child root-x root-y x y state same-screen-p")
  (:method (obj event) t))
(defgeneric button-release (responder event)
  (:documentation "code time root window child root-x root-y x y state same-screen-p")
  (:method (obj event) t))
(defgeneric motion-notify (responder event)
  (:documentation "hint-p time root window child root-x root-y x y state same-screen-p")
  (:method (obj event) t))
(defgeneric enter-notify (responder event)
  (:documentation "kind time root window child root-x root-y x y state mode focus-p same-screen-p")
  (:method (obj event) t))
(defgeneric leave-notify (responder event)
  (:documentation "kind time root window child root-x root-y x y state mode focus-p same-screen-p")
  (:method (obj event) t))
(defgeneric focus-in (responder event)
  (:documentation "kind window mode")
  (:method (obj event) t))
(defgeneric focus-out (responder event)
  (:documentation "kind window mode")
  (:method (obj event) t))
(defgeneric keymap-notify (responder event)
  (:documentation "keymap")
  (:method (obj event) t))
(defgeneric exposure (responder event)
  (:documentation "window x y width height count")
  (:method (obj event) t))
(defgeneric graphics-exposure (responder event)
  (:documentation "drawable x y width height minor count major")
  (:method (obj event) t))
(defgeneric no-exposure (responder event)
  (:documentation "drawable minor major")
  (:method (obj event) t))
(defgeneric visibility-notify (responder event)
  (:documentation "window state")
  (:method (obj event) t))
(defgeneric create-notify (responder event)
  (:documentation "parent window x y width height border-width override-redirect-p")
  (:method (obj event) t))
(defgeneric destroy-notify (responder event)
  (:documentation "window")
  (:method (obj event) t))
(defgeneric unmap-notify (responder event)
  (:documentation "window configure-p")
  (:method (obj event) t))
(defgeneric map-notify (responder event)
  (:documentation "window override-redirect-p")
  (:method (obj event) t))
(defgeneric map-request (responder event)
  (:documentation "parent window")
  (:method (obj event) t))
(defgeneric reparent-notify (responder event)
  (:documentation "window parent x y override-redirect-p")
  (:method (obj event) t))
(defgeneric configure-notify (responder event)
  (:documentation "window above-sibling x y width height border-width override-redirect-p")
  (:method (obj event) t))
(defgeneric configure-request (responder event)
  (:documentation "stack-mode parent window above-sibling x y width height border-width value-mask")
  (:method (obj event) t))
;(defgeneric gravity-notify (responder event) (:documentation "")(:method (obj event) t))
;(defgeneric resize-request (responder event) (:documentation "")(:method (obj event) t))
;(defgeneric circulate-notify (responder event) (:documentation "")(:method (obj event) t))
;(defgeneric circulate-request (responder event) (:documentation "")(:method (obj event) t))
(defgeneric property-notify (responder event)
  (:documentation "window event-window atom time state")
  (:method (obj event) t))
(defgeneric selection-clear (responder event)
  (:documentation "time window selection")
  (:method (obj event) t))
(defgeneric selection-request (responder event)
  (:documentation "time window requestor selection target property")
  (:method (obj event) t))
(defgeneric selection-notify (responder event)
  (:documentation "time window selection target property")
  (:method (obj event) t))
(defgeneric colormap-notify (responder event)
  (:documentation "window colormap new-p installed-p")
  (:method (obj event) t))
(defgeneric client-message (responder event)
  (:documentation "format window type data")
  (:method (obj event) t))
(defgeneric mapping-notify (responder event)
  (:documentation "request start count")
  (:method (obj event) t))

(defgeneric become-first-responder (responder)
  (:documentation "Return t if now first responder, nil if not.")
  (:method (obj) t))
(defgeneric resign-first-responder (responder)
  (:documentation "Return t if resigned, nil if not.")
  (:method (obj) t))


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