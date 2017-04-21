//An array to store all mover objects, maximum 50
Mover[] movers = new Mover[49];              

//An array to store all attractor objects, maximum 50
Attractor[] attractors = new Attractor[49];

//All available colors for attractor objects
float[] hueValues = {35, 55, 75, 160, 180, 210, 240, 265, 290, 320, 360};
int hueIndex;

//The number of movers and attractors created
int mCount,aCount;

//Temporary vectors for drawing movers and attractors with mouse
PVector tempCenter,tempEdge,tempRadius;

//Maximum and minimum values for attractor and mover radius
float maxRadius = 60;
float minRadius = 10;

//Boolean for wether to display forces or not
Boolean displayForcesOn;


void setup() {
  //Set window size and color mode
  size(1200,900);
  colorMode(HSB,360,100,100);
  
  //Don not display forces
  displayForcesOn = false;
   
  //Initialize the movers and attractors count
  mCount = 0;
  aCount = 0;
  
  //Initialize hue index
  hueIndex = 0;
}


void draw() {
  //clear the background
  background(180,0,0);
  
  //Write instructions on screen
  showInfo();
  
  //If mouse is pressed we are creating a new mover or attractor.
  if (mousePressed) {
    noStroke();
    if (mouseButton == LEFT) {
      fill(180,0,100);  //mover color
    } else {
      fill(hueValues[hueIndex],100,100);  //attractor color
    }
    //Calculate the radius of the object we are drawing  
    tempEdge = new PVector(mouseX,mouseY);
    tempRadius = PVector.sub(tempCenter,tempEdge);
    //Limit the radius between max and min values
    tempRadius.limit(maxRadius);
    if (tempRadius.mag() < minRadius) {
      tempRadius.setMag(minRadius);
    }
    //Draw the temporary circle on the screen
    ellipse(tempCenter.x,tempCenter.y,2*tempRadius.mag(),2*tempRadius.mag());
   }
  
  //Display all attractors
  for (int i = 0; i < aCount; i++) {
    attractors[i].display();
  }

  //Update and display all mover objects
  for (int i = 0; i < mCount; i++) {
    for (int j = 0; j < aCount; j++) {
      PVector f = attractors[j].attract(movers[i]);
      movers[i].applyForce(f,attractors[j].hue);
    }
    movers[i].update();
    movers[i].display();
  }
}


//When mouse is first pressed that will be the center of the new object
void mousePressed() {
  tempCenter = new PVector(mouseX,mouseY);
  if (mouseButton == RIGHT) {
    //Attractor colors
    if (hueIndex == hueValues.length - 1) {
      hueIndex = 0;
    } else {
      hueIndex++;
    }
  }
}


//When mouse is released then we create the mover or attractor
void mouseReleased() {
  if (mouseButton == LEFT) {
    if (mCount < 99) {
      movers[mCount] = new Mover(2*tempRadius.mag(),tempCenter.x,tempCenter.y);
      mCount++;
    } else {
      println("Maximum number of mover objects (100) reached!");
    }
  } else if (mouseButton == RIGHT) {
    if (aCount < 99) {
      attractors[aCount] = new Attractor(hueValues[hueIndex],2*tempRadius.mag(),tempCenter.x,tempCenter.y);
      aCount++;
    } else {
      println("Maximum number of attractor objects (100) reached!");
    }
  } 
}


//Toggle the display forces with f key
void keyPressed() {
  if (key == 'f' || key == 'F') {
    displayForcesOn = !displayForcesOn; 
  }
  if (key == 'c' || key == 'C') {
    aCount = 0;
    mCount = 0;
  }
}


void showInfo() {
  fill(180,100,100);
  textSize(14);
  text("Click and drag left mouse button to draw moving objects",20,20);
  text("Click and drag right mouse button to draw attracting objects",20,40);
  text("Toggle show forces on and off with f key",20,60);
}