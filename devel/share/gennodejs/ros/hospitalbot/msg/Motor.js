// Auto-generated. Do not edit!

// (in-package hospitalbot.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Motor {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.left_velocity = null;
      this.right_velocity = null;
      this.time = null;
    }
    else {
      if (initObj.hasOwnProperty('left_velocity')) {
        this.left_velocity = initObj.left_velocity
      }
      else {
        this.left_velocity = 0.0;
      }
      if (initObj.hasOwnProperty('right_velocity')) {
        this.right_velocity = initObj.right_velocity
      }
      else {
        this.right_velocity = 0.0;
      }
      if (initObj.hasOwnProperty('time')) {
        this.time = initObj.time
      }
      else {
        this.time = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Motor
    // Serialize message field [left_velocity]
    bufferOffset = _serializer.float64(obj.left_velocity, buffer, bufferOffset);
    // Serialize message field [right_velocity]
    bufferOffset = _serializer.float64(obj.right_velocity, buffer, bufferOffset);
    // Serialize message field [time]
    bufferOffset = _serializer.uint64(obj.time, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Motor
    let len;
    let data = new Motor(null);
    // Deserialize message field [left_velocity]
    data.left_velocity = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [right_velocity]
    data.right_velocity = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [time]
    data.time = _deserializer.uint64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'hospitalbot/Motor';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c2787926effe38eff5cbbbb8aa59dbcd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64 left_velocity
    float64 right_velocity
    uint64 time
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Motor(null);
    if (msg.left_velocity !== undefined) {
      resolved.left_velocity = msg.left_velocity;
    }
    else {
      resolved.left_velocity = 0.0
    }

    if (msg.right_velocity !== undefined) {
      resolved.right_velocity = msg.right_velocity;
    }
    else {
      resolved.right_velocity = 0.0
    }

    if (msg.time !== undefined) {
      resolved.time = msg.time;
    }
    else {
      resolved.time = 0
    }

    return resolved;
    }
};

module.exports = Motor;
