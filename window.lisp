#!/bin/sh
#|
exec ros -Q -- $0 "$@"
|#
(ql:quickload 'clx :silent t)
(defpackage :dexter
  (:use :cl)
  (:nicknames :dx))
(in-package :dexter)

;; Rather than having an initialize function that applications call, loading dexter does its initialization.
(defvar *display* (xlib:open-default-display))
(defvar *screen* (xlib:display-default-screen *display*))
(defvar *root* (xlib:screen-root *screen*))
(defvar *dispatch-alist* nil)

;;; Some simple structures to keep geometry tidy
(defstruct rect
  "A rectangle into which something will be drawn."
  (x 0)
  (y 0)
  (width 1)
  (height 1))


(defstruct requisition
  "Width and height requested by something."
  (width 1)
  (height 1))

(defclass responder ()
  ((name :accessor name
         :initarg :name
         :initform ""
         :type string
         :documentation "A string ID for the responder.")))

;;; dexter:application
(defclass application (responder) () )

(defmethod run (application)
  (unwind-protect
    (xlib:event-case (*display* :discard-p t :force-output-p t)
                     (otherwise (window)
                       (format t "A window! ~S~%" window)
                     nil))
    (xlib:close-display *display*)))

;;; dexter::widget will be the base class for event handling.
;;; I may go the NS route and have responders, views, applications, and windows.
(defclass view (responder)
  ((xwindow :accessor xwindow
            :initarg :xwindow
            :initform nil)
   (geometry :accessor geometry
             :initarg :geometry
             :initform (make-rect)
             :type rect)
   (size-request :accessor size-request
                 :initarg :size-request
                 :initform (make-requisition)
                 :type requisition)
   (label :accessor label
          :initarg :label
          :initform ""
          :type string
          :documentation "Displayed label text.")))

(defgeneric realize (view)
  (:documentation "Provides an XID for the widget to be drawn on."))
(defgeneric unrealize (view)
  (:documentation "Disassociates the XID from the widget."))
(defgeneric show (view)
  (:documentation "Sets the widget to be shown when its parent is shown."))
(defgeneric hide (view)
  (:documentation "Hides the widget."))
(defgeneric focus (view token)
  (:documentation ""))

;;; The toplevel widget is what users recognize as a window.
(defclass toplevel (view)
  ())

(defmethod realize (toplevel)
  (setf (xwindow toplevel) (xlib:create-window :parent *root*
                                               :x (rect-x (geometry toplevel))
                                               :y (rect-y (geometry toplevel))
                                               :width (rect-width (geometry toplevel))
                                               :height (rect-height (geometry toplevel))
                                               :event-mask '(:exposure :button-press)))
  (xlib:set-wm-properties (xwindow toplevel) :name "Foo"
                                             :icon-name "Foo"
                                             :resource-name "Foo"
                                             :resource-class "Foo"
                                             :input :off :initial-state :normal)
  (xlib:change-property (xwindow toplevel) 
    :WM_PROTOCOLS (list (xlib:intern-atom *display* :WM_DELETE_WINDOW)
                        (xlib:intern-atom *display* :WM_TAKE_FOCUS))
    :ATOM 32))

(defmethod unrealize (toplevel)
  (when (xlib:window-p (xwindow toplevel)) (xlib:destroy-window (xwindow toplevel))))

(defmethod show (toplevel)
  (unless (xlib:window-p (xwindow toplevel)) (realize toplevel))
  (xlib:map-window (xwindow toplevel)))

(defmethod hide (toplevel)
  (xlib:unmap-window (xwindow toplevel)))

(defmethod focus (toplevel token)
  (xlib:set-input-focus (xlib:window-display (xwindow toplevel)) (xwindow toplevel) :parent token))

;;; The rest is just doing stuff for testing.
(defun main (&rest argv)
  (declare (ignorable argv))
  (let* ((w1 (make-instance 'toplevel :geometry (make-rect :x 10 :y 10 :width 100 :height 100))))
    (show w1)
    (unwind-protect
      (xlib:event-case (*display* :discard-p t :force-output-p t)
        (client-message (format sequence window type data)
          (when (eq type :WM_PROTOCOLS)
            (cond ((eq (elt data 0) (xlib:intern-atom *display* :WM_DELETE_WINDOW)) (format t "DELETE!~%") t)
                  ((eq (elt data 0) (xlib:intern-atom *display* :WM_TAKE_FOCUS)) (format t "FOCUS!~%"))
                  (t (format t "A Client Message! ~S ~S ~S ~S ~S ~%" format sequence window type data)))))
        (otherwise (event-key window)
          (format t "A window! ~S   An event! ~S~%" window event-key) nil))
      (xlib:close-display *display*))))