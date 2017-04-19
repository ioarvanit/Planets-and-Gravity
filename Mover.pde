class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  //When a mover is created we pass as arguments the mass and the location
  Mover(float m, float x, float y) {
    location = new PVector(x,y);
    mass = m;
    
    //When a mover is created it has no velocity and acceleration
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  
  //Apply a force to the mover by an attractor
  void applyForce(PVector force) {
    if (DisplayForcesOn) {
      displayForces(force);
    }
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  
  //Update the velocity and location o mover
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  
  //Display the mover on screen
  void display() {
    strokeWeight(mass/10);
    stroke(80);
    fill(175);
    ellipse(location.x,location.y,mass,mass);
  }
  
  
  //Display forces by attractors
  void displayForces(PVector force) {
    PVector endV = force.copy();
    endV.mult(100);
    float strength = endV.mag();
    strength = constrain(strength,0.0,mass);
    strokeWeight(strength/10);
    stroke(#B94F0D);
    pushMatrix();
    translate(location.x,location.y);
    line(0,0,endV.x,endV.y);
    popMatrix();
  }
}