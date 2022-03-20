(defpackage dexter
  (:documentation "The widget toolkit for INDEX"))
(defstruct geometry
  ""
  (x 0)
  (y 0)
  (width 1)
  (height 1))


(defstruct requisition
  ""
  (width 1)
  (height 1))

(defgeneric realize (widget)
  (:documentation "Provides an XID for the widget to be drawn on."))
(defgeneric unrealize (widget)
  (:documentation "Disassociates the XID from the widget."))
(defgeneric show (widget)
  (:documentation "Sets the widget to be shown when its parent is shown."))
(defgeneric hide (widget)
  (:documentation "Hides the widget."))
(defgeneric focus (widget token)
  (:documentation ""))
(defgeneric blur (widget)
  (:documentation ""))

(defclass widget ()
  ((display :accessor display
            :initarg :display
            :initform nil
            :documentation "X display connection")
   (xid :accessor xid
        :initarg :xid
        :initform 0
        :type integer
        :documentation "X ID associated with this widget.")
   (geometry :accessor geometry
             :initarg :geometry)
   (requisition :accessor requisition
                :initarg :requisition)
   (tip :accessor tip
        :initarg :tip
        :initform ""
        :type string
        :documentation "Tip displayed for this widget")
   (name :accessor name
         :initarg :name
         :initform ""
         :type string
         :documentation "Name or string ID of the widget")
   (label :accessor label
          :initarg :label
          :initform ""
          :type string
          :documentation "Displayed label text.")
   (parent :accessor parent
           :initarg :parent
           :initform nil
           :type widget
           :documentation "The widget containing this one.")))

(defclass application () (()))
(defclass window (widget) (()))
(defclass dialog-window (window) (()))
(defclass utility-window (window) (()))
(defclass button (widget) (()))
(defclass check-button (button)
  ((tick :accessor tick
         :initarg :tick
         :initform t
         :type boolean
         :documentation "Show the tick mark")))
(defclass radio-button (button)
  ((tick :accessor tick
         :initarg :tick
         :initform t
         :type boolean
         :documentation "Show the tick mark")))
(defclass spin-button (button) (()))
(defclass menu (widget) (()))
(defclass menu-bar (widget) (()))
(defclass menu-item (widget)
  ((shortcut :accessor shortcut
             :initarg :shortcut
             :initform ""
             :type string
             :documentation "A shortcut to be displayed in a menu item. This does not bind the shortcut to an action.")))
(defclass spacer (widget) (()))
(defclass splitter (widget) (()))
(defclass box (widget) (()))
(defclass v-box (widget) (()))
(defclass h-box (widget) (()))
(defclass grid-box (widget) (()))
(defclass list-box (widget) (()))
(defclass list-item (widget) (()))
(defclass tree-box (widget) (()))
(defclass tree-item (widget) (()))
(defclass text-box (widget) (()))
(defclass label (widget) (()))



(defun dexter-init ()
  "Connect to the display, etc."
  (defvar *display* (xlib:open-default-display)))

(defun main-loop ()
  "Event and periodic processing."
  ())

(let* ((w1 (make-instance 'window :label "Dex Demo"))
       (vb (make-instance 'v-box :parent w1))
       (hb1 (make-instance 'h-box :parent vb))
       (lb1 (make-instance 'list-box :parent hb1
			   :label "Favorites" :on-select foo))
       (lb2 (make-instance 'list-box :parent hb1 :label "Files"
			   :on-select bar))
       (hb2 (make-instance 'h-box :parent vb))
       (sp (make-instance 'spacer :parent hb2))
       (cancel-button (make-instance 'button :parent hb2 :label "Cancel"
				     :on-click baz))
       (ok-button (make-instance 'button :parent hb2 :label "OK"
				 :on-click quux)))
  (show w1)
  (main-loop))


(dialog-window
  (vbox
    (hbox
      (listbox "Favorites")
      (listbox "Files"))
    (hbox
      (spacer)
      (button :label "Cancel" )
      (button :label "OK"))))

(box :orient (or "vertical" "horizontal"))

(menu
  (item :label "_New"   :shortcut "Ctrl+N" :token 1))
  (item :label "_Open"  :shortcut "Ctrl+O" :token 2))
  (item :label "_Save"  :shortcut "Ctrl+S" :token 3))
  (item :label "_Close" :shortcut "Ctrl+W" :token 4)))

(button :label "OK" :tip "tooltip")

(radiogroup 
  (item :label "Option _1 of 3")
  (item :label "Option _2 of 3")
  (item :label "Option _3 of 3"))

(radiobutton :label "Option _1 of 3" :group "3options" :tick t)
(radiobutton :label "Option _2 of 3" :group "3options" :tick t)
(radiobutton :label "Option _3 of 3" :group "3options" :tick t)

(checkbutton :label "Boolean Option" :tick t)
(checkbutton :label "Boolean Option" :tick t)

(listbox
  (item :label "Foo")
  (item :label "Bar")
  (item :label "Baz"))
