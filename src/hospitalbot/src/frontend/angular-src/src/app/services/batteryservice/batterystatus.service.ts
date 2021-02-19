import { Injectable } from '@angular/core';
import { Subject } from 'rxjs/Subject';
import { Observable } from 'rxjs/Rx';
import * as io from 'socket.io-client';

@Injectable()
export class BatteryStatusService {
  private url = 'http://localhost:3000';
  private socket;

  getBatteryPercentage() {
    this.socket = io(this.url);
    return Observable.fromEvent(this.socket, 'battery');
  }

  sendChatter() {
    this.socket = io(this.url);
    this.socket.emit('chatter', 'hello world');
  }
}
