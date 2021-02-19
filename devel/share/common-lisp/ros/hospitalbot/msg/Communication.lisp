; Auto-generated. Do not edit!


(cl:in-package hospitalbot-msg)


;//! \htmlinclude Communication.msg.html

(cl:defclass <Communication> (roslisp-msg-protocol:ros-message)
  ((source
    :reader source
    :initarg :source
    :type cl:string
    :initform "")
   (target
    :reader target
    :initarg :target
    :type cl:string
    :initform "")
   (type
    :reader type
    :initarg :type
    :type cl:string
    :initform "")
   (metadata
    :reader metadata
    :initarg :metadata
    :type cl:string
    :initform "")
   (status
    :reader status
    :initarg :status
    :type cl:string
    :initform ""))
)

(cl:defclass Communication (<Communication>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Communication>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Communication)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hospitalbot-msg:<Communication> is deprecated: use hospitalbot-msg:Communication instead.")))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <Communication>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hospitalbot-msg:source-val is deprecated.  Use hospitalbot-msg:source instead.")
  (source m))

(cl:ensure-generic-function 'target-val :lambda-list '(m))
(cl:defmethod target-val ((m <Communication>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hospitalbot-msg:target-val is deprecated.  Use hospitalbot-msg:target instead.")
  (target m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <Communication>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hospitalbot-msg:type-val is deprecated.  Use hospitalbot-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'metadata-val :lambda-list '(m))
(cl:defmethod metadata-val ((m <Communication>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hospitalbot-msg:metadata-val is deprecated.  Use hospitalbot-msg:metadata instead.")
  (metadata m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <Communication>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hospitalbot-msg:status-val is deprecated.  Use hospitalbot-msg:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Communication>) ostream)
  "Serializes a message object of type '<Communication>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'source))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'source))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'target))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'target))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'metadata))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'metadata))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'status))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'status))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Communication>) istream)
  "Deserializes a message object of type '<Communication>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'source) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'source) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'target) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'target) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'metadata) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'metadata) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'status) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Communication>)))
  "Returns string type for a message object of type '<Communication>"
  "hospitalbot/Communication")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Communication)))
  "Returns string type for a message object of type 'Communication"
  "hospitalbot/Communication")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Communication>)))
  "Returns md5sum for a message object of type '<Communication>"
  "bc0cceee922687683f945debbb6595bd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Communication)))
  "Returns md5sum for a message object of type 'Communication"
  "bc0cceee922687683f945debbb6595bd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Communication>)))
  "Returns full string definition for message of type '<Communication>"
  (cl:format cl:nil "string source~%string target~%string type~%string metadata~%string status~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Communication)))
  "Returns full string definition for message of type 'Communication"
  (cl:format cl:nil "string source~%string target~%string type~%string metadata~%string status~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Communication>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'source))
     4 (cl:length (cl:slot-value msg 'target))
     4 (cl:length (cl:slot-value msg 'type))
     4 (cl:length (cl:slot-value msg 'metadata))
     4 (cl:length (cl:slot-value msg 'status))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Communication>))
  "Converts a ROS message object to a list"
  (cl:list 'Communication
    (cl:cons ':source (source msg))
    (cl:cons ':target (target msg))
    (cl:cons ':type (type msg))
    (cl:cons ':metadata (metadata msg))
    (cl:cons ':status (status msg))
))
