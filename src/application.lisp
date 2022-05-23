;;;; The singleton Application object.

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
            :documentation "The dx::windows of this application.")
   (current-event :accessor current-event
                  :type event
                  :documentation "The current event")
   (running-p :accessor running-p
              :type boolean
              :initform nil
              :documentation "")
   (active-p :accessor active-p
             :type boolean
             :initform nil
             :documentation "")
                  )
                  )

(defun matching-window (app event)
  (find-if (lambda (x) (eq (xwin x) (event-window event))) (windows app)))

(defmethod initialize-instance :after ((obj application) &key)
  (defvar *dexter-app* obj))

(defmethod key-press ((obj application) event)
  ;(setf (last-timestamp obj) (event-time event))
  (key-press (matching-window obj event) event))
  
(defmethod key-release ((obj application) event)
  ;(setf (last-timestamp obj) (event-time event))
  (key-release (matching-window obj event) event))

(defmethod button-press ((obj application) event)
  (setf (last-timestamp obj) (event-time event))
  (button-press (matching-window obj event) event))

(defmethod button-release ((obj application) event)
  (setf (last-timestamp obj) (event-time event))
  (button-release (matching-window obj event) event))

(defmethod motion-notify ((obj application) event)
  (motion-notify (matching-window obj event) event))

(defmethod exposure ((obj application) event)
  (exposure (matching-window obj event) event))

(defmethod graphics-exposure ((obj application) event)
  (graphics-exposure (matching-window obj event) event))

(defmethod no-exposure ((obj application) event)
  (no-exposure (matching-window obj event) event))

(defmethod enter-notify ((obj application) event)
  (enter-notify (matching-window obj event) event))

(defmethod leave-notify ((obj application) event)
  (leave-notify (matching-window obj event) event))

(defmethod focus-in ((obj application) event)
  (setf (active-p obj) t)
  (focus-in (matching-window obj event) event))

(defmethod focus-out ((obj application) event)
  (when (eq :normal (event-mode event))
    (setf (active-p obj) nil))
  (focus-out (matching-window obj event) event))

(defmethod keymap-notify ((obj application) event)
  (keymap-notify (matching-window obj event) event))

(defmethod visibility-notify ((obj application) event)
  (visibility-notify (matching-window obj event) event))

(defmethod create-notify ((obj application) event)
  (create-notify (matching-window obj event) event))

(defmethod destroy-notify ((obj application) event)
  (destroy-notify (matching-window obj event) event))

(defmethod unmap-notify ((obj application) event)
  (unmap-notify (matching-window obj event) event))

(defmethod map-notify ((obj application) event)
  (map-notify (matching-window obj event) event))

(defmethod map-request ((obj application) event)
  (map-request (matching-window obj event) event))

(defmethod reparent-notify ((obj application) event)
  (reparent-notify (matching-window obj event) event))

(defmethod configure-notify ((obj application) event)
  (configure-notify (matching-window obj event) event))

(defmethod configure-request ((obj application) event)
  (configure-request (matching-window obj event) event))
;
(defmethod property-notify ((obj application) event)
  ;(setf (last-timestamp obj) (event-time event))
  (property-notify (matching-window obj event) event))

(defmethod selection-clear ((obj application) event)
  (selection-clear (matching-window obj event) event))

(defmethod selection-request ((obj application) event)
  (selection-request (matching-window obj event) event))

(defmethod selection-notify ((obj application) event)
  (selection-notify (matching-window obj event) event))

(defmethod colormap-notify ((obj application) event)
  (colormap-notify (matching-window obj event) event))

(defmethod client-message ((obj application) event)
  (client-message (matching-window obj event) event))

(defmethod mapping-notify ((obj application) event)
  (mapping-notify (matching-window obj event) event))

(defmethod dispatch-event (application event)
  (case (event-event-key event)
    (:key-press         (key-press application event))
    (:key-release       (key-release application event))
    (:button-press      (button-press application event))
    (:button-release    (button-release application event))
    (:motion-notify     (motion-notify application event))
    (:enter-notify      (enter-notify application event))
    (:leave-notify      (leave-notify application event))
    (:focus-in          (focus-in application event))
    (:focus-out         (focus-out application event))
    (:keymap-notify     (keymap-notify application event))
    (:exposure          (exposure application event))
    (:graphics-exposure (graphics-exposure application event))
    (:no-exposure       (no-exposure application event))
    (:visibility-notify (visibility-notify application event))
    (:create-notify     (create-notify application event))
    (:destroy-notify    (destroy-notify application event))
    (:unmap-notify      (unmap-notify application event))
    (:map-notify        (map-notify application event))
    (:map-request       (map-request application event))
    (:reparent-notify   (reparent-notify application event))
    (:configure-notify  (configure-notify application event))
    (:configure-request (configure-request application event))
    ;(:gravity-notify    (gravity-notify application event)
    ;(:resize-request    (resize-request application event)
    ;(:circulate-notify  (circulate-notify application event)
    ;(:circulate-request (circulate-request application event)
    (:property-notify   (property-notify application event))
    (:selection-clear   (selection-clear application event))
    (:selection-request (selection-request application event))
    (:selection-notify  (selection-notify application event))
    (:colormap-notify   (colormap-notify application event))
    (:client-message    (client-message application event))
    (:mapping-notify    (mapping-notify application event))))

(defmethod next-event (application)
  (xlib:event-case ((display application) :discard-p t :force-output-p t)
    (t (display event-key event-code send-event-p code sequence time root window child
                root-x root-y x y state same-screen-p hint-p kind mode focus-p keymap
                width height count drawable minor major parent border-width override-redirect-p
                configure-p above-sibling stack-mode value-mask atom event-window selection
                requestor target property colormap new-p installed-p format type data request
                start place)
      (make-event :display display :event-key event-key :event-code event-code
                  :send-event-p send-event-p :code code :sequence sequence :time time :root root
                  :window window :child child :root-x root-x :root-y root-y :x x :y y :state state
                  :same-screen-p same-screen-p :hint-p hint-p :kind kind :mode mode
                  :focus-p focus-p :keymap keymap :width width :height height :count count
                  :drawable drawable :minor minor :major major :parent parent
                  :border-width border-width :override-redirect-p override-redirect-p
                  :configure-p configure-p :above-sibling above-sibling :stack-mode stack-mode
                  :value-mask value-mask :atom atom :event-window event-window :selection selection
                  :requestor requestor :target target :property property :colormap colormap
                  :new-p new-p :installed-p installed-p :format format :type type :data data
                  :request request :start start :place place))))

(defmethod run (application)
  (setf (running-p application) t)
  (unwind-protect
    (loop while (setf (current-event application) (next-event application)) do
      (dispatch-event application (current-event application)))
    (xlib:close-display (display application)))
  (setf (running-p application) nil))
