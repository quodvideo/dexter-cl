(defpackage :dexter
  (:use :cl)
  (:nicknames :dx)
  (:export responder
           application dispatch-event next-event run
           window show focus
           view
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
               (:file "window")
               (:file "view")))

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