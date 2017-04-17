class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  Mover(float m, float x, float y) {
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = m;
  }
  
  void applyForce(PVector force) {
    if (DispForces) {
      displayForces(force);
    }
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    stroke(175);
    fill(175);
    ellipse(location.x,location.y,mass,mass);
  }
  
  void displayForces(PVector force) {
    PVector endV = force.copy();
    endV.mult(50);
    stroke(255,0,0);
    pushMatrix();
    translate(location.x,location.y);
    line(0,0,endV.x,endV.y);
    popMatrix();
  }
}