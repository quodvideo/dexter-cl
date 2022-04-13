(defpackage :dexter
  (:use :cl)
  (:nicknames :dx))

(in-package :dexter)

(asdf:defsystem DEXTER
  :description "A toolkit for X."
  :depends-on (clx)
  :version "0.0.0"
  :components ((:file "responder")
               (:file "application")
               (:file "window")
               (:file "view")))