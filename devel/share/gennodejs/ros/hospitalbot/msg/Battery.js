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

class Battery {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.voltage = null;
      this.maximum_level = null;
      this.current_level = null;
      this.charging = null;
    }
    else {
      if (initObj.hasOwnProperty('voltage')) {
        this.voltage = initObj.voltage
      }
      else {
        this.voltage = 0.0;
      }
      if (initObj.hasOwnProperty('maximum_level')) {
        this.maximum_level = initObj.maximum_level
      }
      else {
        this.maximum_level = 0;
      }
      if (initObj.hasOwnProperty('current_level')) {
        this.current_level = initObj.current_level
      }
      else {
        this.current_level = 0;
      }
      if (initObj.hasOwnProperty('charging')) {
        this.charging = initObj.charging
      }
      else {
        this.charging = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Battery
    // Serialize message field [voltage]
    bufferOffset = _serializer.float32(obj.voltage, buffer, bufferOffset);
    // Serialize message field [maximum_level]
    bufferOffset = _serializer.uint8(obj.maximum_level, buffer, bufferOffset);
    // Serialize message field [current_level]
    bufferOffset = _serializer.uint8(obj.current_level, buffer, bufferOffset);
    // Serialize message field [charging]
    bufferOffset = _serializer.bool(obj.charging, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Battery
    let len;
    let data = new Battery(null);
    // Deserialize message field [voltage]
    data.voltage = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [maximum_level]
    data.maximum_level = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [current_level]
    data.current_level = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [charging]
    data.charging = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 7;
  }

  static datatype() {
    // Returns string type for a message object
    return 'hospitalbot/Battery';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e743845835d4deeeefdd5b5abae7a1f4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 voltage
    uint8 maximum_level
    uint8 current_level
    bool charging
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Battery(null);
    if (msg.voltage !== undefined) {
      resolved.voltage = msg.voltage;
    }
    else {
      resolved.voltage = 0.0
    }

    if (msg.maximum_level !== undefined) {
      resolved.maximum_level = msg.maximum_level;
    }
    else {
      resolved.maximum_level = 0
    }

    if (msg.current_level !== undefined) {
      resolved.current_level = msg.current_level;
    }
    else {
      resolved.current_level = 0
    }

    if (msg.charging !== undefined) {
      resolved.charging = msg.charging;
    }
    else {
      resolved.charging = false
    }

    return resolved;
    }
};

module.exports = Battery;
