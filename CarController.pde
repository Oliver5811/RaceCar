class CarController {
  //Forbinder - Sensorer & Hjerne & Bil
  float varians             = 2; //hvor stor er variansen på de tilfældige vægte og bias
  Car bil                    = new Car();
  NeuralNetwork hjerne       = new NeuralNetwork(varians); 
  SensorSystem  sensorSystem = new SensorSystem();
  boolean isDead             = false;
      
  void update() {
    //1.)opdtarer bil 
    bil.update();
    //2.)opdaterer sensorer    
    sensorSystem.updateSensorsignals(bil.pos, bil.vel);
    isDead = get(int(bil.pos.x), int(bil.pos.y)) == -1 ? true : false;
    //3.)hjernen beregner hvor meget der skal drejes
    float turnAngle = 0;
    float x1 = int(sensorSystem.leftSensorSignal);
    float x2 = int(sensorSystem.frontSensorSignal);
    float x3 = int(sensorSystem.rightSensorSignal);  

    float y1 = int(sensorSystem.leftMidSensorSignal);
    float y2 = int(sensorSystem.frontMidSensorSignal);
    float y3 = int(sensorSystem.rightMidSensorSignal);

    float z1 = int(sensorSystem.leftBackSensorSignal);
    float z2 = int(sensorSystem.frontBackSensorSignal);
    float z3 = int(sensorSystem.rightBackSensorSignal);

    turnAngle = hjerne.getOutput(x1, x2, x3, y1, y2, y3, z1, z2, z3);    
    //4.)bilen drejes
    bil.turnCar(turnAngle);
  }
  
  void display(){
    bil.displayCar();
    sensorSystem.displaySensors();
  }
}
