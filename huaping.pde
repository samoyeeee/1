import peasy.*;
import controlP5.*;

PeasyCam cam;
ControlP5 cp;
float dia = 50.0;
float sw = 1;

PVector[][] vp;
int layer = 20;
int section = 72;
float radiu = 200;
float cyHigth = 20;

void setup(){
  size(800, 800, P3D);
  background(0);
  cam = new PeasyCam(this, 400);
  UI();
  smooth();
}

void draw(){
  background(0);
  buildCylinder();
  displayCylinder();
  drawBase();
  drawPatterns(); // 在瓶身表面添加立体花纹
  cam.beginHUD();
  cp.draw();
  cam.endHUD();
  
  if (mouseX < 300 && mouseY < 300) {
    cam.setActive(false);
  } else {
    cam.setActive(true);
  }
}

void UI() {
  cp = new ControlP5(this);
  cp.addSlider("dia", 0, 200, 50, 50, 50, 100, 30).setLabel("直径");
  cp.addSlider("sw", 0, 20, 1, 50, 50 + 30 + 10, 100, 30).setLabel("轮廓");
  cp.addSlider("radiu", 50, 500, 200, 50, 50 + 60 + 20, 200, 30).setLabel("半径");
  cp.addSlider("section", 3, 128, 36, 50, 50 + 90 + 30, 200, 30).setLabel("花瓶截面");
  cp.addSlider("cyHigth", 0, 200, 50, 50, 50 + 90 + 70, 200, 30).setLabel("高度");
  cp.setAutoDraw(false);
}

void buildCylinder(){
  vp = new PVector[layer][section];
  float angle = TWO_PI / section;
  
  for (int i = 0; i < layer; i++){
    for (int j = 0; j < section; j++){
      radiu = cp.getController("radiu").getValue() + 50 * sin(angle * i);
      vp[i][j] = new PVector(radiu * cos(angle * j), radiu * sin(angle * j), cyHigth * i);
    }
  }
}

void displayCylinder(){
  strokeWeight(sw);
  stroke(255);
  float c = 255 / vp.length;
  
  for (int i = 0; i < vp.length - 1; i++){
    fill(i * c);
    for (int j = 0; j < vp[0].length; j++){
      beginShape(TRIANGLES);
      vertex(vp[i][j].x, vp[i][j].y, vp[i][j].z);
      vertex(vp[i + 1][j].x, vp[i + 1][j].y, vp[i + 1][j].z);
      vertex(vp[i][(j + 1) % vp[0].length].x, vp[i][(j + 1) % vp[0].length].y, vp[i][(j + 1) % vp[0].length].z);
      
      vertex(vp[i][(j + 1) % vp[0].length].x, vp[i][(j + 1) % vp[0].length].y, vp[i][(j + 1) % vp[0].length].z);
      vertex(vp[i + 1][j].x, vp[i + 1][j].y, vp[i + 1][j].z);
      vertex(vp[i + 1][(j + 1) % vp[0].length].x, vp[i + 1][(j + 1) % vp[0].length].y, vp[i + 1][(j + 1) % vp[0].length].z);
      endShape();
    }
  }
}

void drawBase() {
  beginShape(TRIANGLE_FAN);
  fill(100, 100, 255);
  vertex(0, 0, 0);
  float angle = TWO_PI / section;
  for (int i = 0; i <= section; i++) {
    float x = radiu * cos(angle * i);
    float y = radiu * sin(angle * i);
    vertex(x, y, 0);
  }
  endShape(CLOSE);
}

void drawPatterns() {
  float step = TWO_PI / section;
  float zStep = cyHigth / layer;

  for (int i = 0; i < layer - 1; i++) {
    for (int j = 0; j < section; j++) {
      float x1 = vp[i][j].x;
      float y1 = vp[i][j].y;
      float z1 = vp[i][j].z;
      
      float x2 = vp[i][(j + 1) % section].x;
      float y2 = vp[i][(j + 1) % section].y;
      float z2 = vp[i][(j + 1) % section].z;
      
      float x3 = vp[i + 1][j].x;
      float y3 = vp[i + 1][j].y;
      float z3 = vp[i + 1][j].z;
      
      float x4 = vp[i + 1][(j + 1) % section].x;
      float y4 = vp[i + 1][(j + 1) % section].y;
      float z4 = vp[i + 1][(j + 1) % section].z;
      
      // 在瓶身表面绘制棱状花纹
      float avgZ = (z1 + z2 + z3 + z4) / 4.0;
      pushMatrix();
      translate((x1 + x2 + x3 + x4) / 4, (y1 + y2 + y3 + y4) / 4, avgZ);
      rotateX(HALF_PI);
      drawPyramid(10); // 调整尺寸和形状
      popMatrix();
    }
  }
}

void drawPyramid(float size) {
  float halfSize = size / 2.0;
  beginShape(TRIANGLE_STRIP);
  vertex(0, -halfSize, 0);
  vertex(halfSize, halfSize, -halfSize);
  vertex(-halfSize, halfSize, -halfSize);
  
  vertex(0, -halfSize, 0);
  vertex(halfSize, halfSize, -halfSize);
  vertex(halfSize, halfSize, halfSize);
  
  vertex(0, -halfSize, 0);
  vertex(-halfSize, halfSize, -halfSize);
  vertex(-halfSize, halfSize, halfSize);
  
  vertex(0, -halfSize, 0);
  vertex(halfSize, halfSize, halfSize);
  vertex(-halfSize, halfSize, halfSize);
  endShape();
}
