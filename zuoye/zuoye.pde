float spacing = 30;        
float rectWidthRange = 30;
float rectHeightRange = 50; 
float pointSpeed = 0;   
float pointOffset = 0;     
float emptyRectChance = 0.3; 

void setup() {
  size(800, 600);
  frameRate(4); 
}

void draw() {
  background(255);
  
 
  for (float x = 0; x < width; x += spacing) {
    for (float y = 0; y < height; y += spacing) {
      float rectWidth = map(sin((x + pointOffset) * 0.01), -1, 1, spacing / 2, spacing + rectWidthRange);
      float rectHeight = map(cos((y + pointOffset) * 0.01), -1, 1, spacing / 2, spacing + rectHeightRange);
      float rectX = x + sin((x + pointOffset) * 0.01) * spacing / 2;
      float rectY = y + cos((y + pointOffset) * 0.01) * spacing / 2;
      
      stroke(0);
      float randomValue = random(1);
      if (randomValue < emptyRectChance) {
        noFill(); 
      } else {
        if (randomValue < 1/3.0) {
          fill(255, 0, 0); 
        } else if (randomValue < 2/3.0) {
          fill(255, 255, 0); 
        } else {
          fill(0, 0, 255); 
        }
      }
      
      rect(rectX, rectY, rectWidth, rectHeight);
    }
  }
  
 
  pointOffset += pointSpeed;
}
