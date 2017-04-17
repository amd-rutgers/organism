import de.voidplus.leapmotion.*;

LeapMotion leap;

float f;
float circ = 100;
float orgX;
float orgY;

color bgColor;

void setup() {
  size(500, 500);
  smooth();

  orgX = mouseX;
  orgY = mouseY;

  leap = new LeapMotion(this).allowGestures();
  
  bgColor = color(random(255), random(255), random(255));
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
    PVector handPosition = hand.getPosition();
    orgX = orgX + (handPosition.x-orgX)/10;
    orgY = orgY + (handPosition.y-orgY)/10;  
    
    drawOrganism(orgX, orgY, hand.getRoll());

  }

  // do something for each hand
  //for (Hand hand : leap.getHands ()) {
  //  PVector handPosition = hand.getPosition();
  //  orgX = orgX + (handPosition.x-orgX)/10;
  //  orgY = orgY + (handPosition.y-orgY)/10;  
  //}
  
  f = frameCount*.01;
}

void drawOrganism(float x, float y, float roll) {
  translate(x, y);
  float scale = map(sin(radians(frameCount)), -1, 1, 1, 1.5);
  scale(scale);
  
  // rotate based on roll
  rotate(radians(roll));
  
  noStroke();
  fill(200, 234, noise(f, x, y)*189, 100);
  ellipse(0, 0, circ, circ);
  
  translate(-50, -50);
  fill(129, 100, 220, 100);
  beginShape();
    curveVertex(0, 0);
    curveVertex(noise(x, f)*50, noise(y, f)*50);
    curveVertex(-noise(f, x)*40, noise(f, y)*40);
    curveVertex(-noise(y, f)*30, -noise(x, f)*30);
    curveVertex(noise(f, y)*20, -noise(f, x)*20);
    curveVertex(noise(x, f)*50, noise(y, f)*50);
    curveVertex(0, 0);
  endShape(CLOSE);
  
}

/**
 * Use circle gesture to change colors
 */
void leapOnCircleGesture(CircleGesture g, int state){
 // only change when gesture stops
  if(state == 3) {
    bgColor = color(random(255), random(255), random(255));
  }
}