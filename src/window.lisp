(in-package :dexter)

;; Rather than having an initialize function that applications call, loading dexter does its initialization.
;(defvar *display* (xlib:open-default-display))
;(defvar *screen* (xlib:display-default-screen *display*))
;(defvar *root* (xlib:screen-root *screen*))
;(defvar *dispatch-alist* nil)

;;; Some simple structures to keep geometry tidy
;(defstruct rectangle
;  "A rectangle into which something will be drawn."
;  (x 0)
;  (y 0)
;  (width 1)
;  (height 1))


;(defstruct requisition
;  "Width and height requested by something."
;  (width 1)
;  (height 1))

(defun make-default-window (parent &key (x -1) (y -1) (width 1) (height 1))
  "Creates a basic X window."
  (let ((xwin (xlib:create-window :parent parent
                                  :x x :y y :width width :height height
                                  :event-mask '(:exposure :button-press))))
    (xlib:set-wm-properties xwin :input :off :initial-state :normal)
    (xlib:change-property xwin
      :WM_PROTOCOLS (list (xlib:intern-atom (xlib:window-display xwin) :WM_DELETE_WINDOW)
                          (xlib:intern-atom (xlib:window-display xwin) :WM_TAKE_FOCUS))
      :ATOM 32)
    xwin))

(defclass window (responder)
  ((xwin :accessor xwin
         :initarg :xwin
         :initform (make-default-window *root*) ; This should be somewhere else.
         :type xlib:window
         :documentation "The X window of the window.")
   (geometry :accessor geometry
             :initarg :geometry
             :initform (make-rect)
             :type rect)
   (title :accessor title
          :initarg :title
          :initform ""
          :type string
          :documentation "Main window title")
   (subtitle :accessor subtitle
             :initarg :subtitle
             :initform ""
             :type string
             :documentation "Window subtitle")
   (filename :accessor filename
             :initarg :filename
             :initform ""
             :type string
             :documentation "The filename represented by this window")
   (url :accessor url
        :initarg :url
        :initform ""
        :type string
        :documentation "The URL represented by this window")))