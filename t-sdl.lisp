
(defpackage :things.t-sdl
  (:documentation "Screen handler for SDL things")
  (:use #:cl #:sdl #:things.generics)
  (:export #:t-sdl))

(in-package :things.t-sdl)

;; Local generics

(defgeneric update (updatable handler)
  (:documentation "Handles updatable's update changes."))

(defgeneric draw (drawable handler)
  (:documentation "Draws the drawable on the handler."))

;; T-SDL class

(defclass t-sdl (handler)
  ((updatables
    :initform nil
    :accessor updatables
    :documentation "List of objects with update method implementation.")
   (drawables
    :initform nil
    :accessor drawables
    :documentation "List of objects with draw method implementation."))
  (:documentation "This is the main handler for the SDL experiment screen."))

(defmethod startup ((handler t-sdl))
  "Starts up the SDL handler."
  (sdl:with-init (sdl:sdl-init-video sdl:sdl-init-audio)
    (sdl:window 800 600 :title-caption "SDL Experiment" :opengl t :double-buffer t)
    (setf (sdl:frame-rate) 60)

    (sdl:with-events ()
      (:quit-event () t)
      (:key-down-event ()
        (sdl:push-quit-event))
      (:idle ()
        ;; Update here
        (mapcar #'update (updatables handler))
             
        (sdl:clear-display sdl:*black*)
        ;; Draw here
        (mapcar #'draw (drawables handler))
        
        (sdl:update-display)))))

;;;; Updatable objects

