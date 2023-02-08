class Car {  
  //Bil - indeholder position & hastighed & "tegning"
  PVector pos = new PVector(520, 500);
  PVector vel = new PVector(0, 5);

  
  void turnCar(float turnAngle){
    vel.rotate(turnAngle);
  }

  void displayCar() {
    stroke(100);
    fill(100);
    ellipse(pos.x, pos.y, 10, 10);
  }
  
  void update() {
    pos.add(vel);
    //test med at ændre hastighed
   // if (frameCount != 0 && frameCount % 1999 == 0){
     // vel = new PVector(vel.x, vel.y + 20);
    //}
    
  }
  
}
