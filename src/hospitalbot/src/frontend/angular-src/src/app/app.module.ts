import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AppComponent } from './app.component';
import { TopBarComponent } from './components/topbar/topbar.component';
import { StandbyComponent } from './components/standby/standby.component';

import { BatteryStatusService } from './services/batteryservice/batterystatus.service';
import { RobotStatusService } from './services/robotstatusservice/robotstatus.service';

const appRoutes: Routes = [
  {path: '', component: StandbyComponent}
]; 

@NgModule({
  declarations: [
    AppComponent,
    TopBarComponent,
    StandbyComponent
  ],
  imports: [
    BrowserModule,
    RouterModule.forRoot(appRoutes)
  ],
  providers: [
    BatteryStatusService,
    RobotStatusService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
