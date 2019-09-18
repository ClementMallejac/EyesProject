PImage origImage, maskImage, blurImage;
PGraphics mask;

void setup(){
  size(960,635);
  int coordX, coordY;
  //Load Image Original
  origImage = loadImage("Paysage.png");
  
  mask = createGraphics(origImage.width, origImage.height);

  blurImage = origImage.copy();
  blurImage.filter(BLUR, 6);
  
  
  
}

void draw(){
  
  mask.beginDraw();
  mask.background(0);
  mask.noStroke();
  mask.fill(255);
  mask.ellipse(mouseX, mouseY, 100,100);
  mask.endDraw();
  mask.filter(BLUR, 6);
  origImage.mask(mask);
 image(blurImage, 0, 0);
 
 image(origImage, 0, 0);

 
}
