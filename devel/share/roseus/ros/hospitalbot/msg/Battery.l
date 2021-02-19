;; Auto-generated. Do not edit!


(when (boundp 'hospitalbot::Battery)
  (if (not (find-package "HOSPITALBOT"))
    (make-package "HOSPITALBOT"))
  (shadow 'Battery (find-package "HOSPITALBOT")))
(unless (find-package "HOSPITALBOT::BATTERY")
  (make-package "HOSPITALBOT::BATTERY"))

(in-package "ROS")
;;//! \htmlinclude Battery.msg.html


(defclass hospitalbot::Battery
  :super ros::object
  :slots (_voltage _maximum_level _current_level _charging ))

(defmethod hospitalbot::Battery
  (:init
   (&key
    ((:voltage __voltage) 0.0)
    ((:maximum_level __maximum_level) 0)
    ((:current_level __current_level) 0)
    ((:charging __charging) nil)
    )
   (send-super :init)
   (setq _voltage (float __voltage))
   (setq _maximum_level (round __maximum_level))
   (setq _current_level (round __current_level))
   (setq _charging __charging)
   self)
  (:voltage
   (&optional __voltage)
   (if __voltage (setq _voltage __voltage)) _voltage)
  (:maximum_level
   (&optional __maximum_level)
   (if __maximum_level (setq _maximum_level __maximum_level)) _maximum_level)
  (:current_level
   (&optional __current_level)
   (if __current_level (setq _current_level __current_level)) _current_level)
  (:charging
   (&optional __charging)
   (if __charging (setq _charging __charging)) _charging)
  (:serialization-length
   ()
   (+
    ;; float32 _voltage
    4
    ;; uint8 _maximum_level
    1
    ;; uint8 _current_level
    1
    ;; bool _charging
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _voltage
       (sys::poke _voltage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _maximum_level
       (write-byte _maximum_level s)
     ;; uint8 _current_level
       (write-byte _current_level s)
     ;; bool _charging
       (if _charging (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _voltage
     (setq _voltage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _maximum_level
     (setq _maximum_level (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _current_level
     (setq _current_level (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _charging
     (setq _charging (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get hospitalbot::Battery :md5sum-) "e743845835d4deeeefdd5b5abae7a1f4")
(setf (get hospitalbot::Battery :datatype-) "hospitalbot/Battery")
(setf (get hospitalbot::Battery :definition-)
      "float32 voltage
uint8 maximum_level
uint8 current_level
bool charging
")



(provide :hospitalbot/Battery "e743845835d4deeeefdd5b5abae7a1f4")


