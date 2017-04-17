class Attractor {
  float mass;
  float G;
  float x;
  float y;
  PVector location;
  
  Attractor(float m,float x_, float y_) {
    mass = m;
    x = x_;
    y = y_;
    G = 0.4;
    location = new PVector(x, y);
  }
  
  PVector attract(Mover m) {
    //PVector force = PVector.sub(location - m.location);
    PVector force = location.copy();
    force.sub(m.location);
    float distance = force.mag();
    distance = constrain(distance,10.0,20.0);
    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
  
  void display() {
    stroke(#F26405);
    fill(#F26405);
    ellipse(location.x,location.y,mass,mass);
  }
}