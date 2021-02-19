
(cl:in-package :asdf)

(defsystem "hospitalbot-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Battery" :depends-on ("_package_Battery"))
    (:file "_package_Battery" :depends-on ("_package"))
    (:file "Communication" :depends-on ("_package_Communication"))
    (:file "_package_Communication" :depends-on ("_package"))
    (:file "Motor" :depends-on ("_package_Motor"))
    (:file "_package_Motor" :depends-on ("_package"))
    (:file "RobotState" :depends-on ("_package_RobotState"))
    (:file "_package_RobotState" :depends-on ("_package"))
  ))