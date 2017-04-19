//An array to store all mover objects, maximum 100
Mover[] movers = new Mover[99];              

//An array to store all attractor objects, maximum 100
Attractor[] attractors = new Attractor[99];  

//The number of movers and attractors created
int mCount,aCount;   

//Temporary vectors for drawing movers and attractors with mouse
PVector tempCenter,tempEdge,tempDiam;

//Boolean for wether to display forces or not
Boolean DisplayForcesOn;


void setup() {
  size(1200,900);
  
  //Don not display forces
  DisplayForcesOn = false;
   
  //Initialize the movers and attractors count
  mCount = 0;
  aCount = 0;
}


void draw() {
  
  //clear the background and erase all objects
  background(0);
  
  //Write instructions on screen
  fill(#00DCE5);
  textSize(20);
  text("Click and drag left mouse button to draw moving objects",20,20);
  text("Click and drag right mouse button to draw attracting objects",20,40);
  text("Toggle show forces on and off with f key",20,60);
  
  //If mouse is pressed we are creating a new mover or attractor. Left button for mover and right for attractor
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
  for (int i = 0; i < aCount; i++) {
    attractors[i].display();
  }

  //Update and display all mover objects
  for (int i = 0; i < mCount; i++) {
    for (int j = 0; j < aCount; j++) {
      PVector f = attractors[j].attract(movers[i]);
      movers[i].applyForce(f);
    }
    movers[i].update();
    movers[i].display();
  }
}


//When mouse is first pressed that will be the center of the new object
void mousePressed() {
  tempCenter = new PVector(mouseX,mouseY);
}


//When mouse is released then we create the mover or attractor
void mouseReleased() {
  if (mouseButton == LEFT) {
    if (mCount < 99) {
      movers[mCount] = new Mover(2*tempDiam.mag(),tempCenter.x,tempCenter.y);
      mCount++;
    } else {
      println("Maximum number of mover objects (100) reached!");
    }
  } else if (mouseButton == RIGHT) {
    if (aCount < 99) {
      attractors[aCount] = new Attractor(2*tempDiam.mag(),tempCenter.x,tempCenter.y);
      aCount++;
    } else {
      println("Maximum number of attractor objects (100) reached!");
    }
  } 
}


//Toggle the display forces with f key
void keyPressed() {
  if (key == 'f' || key == 'F' || key == 'φ' || key == 'Φ') {
    DisplayForcesOn = !DisplayForcesOn; 
  }
}