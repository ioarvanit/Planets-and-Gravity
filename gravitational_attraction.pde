Mover[] movers = new Mover[100];              //An array to store all mover objects
Attractor[] attractors = new Attractor[100];  //An array to store all attractor objects
int mcount,acount;                            //the number of movers and attractors created
PVector tempCenter,tempEdge,tempDiam;         //temporary vectors for drawing movers and attractors with mouse 
Boolean DispForces;

void setup() {
  size(1200,900);
  
  DispForces = false;
   
  //Initialize the movers and attractors count
  mcount = 0;
  acount = 0;
}

void draw() {
  
  //clear the background and erase all objects
  background(0);
  
  //if mouse is pressed we are creating a new mover or attractor
  if (mousePressed) {
    if (mouseButton == LEFT) {
      //Mover colors
      stroke(175);
      fill(175);
    } else if (mouseButton == RIGHT) {
      //Attractor colors
      stroke(#F26405);
      fill(#F26405);
    }
    //Draw the temporary object on screen
    tempEdge = new PVector(mouseX,mouseY);
    tempDiam = PVector.sub(tempCenter,tempEdge);
    ellipse(tempCenter.x,tempCenter.y,2*tempDiam.mag(),2*tempDiam.mag());
   }
  
  //Display all attractors
  for (int i = 0; i < acount; i++) {
    attractors[i].display();
  }

  //Update and display all mover objects
  for (int i = 0; i < mcount; i++) {
    for (int j = 0; j < acount; j++) {
      PVector f = attractors[j].attract(movers[i]);
      movers[i].applyForce(f);
    }
    movers[i].update();
    movers[i].display();
  }
}

void mousePressed() {
  tempCenter = new PVector(mouseX,mouseY);
}


//When mouse clicked create a new mover
void mouseReleased() {
  if (mouseButton == LEFT) {
    movers[mcount] = new Mover(2*tempDiam.mag(),tempCenter.x,tempCenter.y);
    mcount++;
  } else if (mouseButton == RIGHT) {
    attractors[acount] = new Attractor(2*tempDiam.mag(),tempCenter.x,tempCenter.y);
    acount++;
  }
  
}

void keyPressed() {
  if (key == 'f' || key == 'F' || key == 'φ' || key == 'Φ') {
    DispForces = !DispForces; 
  }
}