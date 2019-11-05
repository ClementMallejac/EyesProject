PImage origImage, maskImage, blurImage, blurRect, blockImage;
PGraphics mask;
PGraphics block;

import processing.net.*;
String HTTP_HEADER = "HTTP/1.0 200 OK\nContent-Type: text/html\n\n";
Server s;
Client c;

int[] tableauX={100, 150, 126, 456, 55, 589};
int[] tableauY={20, 555, 245, 400, 125, 125};


void setup() {
  size(600, 400);
  s = new Server(this, 8080);

  //Load Image Original
  origImage = loadImage("quimper.jpg");

  mask = createGraphics(origImage.width, origImage.height);

  block = createGraphics(150, 150);

  block.beginDraw();
  block.fill(255);
  block.noStroke();
  block.ellipse(block.width/2, block.height/2, 100, 100);

  block.filter(BLUR, 6);

  block.endDraw();


  blurImage = origImage.copy();
  blurImage.filter(BLUR, 6);
  image(blurImage, 0, 0);
}

void draw() {
  
  c = s.available();
  if (c != null) {
    String msgClient=c.readString();
    println(msgClient);
    s.write(HTTP_HEADER);
    s.write("<html><head><meta charset='utf-8'><title>Processing</title></head><body><h3>Ok cela fonctionne</h3><p>Le serveur a bien répondu à la requête HTTP</p></body></html>");
    c.stop();
  }
  
  image(blurImage, 0, 0);
  mask.beginDraw();
  mask.background(0);
 
  for (int i = 0 ; i <6; i++){
    
      mask.image(block, tableauX[i], tableauY[i]);  
  }
  
  mask.image(block, mouseX-(block.width/2), mouseY-(block.height/2));
  
  

  mask.endDraw();
 // mask.filter(BLUR, 30); 

  origImage.mask(mask);

  image(origImage, 0, 0);
}
