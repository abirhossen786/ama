;; Auto-generated. Do not edit!


(when (boundp 'hospitalbot::RobotState)
  (if (not (find-package "HOSPITALBOT"))
    (make-package "HOSPITALBOT"))
  (shadow 'RobotState (find-package "HOSPITALBOT")))
(unless (find-package "HOSPITALBOT::ROBOTSTATE")
  (make-package "HOSPITALBOT::ROBOTSTATE"))

(in-package "ROS")
;;//! \htmlinclude RobotState.msg.html


(defclass hospitalbot::RobotState
  :super ros::object
  :slots (_id _activity _message ))

(defmethod hospitalbot::RobotState
  (:init
   (&key
    ((:id __id) 0)
    ((:activity __activity) 0)
    ((:message __message) "")
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _activity (round __activity))
   (setq _message (string __message))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:activity
   (&optional __activity)
   (if __activity (setq _activity __activity)) _activity)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; uint8 _id
    1
    ;; uint8 _activity
    1
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _id
       (write-byte _id s)
     ;; uint8 _activity
       (write-byte _activity s)
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _id
     (setq _id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _activity
     (setq _activity (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get hospitalbot::RobotState :md5sum-) "54b870aa9b4f60acf1f190ddb8fbd201")
(setf (get hospitalbot::RobotState :datatype-) "hospitalbot/RobotState")
(setf (get hospitalbot::RobotState :definition-)
      "uint8 id
uint8 activity
string message

")



(provide :hospitalbot/RobotState "54b870aa9b4f60acf1f190ddb8fbd201")


