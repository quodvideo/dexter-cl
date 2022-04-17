;;; A basic app should end up looking something like this.

(ql:quickload 'dexter)

(defclass folder-object () ; This shouldn't really be a subclass.
  ()
  ;; a representation of the directory.
  )
(defclass folder-window (dexter:window)
  ()
  ;; a field of icons
  )

(defun main (directory timestamp &rest argv)
  (let* ((app (make-instance 'dexter:application)
         (dir (make-instance 'folder-object :directory directory))
         (win (make-instance 'folder-window :value dir :timestamp timestamp))))
    (dexter:run app)))