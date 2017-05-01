/**
 * NOTE: this requires the leap motion library to be installed.
 * If you haven't already done this, go to
 * Sketch -> Import Library -> Add Library..
 * and search for "Leap Motion"
 *
 * You can find information about the library here:
 * https://github.com/nok/leap-motion-processing
 * (the examples are good to look at)
 */
import de.voidplus.leapmotion.*;

// declare a LeapMotion object
LeapMotion leap;
// set default circle size
float circleSize = 100;
// create global variables to
// track organism position
float orgX, orgY;
// set color variable fron background
color bgColor;

void setup() {
  size(500, 500);
  smooth();
  
  // initialize new leap motion tracker
  // and allow gestures
  leap = new LeapMotion(this).allowGestures();

  orgX = mouseX;
  orgY = mouseY;

  // start with random color for background
  bgColor = color(
    random(230, 255),
    random(230, 255),
    random(230, 255)
  );

}

void draw() {
  background(bgColor);
  
  // get an array of all hands 
  // https://processing.org/reference/ArrayList.html
  ArrayList<Hand> hands = leap.getHands();
  
  // if there are any hands found
  if(hands.size() > 0) {
    
    // only take first hand
    Hand hand = hands.get(0);
    
    // get hand position
    PVector handPosition = hand.getPosition();
    // get hand roll
    float roll = hand.getRoll();
    
    // now use handPosition instead of mouseX, mouseY
    orgX = orgX + (handPosition.x-orgX)/10;
    orgY = orgY + (handPosition.y-orgY)/10;
    
    // draw the organism
    drawOrganism(orgX, orgY, roll);
  }

}

/**
 * Use circleSizele gesture to change colors
 */
void leapOnCircleGesture(CircleGesture g, int state){
 // only change when gesture stops
  if(state == 3) {
    bgColor = color(random(255), random(255), random(255));
  }
}

/**
 * drawOrganism function
 * draws the organism on the screen based
 * on given x and y coordinates and roll
 * for rotation
 */
void drawOrganism(float x, float y, float roll) {

  // convert frame count from
  // degrees to radians
  float angle = radians(frameCount);
  
  // get the sin of the angle in radians
  float scale = sin(angle);
  
  // map the scale to a more useful range
  // https://processing.org/reference/map_.html
  scale = map(scale, -1, 1, 1, 1.5);
  
  // set a variable to be 1/100th of frameCount
  float f = frameCount*.01;
  
  
  // translate based on the given x and y coords
  translate(x, y);
  // scale based on the scale value
  scale(scale);
  
  // now rotation is based on roll
  // variable passed into function
  rotate(radians(roll));
  
  // set style settings
  noStroke();
  fill(200, 234, noise(f, x, y)*189, 100);
  
  // draw main circleSizele
  ellipse(0, 0, circleSize, circleSize);
  
  // offset 50 px on both axis 
  translate(-50, -50);
  
  // set fill based on whether the mouse
  // is pressed or not
  
  // draw as outline when mouse is pressed
  if(mousePressed) {
    noFill();
    strokeWeight(5);
    stroke(129, 100, 220, 100);
    
  // draw as fill otherwise
  } else {
    fill(129, 100, 220, 100);
  } 
  
  // draw random curve shape
  beginShape();
    // start at 0, 0
    curveVertex(0, 0);
    
    // use noise function to generate coordinates
    // https://processing.org/reference/noise_.html
    curveVertex(noise(x, f)*50, noise(y, f)*50);
    curveVertex(-noise(f, x)*40, noise(f, y)*40);
    curveVertex(-noise(y, f)*30, -noise(x, f)*30);
    curveVertex(noise(f, y)*20, -noise(f, x)*20);
    curveVertex(noise(x, f)*50, noise(y, f)*50);
    
    // end at 0, 0
    curveVertex(0, 0);
  endShape(CLOSE);
  
}