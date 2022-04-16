(in-package :dexter)
(defvar *dexter-app*)
;; dexter:application
(defclass application (responder)
  ((display :accessor display
            :initform (xlib:open-default-display)
            :documentation "The X display.")
   (last-timestamp :accessor last-timestamp
                   :initform 0
                   :documentation "The last usable timestamp received by the application.")
   (windows :accessor windows
            :initform nil
            :type list
            :documentation "The dx::windows of this application.")))

(defmethod initialize-instance :after ((obj application) &key)
  (defvar *dexter-app* obj)
  (format t "Hi!~%"))

(defmethod key-press ((obj application) event)
  (setf (last-timestamp obj) (event-time event))
  (key-press (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))
  
(defmethod key-release ((obj application) event)
  (setf (last-timestamp obj) (event-time event))
  (key-release (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod button-press ((obj application) event)
  (setf (last-timestamp obj) (event-time event))
  (button-press (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod button-release ((obj application) event)
  (setf (last-timestamp obj) (event-time event))
  (button-release (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod motion-notify ((obj application) event)
  (motion-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod exposure ((obj application) event)
  (exposure (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod graphics-exposure ((obj application) event)
  (graphics-exposure (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod no-exposure ((obj application) event)
  (no-exposure (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod enter-notify ((obj application) event)
  (enter-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod leave-notify ((obj application) event)
  (leave-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod focus-in ((obj application) event)
  (focus-in (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod focus-out ((obj application) event)
  (focus-out (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod keymap-notify ((obj application) event)
  (keymap-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod visibility-notify ((obj application) event)
  (visibility-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod create-notify ((obj application) event)
  (create-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod destroy-notify ((obj application) event)
  (destroy-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod unmap-notify ((obj application) event)
  (unmap-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod map-notify ((obj application) event)
  (map-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod map-request ((obj application) event)
  (map-request (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod reparent-notify ((obj application) event)
  (reparent-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod configure-notify ((obj application) event)
  (configure-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod configure-request ((obj application) event)
  (configure-request (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))
;
(defmethod property-notify ((obj application) event)
  (setf (last-timestamp obj) (event-time event))
  (property-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod selection-clear ((obj application) event)
  (selection-clear (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod selection-request ((obj application) event)
  (selection-request (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod selection-notify ((obj application) event)
  (selection-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod colormap-notify ((obj application) event)
  (colormap-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod client-message ((obj application) event)
  (client-message (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod mapping-notify ((obj application) event)
  (mapping-notify (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows obj)) event))

(defmethod run (application)
  (unwind-protect
    (xlib:event-case ((display application) :discard-p t :force-output-p t)
      (key-press (code sequence time root window child root-x root-y x y state same-screen-p)
        (key-press application (make-event :code code :sequence sequence :time time :root root :window window :child child :root-x root-x :root-y root-y :x x :y y :state state :same-screen-p same-screen-p)))
      (key-release (code sequence time root window child root-x root-y x y state same-screen-p)
        (key-release application (make-event :code code :sequence sequence :time time :root root :window window :child child :root-x root-x :root-y root-y :x x :y y :state state :same-screen-p same-screen-p)))
      (button-press (event-key code sequence time root window child root-x root-y x y state same-screen-p)
        (button-press application (make-event :code code :sequence sequence :time time :root root :window window :child child :root-x root-x :root-y root-y :x x :y y :state state :same-screen-p same-screen-p)))
      (button-release (code sequence time root window child root-x root-y x y state same-screen-p)
        (button-release application (make-event :code code :sequence sequence :time time :root root :window window :child child :root-x root-x :root-y root-y :x x :y y :state state :same-screen-p same-screen-p)))
      (motion-notify (hint-p sequence time root window child root-x root-y x y state same-screen-p)
        (motion-notify application (make-event :code code :sequence sequence :time time :root root :window window :child child :root-x root-x :root-y root-y :x x :y y :state state :same-screen-p same-screen-p)))
      (exposure (sequence window x y width height count)
        (exposure application (make-event :sequence sequence :window window :x x :y y :width width :height height :count count)))
      (graphics-exposure (sequence drawable x y width height minor count major)
        (graphics-exposure application (make-event :sequence sequence :drawable drawable :x x :y y :width width :height height :minor minor :count count :major major)))
      (no-exposure (sequence drawable minor major)
        (no-exposure application (make-event :sequence sequence :drawable drawable :minor minor :major major)))
      ;; The remaining events are handled by the window or the application.
      (enter-notify (kind sequence time root window child root-x root-y x y state mode focus-p same-screen-p)
        (enter-notify application (make-event :kind kind :sequence sequence :time time :root root :window window :child child :root-x root-x :root-y root-y :x x :y y :state state :mode mode :focus-p focus-p :same-screen-p same-screen-p)))
      (leave-notify (kind sequence time root window child root-x root-y x y state mode focus-p same-screen-p)
        (leave-notify application (make-event :kind kind :sequence sequence :time time :root root :window window :child child :root-x root-x :root-y root-y :x x :y y :state state :mode mode :focus-p focus-p :same-screen-p same-screen-p)))
      (focus-in (kind sequence window mode)
        (focus-in application (make-event :kind kind :sequence sequence :window window :mode mode)))
      (focus-out (kind sequence window mode)
        (focus-out application (make-event :kind kind :sequence sequence :window window :mode mode)))
      (keymap-notify (keymap)
        (keymap-notify application (make-event :keymap keymap)))
      (visibility-notify (sequence window state)
        (visibility-notify application (make-event :sequence sequence :window window :state state)))
      (create-notify (sequence parent window x y width height border-width override-redirect-p)
        (create-notify application (make-event :sequence sequence :parent parent :window window :x x :y y :width width :height height :border-width border-width :override-redirect-p override-redirect-p)))
      (destroy-notify (sequence window)
        (destroy-notify application (make-event :sequence sequence :window window)))
      (unmap-notify (sequence window configure-p)
        (unmap-notify application (make-event :sequence sequence :window window :configure-p configure-p)))
      (map-notify (sequence window override-redirect-p)
        (map-notify application (make-event :sequence sequence :window window :override-redirect-p override-redirect-p)))
      (map-request (sequence parent window)
        (map-request application (make-event :sequence sequence :parent parent :window window)))
      (reparent-notify (sequence window parent x y override-redirect-p)
        (reparent-notify application (make-event :sequence sequence :window window :parent parent :x x :y y :override-redirect-p override-redirect-p)))
      (configure-notify (sequence window above-sibling x y width height border-width override-redirect-p)
        (configure-notify application (make-event :sequence sequence :window window :above-sibling above-sibling :x x :y y :width width :height height :border-width border-width :override-redirect-p override-redirect-p)))
      (configure-request (stack-mode sequence parent window above-sibling x y width height border-width value-mask)
        (configure-request application (make-event :stack-mode stack-mode :sequence sequence :parent parent :window window :above-sibling above-sibling :x x :y y :width width :height height :border-width border-width :value-mask value-mask)))
      ;(gravity-notify (sequence window x y))
      ;(resize-request (sequence window width height))
      ;(circulate-notify (sequence window parent place))
      ;(circulate-request (sequence window parent place))
      (property-notify (sequence window event-window atom time state)
        (property-notify application (make-event :sequence sequence :window window :event-window event-window :atom atom :time time :state state)))
      (selection-clear (sequence time window selection)
        (selection-clear application (make-event :sequence sequence :time time :window window :selection selection)))
      (selection-request (sequence time window requestor selection target property)
        (selection-request application (make-event :sequence sequence :time time :window window :requestor requestor :selection selection :target target :property property)))
      (selection-notify (sequence time window selection target property)
        (selection-notify application (make-event :sequence sequence :time time :window window :selection selection :target target :property property)))
      (colormap-notify (sequence window colormap new-p installed-p)
        (colormap-notify application (make-event :sequence sequence :window window :colormap colormap :new-p new-p :installed-p installed-p)))
      (client-message (format sequence window type data)
        (client-message application (make-event :format format :sequence sequence :window window :type type :data data)))
      (mapping-notify (sequence request start count)
        (mapping-notify application (make-event :sequence sequence :request request :start start :count count)))
      (otherwise (event-key window)
        (format t "A window! ~S   An event! ~S~%" window event-key) nil))
    (xlib:close-display (display application))))