(in-package :dexter)

;;; Just copying openstep/cocoa for now
(defgeneric mouse-down (responder event)
  (:documentation ""))
(defgeneric mouse-dragged (responder event)
  (:documentation ""))
(defgeneric mouse-up (responder event)
  (:documentation ""))
(defgeneric mouse-moved (responder event)
  (:documentation ""))
(defgeneric mouse-entered (responder event)
  (:documentation ""))
(defgeneric mouse-exited (responder event)
  (:documentation ""))

(defgeneric key-down (responder event)
  (:documentation ""))
(defgeneric key-up (responder event)
  (:documentation ""))
(defgeneric interpret-key-events (responder events)
  (:documentation ""))
(defgeneric perform-key-equivalent (responder event)
  (:documentation ""))
(defgeneric flush-buffered-key-events (responder)
  (:documentation ""))


(defclass responder ()
  ((name :accessor name
         :initarg :name
         :initform ""
         :type string
         :documentation "A string ID for the responder.")))