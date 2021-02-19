import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { StandbyComponent } from './standby.component';

describe('StandbyComponent', () => {
  let component: StandbyComponent;
  let fixture: ComponentFixture<StandbyComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ StandbyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StandbyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
