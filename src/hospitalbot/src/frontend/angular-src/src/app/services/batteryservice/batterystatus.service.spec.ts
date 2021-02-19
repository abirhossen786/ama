import { TestBed, inject } from '@angular/core/testing';

import { BatteryStatusService } from './batterystatus.service';

describe('BatterystatusService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [BatteryStatusService]
    });
  });

  it('should be created', inject([BatteryStatusService], (service: BatteryStatusService) => {
    expect(service).toBeTruthy();
  }));
});
