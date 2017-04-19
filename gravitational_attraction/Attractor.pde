class Attractor {
  
  //The mass of the attractor
  float mass;
  
  //The Gravity global constant
  float G;
  
  //Attractor position on screen
  float x;
  float y;
  PVector location;
  
  
  //When creating new attractor we get as parameters the mass and the position
  Attractor(float m,float x_, float y_) {
    mass = m;
    x = x_;
    y = y_;
    location = new PVector(x, y);
    
    //The bigger the number the grater the forces
    G = 1;
  }
  
  
  //Calculate the force the attractor has on the mover
  PVector attract(Mover m) {
    PVector force = location.copy();
    force.sub(m.location);
    float distance = force.mag();
    
    //constrain the distance between 10-100
    distance = constrain(distance,20,100);
    
    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }
  
  
  //Display the attractor on screen
  void display() {
    stroke(#B94F0D);
    strokeWeight(mass/20);
    fill(#F26405);
    ellipse(location.x,location.y,mass,mass);
  }
}