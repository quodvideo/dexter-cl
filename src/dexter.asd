(defpackage :dexter
  (:use :cl)
  (:nicknames :dx)
  (:export responder
           application dispatch-event next-event run
           view
           window show focus
           point make-point point-x point-y
           size make-size size-width size-height
           rect make-rect))

(in-package :dexter)

(asdf:defsystem DEXTER
  :description "A toolkit for X."
  :depends-on (clx)
  :version "0.0.0"
  :components ((:file "responder")
               (:file "application")
               (:file "view")
               (:file "window")))

;;; Some simple structures to keep geometry tidy
(defstruct point
  "A point"
  (x 0)
  (y 0))

(defstruct size
  "A size"
  (width 1)
  (height 1))

(defstruct rect
  "A rectangle into which something will be drawn."
  (x 0)
  (y 0)
  (width 1)
  (height 1))

;;; One stupidly large structure to pass events around.
(defstruct event
  "An XEvent"
  display event-key event-code send-event-p code sequence time root window child
  root-x root-y x y state same-screen-p hint-p kind mode focus-p keymap width height
  count drawable minor major parent border-width override-redirect-p configure-p
  above-sibling stack-mode value-mask atom event-window selection requestor target
  property colormap new-p installed-p format type data request start place)