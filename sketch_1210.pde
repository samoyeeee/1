

PImage[] frames = new PImage[6]; // 创建一个PImage类型的数组，存储六个关键帧图片
int frameIndex = 0; // 初始化帧索引

void setup() {
  size(400, 400);
  
  // 加载六个关键帧图片到数组中
  for (int i = 0; i < 6; i++) {
    frames[i] = loadImage("frame" + i + ".png"); // 图片文件名可能需要根据实际情况修改
  }
}

void draw() {
  background(255);
  
  // 显示当前帧的图片
  image(frames[frameIndex], 0, 0, width, height);
  
  // 控制动画帧率
  int frameDuration = 10; // 帧持续时间，可以根据需要调整
  if (frameCount % frameDuration == 0) {
    frameIndex = (frameIndex + 1) % frames.length; // 循环播放帧
  }
}
