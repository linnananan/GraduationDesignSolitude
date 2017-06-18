class EyeDark{
  int shift = 0;
  PVector p = new PVector();
  PImage buff;
  PImage texture; 
  PImage overlay;
  float aTanLUT[];
  void init(){
     fill(0, 0, 255);
     buff = new PImage(width, height, RGB);
     texture = loadImage("eye.png");
     texture.resize(width,height);
     // Create LUT
     aTanLUT = new float[height * width];
     for (int i = 0; i < width * height; i++) {
       int x = i % (width);
       int y = int(i/width);
       aTanLUT[y * width + x] = atan2((height/2 - y), (width/2 - x));
     }
     overlay = new PImage(width, height, ARGB);
     overlay.loadPixels();
     // change for different darkness amounts
     float maxLen = height/1.5;
     PVector p = new PVector();
     for (int i = 0; i < width * height; i++) {
       int x = i % width;
       int y = int(i/width);
       p.set(x - width/2.0, y - height/2.0);
       float d = sqrt(p.x*p.x + p.y*p.y);
       float normalizedDist = d/maxLen;
       // invert since we want 255 to be at the center
       overlay.pixels[i] = color(0, (1 - normalizedDist) * 255);
    }
  }
  void drawDarkEye(){
     for (int i = 0; i < width * height; i++) {
      int x = i % width;
      int y = floor(i/(width));
      p.x = width / 2.0  - x;
      p.y = height / 2.0 - y;
      float len = sqrt(p.x * p.x + p.y * p.y);
      if(len > 20){
      float theta = aTanLUT[y * width + x];
      theta = abs((theta / TWO_PI) * texture.height * 11);
      theta %= texture.height;
      len = len/(texture.width);
      //
      len = (1.0/len) * texture.width/3;
      len += frameCount * 600;
      int u = int(theta) % texture.width;
      int v = int(len) % texture.width;   
      buff.pixels[i] = texture.pixels[u * texture.width + v];
      }
    }
    shift++;
    shift %= texture.width;
    buff.updatePixels();
    image(buff, 0, 0);
    image(overlay, 0, 0);
    }
}