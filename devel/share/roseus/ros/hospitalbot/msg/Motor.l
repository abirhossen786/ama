;; Auto-generated. Do not edit!


(when (boundp 'hospitalbot::Motor)
  (if (not (find-package "HOSPITALBOT"))
    (make-package "HOSPITALBOT"))
  (shadow 'Motor (find-package "HOSPITALBOT")))
(unless (find-package "HOSPITALBOT::MOTOR")
  (make-package "HOSPITALBOT::MOTOR"))

(in-package "ROS")
;;//! \htmlinclude Motor.msg.html


(defclass hospitalbot::Motor
  :super ros::object
  :slots (_left_velocity _right_velocity _time ))

(defmethod hospitalbot::Motor
  (:init
   (&key
    ((:left_velocity __left_velocity) 0.0)
    ((:right_velocity __right_velocity) 0.0)
    ((:time __time) 0)
    )
   (send-super :init)
   (setq _left_velocity (float __left_velocity))
   (setq _right_velocity (float __right_velocity))
   (setq _time (round __time))
   self)
  (:left_velocity
   (&optional __left_velocity)
   (if __left_velocity (setq _left_velocity __left_velocity)) _left_velocity)
  (:right_velocity
   (&optional __right_velocity)
   (if __right_velocity (setq _right_velocity __right_velocity)) _right_velocity)
  (:time
   (&optional __time)
   (if __time (setq _time __time)) _time)
  (:serialization-length
   ()
   (+
    ;; float64 _left_velocity
    8
    ;; float64 _right_velocity
    8
    ;; uint64 _time
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _left_velocity
       (sys::poke _left_velocity (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _right_velocity
       (sys::poke _right_velocity (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; uint64 _time
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _time (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _time) (= (length (_time . bv)) 2)) ;; bignum
              (write-long (ash (elt (_time . bv) 0) 0) s)
              (write-long (ash (elt (_time . bv) 1) -1) s))
             ((and (class _time) (= (length (_time . bv)) 1)) ;; big1
              (write-long (elt (_time . bv) 0) s)
              (write-long (if (>= _time 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _time s)(write-long (if (>= _time 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _left_velocity
     (setq _left_velocity (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _right_velocity
     (setq _right_velocity (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; uint64 _time
     
#+(or :alpha :irix6 :x86_64)
      (setf _time (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _time (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(setf (get hospitalbot::Motor :md5sum-) "c2787926effe38eff5cbbbb8aa59dbcd")
(setf (get hospitalbot::Motor :datatype-) "hospitalbot/Motor")
(setf (get hospitalbot::Motor :definition-)
      "float64 left_velocity
float64 right_velocity
uint64 time

")



(provide :hospitalbot/Motor "c2787926effe38eff5cbbbb8aa59dbcd")


