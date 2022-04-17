(in-package :dexter)

(defclass view (responder)
  ((frame :accessor frame
          :initarg :frame
          :initform (make-rect)
          :type rectangle
          :documentation "The view rectangle in window coordinates.")
   (superview :accessor superview
              :type view
              :documentation "The view containing this view.")
   (subviews :accessor subviews
             :type list
             :documentation "The views contained within this view")
   (window :accessor window
           :type window
           :documentation "The window containing the view.")
   (background-color :accessor background-color
                     :documentation "")
   (hidden-p :accessor hidden-p
             :initform nil
             :type boolean
             :documentation "")
   (alpha :accessor alpha
          :type float
          :documentation "")
   (opaque-p :accessor opaque-p
             :initform nil
             :type boolean
             :documentation "")
           )
           )