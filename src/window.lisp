;;;; The basic toplevel window with a frame, titlebar, etc.

(in-package :dexter)

(defun make-default-window (parent &key (x -1) (y -1) (width 1) (height 1))
  "Creates a basic X window."
  (let ((xwin (xlib:create-window :parent parent
                                  :x x :y y :width width :height height
                                  :event-mask '(:key-press :key-release :button-press
                                                :button-release :enter-window :leave-window
                                                :pointer-motion :button-motion :exposure
                                                :visibility-change :structure-notify
                                                :substructure-notify :focus-change :property-change
                                                :colormap-change :owner-grab-button))))
    (xlib:set-wm-properties xwin :input :off :initial-state :normal)
    (xlib:change-property xwin
      :WM_PROTOCOLS (list (xlib:intern-atom (xlib:window-display xwin) :WM_DELETE_WINDOW)
                          (xlib:intern-atom (xlib:window-display xwin) :WM_TAKE_FOCUS))
      :ATOM 32)
    xwin))

(defclass window (view)
  ((xwin :accessor xwin
         :type xlib:window
         :documentation "The X window of the window.")
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
        :documentation "The URL represented by this window")
   (last-timestamp :accessor last-timestamp
                   :initform 0
                   :documentation "The last focus-usable timestamp received by this window.")))

(defgeneric focus (window token)
  (:documentation ""))
(defgeneric show (window)
  (:documentation ""))
(defgeneric close-window (window)
  (:documentation ""))

(defmethod initialize-instance :after ((obj window) &key)
  (setf (windows *dexter-app*) (append (windows *dexter-app*) (list obj)))
  (setf (next obj) *dexter-app*))

(defmethod show (window)
  (let* ((d (display *dexter-app*))
         (s (xlib:display-default-screen d))
         (r (xlib:screen-root s)))
    (setf (xwin window) (make-default-window r)))
  (xlib:with-state ((xwin window))
    (setf (xlib:drawable-x (xwin window)) (rect-x (frame window)))
    (setf (xlib:drawable-y (xwin window)) (rect-y (frame window)))
    (setf (xlib:drawable-width (xwin window)) (rect-width (frame window)))
    (setf (xlib:drawable-height (xwin window)) (rect-height (frame window)))
    (xlib:set-wm-properties (xwin window) :name (title window))
    (xlib:map-window (xwin window))))

(defmethod focus (window token)
  (xlib:set-input-focus (xlib:window-display (xwin window)) (xwin window) :parent token))

(defmethod close-window (window)
  (xlib:destroy-window (xwin window)))

(defmethod key-press ((obj window) event)
  (format t "~S Key Press: ~S ~S ~S ~S ~S~%" (title obj)
                                             (event-code event)
                                             (event-root event)
                                             (event-window event)
                                             (event-child event)
                                             (event-state event)))
(defmethod key-release ((obj window) event)
  (format t "Key Release: ~S ~S ~S ~S ~S~%" (event-code event)
                                            (event-root event)
                                            (event-window event)
                                            (event-child event)
                                            (event-state event)))
(defmethod button-press ((obj window) event)
  (setf (last-timestamp obj) (event-time event))
  (format t "Button Press: ~S ~S ~S ~S ~S~%" (event-code event)
                                             (event-root event)
                                             (event-window event)
                                             (event-child event)
                                             (event-state event)))
(defmethod button-release ((obj window) event)
  (setf (last-timestamp obj) (event-time event))
  (format t "Button Release: ~S ~S ~S ~S ~S~%" (event-code event)
                                               (event-root event)
                                               (event-window event)
                                               (event-child event)
                                               (event-state event)))

(defmethod motion-notify ((obj window) event) (format t "Motion~%"))
(defmethod enter-notify ((obj window) event) (format t "Enter~%"))
(defmethod leave-notify ((obj window) event) (format t "Leave~%"))
(defmethod focus-in ((obj window) event) (format t "Focus in~%"))
(defmethod focus-out ((obj window) event) (format t "Focus out~%"))
(defmethod keymap-notify ((obj window) event) (format t "Keymap~%"))
(defmethod exposure ((obj window) event) (format t "Exposure~%"))
(defmethod graphics-exposure ((obj window) event) (format t "Graphics Exposure~%"))
(defmethod no-exposure ((obj window) event) (format t "No Exposure~%"))
(defmethod visibility-notify ((obj window) event) (format t "Vis~%"))
(defmethod create-notify ((obj window) event) (format t "Create~%"))
(defmethod destroy-notify ((obj window) event) (format t "Destroy~%"))
(defmethod unmap-notify ((obj window) event) (format t "Unmap~%"))
(defmethod map-notify ((obj window) event) (format t "Map~%"))
(defmethod map-request ((obj window) event) (format t "Map Request~%"))
(defmethod reparent-notify ((obj window) event) (format t "Reparent~%"))

(defmethod configure-notify ((obj window) event)
  (format t "Configure ~S ~S ~S ~S ~S ~S ~S ~S~%" (event-window event)
                                                  (event-above-sibling event)
                                                  (event-x event) (event-y event)
                                                  (event-width event) (event-height event)
                                                  (event-border-width event)
                                                  (event-override-redirect-p event)))

(defmethod configure-request ((obj window) event) (format t "Configure Request~%"))

(defmethod property-notify ((obj window) event)
  (when (eq (event-state event) :new-value)
    (format t "Property ~S ~S~%" (event-atom event)
                                 (xlib:get-property (event-window event) (event-atom event)))))

(defmethod selection-clear ((obj window) event) (format t "Selection Clear~%"))
(defmethod selection-request ((obj window) event) (format t "Selection Request~%"))
(defmethod selection-notify ((obj window) event) (format t "Selection Notify~%"))
(defmethod colormap-notify ((obj window) event) (format t "Colormap~%"))

(defmethod client-message ((obj window) event)
  (when (eq (event-type event) :WM_PROTOCOLS)
    (let* ((w (event-window event))
           (d (xlib:window-display w))
           (m (elt (event-data event) 0))
           (ts (elt (event-data event) 1)))
      (cond ((eq m (xlib:intern-atom d :WM_DELETE_WINDOW))
              (format t "DELETE!~%")
              (close-window obj))
            ((eq m (xlib:intern-atom d :WM_TAKE_FOCUS))
              (format t "FOCUS! ~S~%" ts)
              (setf (last-timestamp obj) ts)
              (focus obj ts))
            (t (format t "A Client Message! ~S ~S ~S ~S ~S ~%" (event-format event)
                                                               (event-sequence event)
                                                               w
                                                               (event-type event)
                                                               (event-data event)))))))

(defmethod mapping-notify ((obj window) event) (format t "Mapping~%"))