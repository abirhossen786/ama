;; Auto-generated. Do not edit!


(when (boundp 'hospitalbot::Communication)
  (if (not (find-package "HOSPITALBOT"))
    (make-package "HOSPITALBOT"))
  (shadow 'Communication (find-package "HOSPITALBOT")))
(unless (find-package "HOSPITALBOT::COMMUNICATION")
  (make-package "HOSPITALBOT::COMMUNICATION"))

(in-package "ROS")
;;//! \htmlinclude Communication.msg.html


(defclass hospitalbot::Communication
  :super ros::object
  :slots (_source _target _type _metadata _status ))

(defmethod hospitalbot::Communication
  (:init
   (&key
    ((:source __source) "")
    ((:target __target) "")
    ((:type __type) "")
    ((:metadata __metadata) "")
    ((:status __status) "")
    )
   (send-super :init)
   (setq _source (string __source))
   (setq _target (string __target))
   (setq _type (string __type))
   (setq _metadata (string __metadata))
   (setq _status (string __status))
   self)
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:target
   (&optional __target)
   (if __target (setq _target __target)) _target)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:metadata
   (&optional __metadata)
   (if __metadata (setq _metadata __metadata)) _metadata)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:serialization-length
   ()
   (+
    ;; string _source
    4 (length _source)
    ;; string _target
    4 (length _target)
    ;; string _type
    4 (length _type)
    ;; string _metadata
    4 (length _metadata)
    ;; string _status
    4 (length _status)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _source
       (write-long (length _source) s) (princ _source s)
     ;; string _target
       (write-long (length _target) s) (princ _target s)
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; string _metadata
       (write-long (length _metadata) s) (princ _metadata s)
     ;; string _status
       (write-long (length _status) s) (princ _status s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _source
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _source (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _target
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _target (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _metadata
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _metadata (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _status
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _status (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get hospitalbot::Communication :md5sum-) "bc0cceee922687683f945debbb6595bd")
(setf (get hospitalbot::Communication :datatype-) "hospitalbot/Communication")
(setf (get hospitalbot::Communication :definition-)
      "string source
string target
string type
string metadata
string status
")



(provide :hospitalbot/Communication "bc0cceee922687683f945debbb6595bd")


