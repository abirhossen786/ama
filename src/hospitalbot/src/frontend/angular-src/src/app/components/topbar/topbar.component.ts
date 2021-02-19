import { Component, OnInit } from '@angular/core';
import { BatteryStatusService } from '../../services/batteryservice/batterystatus.service';
import { RobotStatusService } from '../../services/robotstatusservice/robotstatus.service';

@Component({
  selector: 'app-topbar',
  templateUrl: './topbar.component.html',
  styleUrls: ['./topbar.component.css']
})
export class TopBarComponent implements OnInit {
  private batteryPercentage: string;
  private robotStatus: string;
  constructor(private batterStatusService: BatteryStatusService, private robotStatusService: RobotStatusService) { }

  ngOnInit() {
    this.batterStatusService.getBatteryPercentage().subscribe(batteryPercentage => {
      this.batteryPercentage = batteryPercentage.toString();
    });
    this.robotStatusService.getRobotStatus().subscribe(robotStatus => {
      this.robotStatus = robotStatus;
    });
  }
}
