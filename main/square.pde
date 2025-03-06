class Square {
  float x, y;
  float size;
  float smallX = 0, smallY = 0;

  int duration = 120;
  int frameCounter = 0;
  int activationFrame;
  
  boolean moving = false;
  
  Square(float x, float y, float size, int activationFrame) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.activationFrame = activationFrame;
  }
  
  void update() {
    if (!moving) return;

    frameCounter++;
    
    if (frameCounter >= duration) {
      frameCounter = 0;
    }
    
    float progress = float(frameCounter) / duration;
    float travelDistance = progress * 4 * size;
    
    if (travelDistance < size) {
      smallX = 0;
      smallY = travelDistance;
    } else if (travelDistance < 2 * size) {
      smallX = travelDistance - size; 
      smallY = size;
    } else if (travelDistance < 3 * size) {
      smallX = size;
      smallY = size - (travelDistance - 2 * size);
    } else {
      smallX = size - (travelDistance - 3 * size);
      smallY = 0;
    }
  }
  
  void show() {
    pushMatrix();
    translate(x, y);
    
    rectMode(CORNER);
    noFill();     
    stroke(color(24));
    rect(0, 0, size, size);
    
    float progress = float(frameCounter) / duration;
    float sizeMod = progress <= 0.5 ? int(easeInQuart(progress, 0, 0.5, 1.8, 1)) : int(easeInQuart(progress, 0.5, 1, 1, 1.8));
    color colour = progress <= 0.5 ? lerpColor(color(253, 188, 111), color(30), progress * 2) : lerpColor(color(30), color(253, 188, 111), progress * 2 - 1);
    
    fill(colour);
    noStroke();
    rectMode(CENTER);
    rect(smallX, smallY, 6 * sizeMod, 6 * sizeMod, 3);
    
    popMatrix();
  }
}
