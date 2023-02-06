class SensorSystem {
  //SensorSystem - alle bilens sensorer - ogå dem der ikke bruges af "hjernen"
  
  //wall detectors
  float sensorMag = 100;
  float sensorAngle = PI*2/8;
  
  PVector anchorPos           = new PVector();
  
  PVector sensorVectorFront   = new PVector(0, sensorMag);
  PVector sensorVectorLeft    = new PVector(0, sensorMag);
  PVector sensorVectorRight   = new PVector(0, sensorMag);

  PVector sensorVectorFrontMid   = new PVector(0, sensorMag * 0.5);
  PVector sensorVectorLeftMid    = new PVector(0, sensorMag * 0.5);
  PVector sensorVectorRightMid   = new PVector(0, sensorMag * 0.5);

  PVector sensorVectorFrontBack   = new PVector(0, sensorMag * 0.25);
  PVector sensorVectorLeftBack    = new PVector(0, sensorMag * 0.25);
  PVector sensorVectorRightBack   = new PVector(0, sensorMag * 0.25);

  boolean frontSensorSignal   = false;
  boolean leftSensorSignal    = false;
  boolean rightSensorSignal   = false;

  boolean frontMidSensorSignal   = false;
  boolean leftMidSensorSignal    = false;
  boolean rightMidSensorSignal   = false;

  boolean frontBackSensorSignal   = false;
  boolean leftBackSensorSignal    = false;
  boolean rightBackSensorSignal   = false;

  //crash detection
  int whiteSensorFrameCount    = 0; //udenfor banen

  //clockwise rotation detection
  PVector centerToCarVector     = new PVector();
  float   lastRotationAngle   = -1;
  float   clockWiseRotationFrameCounter  = 0;

  //lapTime calculation
  boolean lastGreenDetection;
  int     lastTimeInFrames      = 0;
  int     lapTimeInFrames       = 10000;
  int     score                = 0;
  boolean lastGreen            = true;

  void displaySensors() {
    strokeWeight(0.5);
    if (frontSensorSignal) { 
      fill(255, 0, 0);
      ellipse(anchorPos.x+sensorVectorFront.x, anchorPos.y+sensorVectorFront.y, 8, 8);
    }
    if (leftSensorSignal) { 
      fill(255, 0, 0);
      ellipse( anchorPos.x+sensorVectorLeft.x, anchorPos.y+sensorVectorLeft.y, 8, 8);
    }
    if (rightSensorSignal) { 
      fill(255, 0, 0);
      ellipse( anchorPos.x+sensorVectorRight.x, anchorPos.y+sensorVectorRight.y, 8, 8);
    }
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorFront.x, anchorPos.y+sensorVectorFront.y);
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorLeft.x, anchorPos.y+sensorVectorLeft.y);
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorRight.x, anchorPos.y+sensorVectorRight.y);

    if (frontMidSensorSignal) { 
      fill(255, 0, 0);
      ellipse(anchorPos.x+sensorVectorFrontMid.x, anchorPos.y+sensorVectorFrontMid.y, 8, 8);
    }
    if (leftMidSensorSignal) { 
      fill(255, 0, 0);
      ellipse( anchorPos.x+sensorVectorLeftMid.x, anchorPos.y+sensorVectorLeftMid.y, 8, 8);
    }
    if (rightMidSensorSignal) { 
      fill(255, 0, 0);
      ellipse( anchorPos.x+sensorVectorRightMid.x, anchorPos.y+sensorVectorRightMid.y, 8, 8);
    }
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorFrontMid.x, anchorPos.y+sensorVectorFrontMid.y);
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorLeftMid.x, anchorPos.y+sensorVectorLeftMid.y);
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorRightMid.x, anchorPos.y+sensorVectorRightMid.y);

    if (frontBackSensorSignal) { 
      fill(255, 0, 0);
      ellipse(anchorPos.x+sensorVectorFrontBack.x, anchorPos.y+sensorVectorFrontBack.y, 8, 8);
    }
    if (leftBackSensorSignal) { 
      fill(255, 0, 0);
      ellipse( anchorPos.x+sensorVectorLeftBack.x, anchorPos.y+sensorVectorLeftBack.y, 8, 8);
    }
    if (rightBackSensorSignal) { 
      fill(255, 0, 0);
      ellipse( anchorPos.x+sensorVectorRightBack.x, anchorPos.y+sensorVectorRightBack.y, 8, 8);
    }
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorFrontBack.x, anchorPos.y+sensorVectorFrontBack.y);
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorLeftBack.x, anchorPos.y+sensorVectorLeftBack.y);
    line(anchorPos.x, anchorPos.y, anchorPos.x+sensorVectorRightBack.x, anchorPos.y+sensorVectorRightBack.y);

    strokeWeight(2);
    if (whiteSensorFrameCount>0) {
      fill(whiteSensorFrameCount*10, 0, 0);
    } else {
      fill(0, clockWiseRotationFrameCounter, 0);
    }
    ellipse(anchorPos.x, anchorPos.y, 10, 10);
  }

  void updateSensorsignals(PVector pos, PVector vel) {
    //Collision detectors
    frontSensorSignal = get(int(pos.x+sensorVectorFront.x), int(pos.y+sensorVectorFront.y))==-1?true:false;
    leftSensorSignal = get(int(pos.x+sensorVectorLeft.x), int(pos.y+sensorVectorLeft.y))==-1?true:false;
    rightSensorSignal = get(int(pos.x+sensorVectorRight.x), int(pos.y+sensorVectorRight.y))==-1?true:false;  

    frontMidSensorSignal = get(int(pos.x+sensorVectorFrontMid.x), int(pos.y+sensorVectorFrontMid.y))==-1?true:false;
    leftMidSensorSignal = get(int(pos.x+sensorVectorLeftMid.x), int(pos.y+sensorVectorLeftMid.y))==-1?true:false;
    rightMidSensorSignal = get(int(pos.x+sensorVectorRightMid.x), int(pos.y+sensorVectorRightMid.y))==-1?true:false;

    frontBackSensorSignal = get(int(pos.x+sensorVectorFrontBack.x), int(pos.y+sensorVectorFrontBack.y))==-1?true:false;
    leftBackSensorSignal = get(int(pos.x+sensorVectorLeftBack.x), int(pos.y+sensorVectorLeftBack.y))==-1?true:false;
    rightBackSensorSignal = get(int(pos.x+sensorVectorRightBack.x), int(pos.y+sensorVectorRightBack.y))==-1?true:false;

    //Crash detector
    color color_car_position = get(int(pos.x), int(pos.y));
    //Laptime calculation
    boolean currentGreenDetection =false;
    if (lastGreen && red(color_car_position)==0 && blue(color_car_position)>100 && green(color_car_position)!=0){
      currentGreenDetection = true;
      score++;
      lastGreen = false;
    } else if (!lastGreen && red(color_car_position)==0 && blue(color_car_position)<100 && green(color_car_position)!=0){
      currentGreenDetection = true;
      score++;
      lastGreen = true;
    }

    if (lastGreenDetection && !currentGreenDetection) {  //sidst grønt - nu ikke -vi har passeret målstregen 
      lapTimeInFrames = frameCount - lastTimeInFrames; //LAPTIME BEREGNES - frames nu - frames sidst
      lastTimeInFrames = frameCount;
    }   
    lastGreenDetection = currentGreenDetection; //Husker om der var grønt sidst
    //count clockWiseRotationFrameCounter
    centerToCarVector.set((height/2)-pos.x, (width/2)-pos.y);    
    float currentRotationAngle =  centerToCarVector.heading();
    float deltaHeading   =  lastRotationAngle - centerToCarVector.heading();
    clockWiseRotationFrameCounter  =  deltaHeading>0 ? clockWiseRotationFrameCounter + 1 : clockWiseRotationFrameCounter -1;
    lastRotationAngle = currentRotationAngle;
    
    updateSensorVectors(vel);
    
    anchorPos.set(pos.x,pos.y);
  }

  void updateSensorVectors(PVector vel) {
    if (vel.mag()!=0) {
      sensorVectorFront.set(vel);
      sensorVectorFront.normalize();
      sensorVectorFront.mult(sensorMag);

      sensorVectorFrontMid.set(vel);
      sensorVectorFrontMid.normalize();
      sensorVectorFrontMid.mult(sensorMag/2);

      sensorVectorFrontBack.set(vel);
      sensorVectorFrontBack.normalize();
      sensorVectorFrontBack.mult(sensorMag/4);
    }
    sensorVectorLeft.set(sensorVectorFront);
    sensorVectorLeft.rotate(-sensorAngle);
    sensorVectorRight.set(sensorVectorFront);
    sensorVectorRight.rotate(sensorAngle);

    sensorVectorLeftMid.set(sensorVectorFrontMid);
    sensorVectorLeftMid.rotate(-sensorAngle);
    sensorVectorRightMid.set(sensorVectorFrontMid);
    sensorVectorRightMid.rotate(sensorAngle);

    sensorVectorLeftBack.set(sensorVectorFrontBack);
    sensorVectorLeftBack.rotate(-sensorAngle);
    sensorVectorRightBack.set(sensorVectorFrontBack);
    sensorVectorRightBack.rotate(sensorAngle);
  }
}
