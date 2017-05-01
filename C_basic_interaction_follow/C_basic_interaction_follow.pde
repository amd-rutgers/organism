float circleSize = 100;
// create global variables to
// track organism position
float orgX, orgY;

void setup() {
  size(500, 500);
  smooth();

  orgX = mouseX;
  orgY = mouseY;

}

void draw() {
  background(255);
  
  // every frame each coordinate
  // will move 1/10th closer to
  // the current mouse position
  // (this creates an easing effect)
  orgX = orgX + (mouseX-orgX)/10;
  orgY = orgY + (mouseY-orgY)/10;
  
  // draw the organism using the
  // coordinates
  drawOrganism(orgX, orgY);
}


/**
 * drawOrganism function
 * draws the organism on the screen based
 * on given x and y coordinates
 */
void drawOrganism(float x, float y) {

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
  // now rotate based on the frameCount
  rotate(angle);
  
  // set style settings
  noStroke();
  fill(200, 234, noise(f, x, y)*189, 100);
  
  // draw main circle
  ellipse(0, 0, circleSize, circleSize);
  
  // offset 50 px on both axis 
  translate(-50, -50);
  
  // change fill
  fill(129, 100, 220, 100);
  
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