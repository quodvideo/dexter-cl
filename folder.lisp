;;; A basic app should end up looking something like this.

(ql:quickload 'dexter)
(defclass folder-app (dexter:application)
  ()
  ;; a place for timeout functions and the main loop.
  )
(defclass folder-object ()
  ()
  ;; a representation of the directory.
  )
(defclass folder-window (dexter:window)
  ()
  ;; a field of icons
  )

(defun main (directory timestamp &rest argv)
  (let* ((app (make-instance 'folder-app)
         (dir (make-instance 'folder-object :directory directory))
         (win (make-instance 'folder-window :app app
                                            :value dir
                                            :timestamp timestamp))))
    (dexter:run app)))