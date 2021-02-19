import { Injectable, EventEmitter, Output } from '@angular/core';

@Injectable()
export class RobotStatusService {
  @Output() robotStatusUpdate: EventEmitter<string>;

  constructor() { 
    this.robotStatusUpdate = new EventEmitter();
  }

  getRobotStatus() {
    return this.robotStatusUpdate;
  }

  setRobotStatus(robotStatus) {
    this.robotStatusUpdate.emit(robotStatus);
  }
}
