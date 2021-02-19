import { TestBed, inject } from '@angular/core/testing';

import { RobotStatusService } from './robotstatus.service';

describe('RobotstatusService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [RobotStatusService]
    });
  });

  it('should be created', inject([RobotStatusService], (service: RobotStatusService) => {
    expect(service).toBeTruthy();
  }));
});
