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
                                  :event-mask '(:key-press :key-release :button-press :button-release
                                                :enter-window :leave-window :pointer-motion :button-motion :exposure
                                                :visibility-change :structure-notify :substructure-notify
                                                :focus-change :property-change :colormap-change :owner-grab-button))))
    (xlib:set-wm-properties xwin :input :off :initial-state :normal)
    (xlib:change-property xwin
      :WM_PROTOCOLS (list (xlib:intern-atom (xlib:window-display xwin) :WM_DELETE_WINDOW)
                          (xlib:intern-atom (xlib:window-display xwin) :WM_TAKE_FOCUS))
      :ATOM 32)
    xwin))

(defclass window (responder)
  ((xwin :accessor xwin
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

(defgeneric focus (window token)
  (:documentation ""))

(defmethod show (window)
  (setf (xwin window) (make-default-window *root*))
  (xlib:with-state ((xwin window))
    (setf (xlib:drawable-x (xwin window)) (rect-x (geometry window)))
    (setf (xlib:drawable-y (xwin window)) (rect-y (geometry window)))
    (setf (xlib:drawable-width (xwin window)) (rect-width (geometry window)))
    (setf (xlib:drawable-height (xwin window)) (rect-height (geometry window)))
    (xlib:set-wm-properties (xwin window) :name (title window))
    (xlib:map-window (xwin window))))

(defmethod focus (window token)
  (xlib:set-input-focus (xlib:window-display (xwin window)) (xwin window) :parent token))

(defmethod key-press (window event)
  (format t "Key Press: ~S ~S ~S ~S ~S~%" (event-code event)
                                          (event-root event)
                                          (event-window event)
                                          (event-child event)
                                          (event-state event)))
(defmethod key-release (window event)
  (format t "Key Release: ~S ~S ~S ~S ~S~%" (event-code event)
                                            (event-root event)
                                            (event-window event)
                                            (event-child event)
                                            (event-state event)))
(defmethod button-press (window event)
  (format t "Button Press: ~S ~S ~S ~S ~S~%" (event-code event)
                                             (event-root event)
                                             (event-window event)
                                             (event-child event)
                                             (event-state event)))
(defmethod button-release (window event)
  (format t "Button Release: ~S ~S ~S ~S ~S~%" (event-code event)
                                               (event-root event)
                                               (event-window event)
                                               (event-child event)
                                               (event-state event)))

(defmethod motion-notify (window event) (format t "Motion~%"))
(defmethod enter-notify (window event) (format t "Enter~%"))
(defmethod leave-notify (window event) (format t "Leave~%"))
(defmethod focus-in (window event) (format t "Focus in~%"))
(defmethod focus-out (window event) (format t "Focus out~%"))
(defmethod keymap-notify (window event) (format t "Keymap~%"))
(defmethod exposure (window event) (format t "EXPOSURE~%"))
(defmethod graphics-exposure (window event) (format t "Graphics EXPOSURE~%"))
(defmethod no-exposure (window event) (format t "No EXPOSURE~%"))
(defmethod visibility-notify (window event) (format t "Vis~%"))
(defmethod create-notify (window event) (format t "Create~%"))
(defmethod destroy-notify (window event) (format t "Destroy~%"))
(defmethod unmap-notify (window event) (format t "Unmap~%"))
(defmethod map-notify (window event) (format t "Map~%"))
(defmethod map-request (window event) (format t "Map Request~%"))
(defmethod reparent-notify (window event) (format t "Reparent~%"))

(defmethod configure-notify (window event)
  (format t "Configure ~S ~S ~S ~S ~S ~S ~S ~S~%" (event-window event)
                                                  (event-above-sibling event)
                                                  (event-x event) (event-y event)
                                                  (event-width event) (event-height event)
                                                  (event-border-width event)
                                                  (event-override-redirect-p event)))

(defmethod configure-request (window event) (format t "Configure Request~%"))

(defmethod property-notify (window event)
  (when (eq (event-state event) :new-value)
    (format t "Property ~S ~S~%" (event-atom event) (xlib:get-property (event-window event) (event-atom event)))))

(defmethod selection-clear (window event) (format t "Selection Clear~%"))
(defmethod selection-request (window event) (format t "Selection Request~%"))
(defmethod selection-notify (window event) (format t "Selection Notify~%"))
(defmethod colormap-notify (window event) (format t "Colormap~%"))

(defmethod client-message (window event)
  (when (eq (event-type event) :WM_PROTOCOLS)
    (let ((w (event-window event))
          (m (elt (event-data event) 0))
          (ts (elt (event-data event) 1)))
      (cond ((eq m (xlib:intern-atom *display* :WM_DELETE_WINDOW)) (format t "DELETE!~%") t)
            ((eq m (xlib:intern-atom *display* :WM_TAKE_FOCUS))
              (format t "FOCUS! ~S~%" ts)
              (xlib:set-input-focus (xlib:window-display w) w :parent ts)
              nil)
            (t (format t "A Client Message! ~S ~S ~S ~S ~S ~%" (event-format event)
                                                               (event-sequence event)
                                                               w
                                                               (event-type event)
                                                               (event-data event)))))))

(defmethod mapping-notify (window event) (format t "Mapping~%"))