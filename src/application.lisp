(in-package :dexter)

;; dexter:application
(defclass application (responder)
  ((display :accessor display
            :initarg :display
            :documentation "The X display.")))

(defmethod run (application)
  (unwind-protect
    (xlib:event-case ((display application) :discard-p t :force-output-p t)
      (otherwise (window)
        (format t "A window! ~S~%" window)
        nil))
    (xlib:close-display (display application))))