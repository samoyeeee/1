void setup() {
  size(600, 600);
  background(255);
  smooth();
  noFill();
  stroke(0);
  frameRate(30);
}

void draw() {
  translate(width/2, height/2);
  rotate(frameCount * 0.02);
  int numShapes = 8;
  float radius = 200;
  
  for (int i = 0; i < numShapes; i++) {
    float angle = TWO_PI / numShapes * i;
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
    float offset = map(sin(frameCount * 0.05 + angle), -1, 1, -50, 50);
    
    beginShape();
    for (int j = 0; j < numShapes; j++) {
      float angleVertex = TWO_PI / numShapes * j;
      float xVertex = cos(angleVertex) * (radius + offset);
      float yVertex = sin(angleVertex) * (radius + offset);
      vertex(xVertex, yVertex);
    }
    endShape(CLOSE);
  }
  
  if (frameCount > 300) {
    noLoop();
  }
}
