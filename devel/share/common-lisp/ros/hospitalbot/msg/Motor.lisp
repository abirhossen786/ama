; Auto-generated. Do not edit!


(cl:in-package hospitalbot-msg)


;//! \htmlinclude Motor.msg.html

(cl:defclass <Motor> (roslisp-msg-protocol:ros-message)
  ((left_velocity
    :reader left_velocity
    :initarg :left_velocity
    :type cl:float
    :initform 0.0)
   (right_velocity
    :reader right_velocity
    :initarg :right_velocity
    :type cl:float
    :initform 0.0)
   (time
    :reader time
    :initarg :time
    :type cl:integer
    :initform 0))
)

(cl:defclass Motor (<Motor>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Motor>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Motor)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hospitalbot-msg:<Motor> is deprecated: use hospitalbot-msg:Motor instead.")))

(cl:ensure-generic-function 'left_velocity-val :lambda-list '(m))
(cl:defmethod left_velocity-val ((m <Motor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hospitalbot-msg:left_velocity-val is deprecated.  Use hospitalbot-msg:left_velocity instead.")
  (left_velocity m))

(cl:ensure-generic-function 'right_velocity-val :lambda-list '(m))
(cl:defmethod right_velocity-val ((m <Motor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hospitalbot-msg:right_velocity-val is deprecated.  Use hospitalbot-msg:right_velocity instead.")
  (right_velocity m))

(cl:ensure-generic-function 'time-val :lambda-list '(m))
(cl:defmethod time-val ((m <Motor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hospitalbot-msg:time-val is deprecated.  Use hospitalbot-msg:time instead.")
  (time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Motor>) ostream)
  "Serializes a message object of type '<Motor>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'left_velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'right_velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'time)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'time)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Motor>) istream)
  "Deserializes a message object of type '<Motor>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'left_velocity) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'right_velocity) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'time)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'time)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Motor>)))
  "Returns string type for a message object of type '<Motor>"
  "hospitalbot/Motor")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Motor)))
  "Returns string type for a message object of type 'Motor"
  "hospitalbot/Motor")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Motor>)))
  "Returns md5sum for a message object of type '<Motor>"
  "c2787926effe38eff5cbbbb8aa59dbcd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Motor)))
  "Returns md5sum for a message object of type 'Motor"
  "c2787926effe38eff5cbbbb8aa59dbcd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Motor>)))
  "Returns full string definition for message of type '<Motor>"
  (cl:format cl:nil "float64 left_velocity~%float64 right_velocity~%uint64 time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Motor)))
  "Returns full string definition for message of type 'Motor"
  (cl:format cl:nil "float64 left_velocity~%float64 right_velocity~%uint64 time~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Motor>))
  (cl:+ 0
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Motor>))
  "Converts a ROS message object to a list"
  (cl:list 'Motor
    (cl:cons ':left_velocity (left_velocity msg))
    (cl:cons ':right_velocity (right_velocity msg))
    (cl:cons ':time (time msg))
))
