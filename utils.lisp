
(defpackage :things.utils
  (:documentation "Various useful and useless utils.")
  (:use #:cl)
  (:export #:qpush #:qpop #:qmake))

(in-package :things.utils)

(defun qmake ()
  (list nil))

(defun qpush (queue item)
  "Pushes a value into a queue."
  (let ((l (list item)))
    (if (and queue (car queue))
        (setf (cddr queue) l
              (cdr queue) (cddr queue))
        (when queue
            (setf (car queue) l
                  (cdr queue) l))))
  queue)

(defun qpop (queue)
  "Pops a value from a queue."
  (let ((v (caar queue)))
    (setf (car queue) (cdar queue))
    (unless (car queue)
      (setf (cdr queue) nil))
    v))

(defun qlength (queue)
  "Returns the size of the queue."
  (length (car queue)))
