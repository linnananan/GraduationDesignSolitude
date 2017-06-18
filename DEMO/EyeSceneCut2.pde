class EyeSceneCut2{
  float d;
  float red;
  float green;
  float blue;
  void catchPoint(PVector kinectPoint){
    //background(0);
    loadPixels();
    for(int i=0;i<height;i++){
      for(int j=0;j<width;j++){
        color c = pixels[i*width+j];      
        red = c <<7 & 0xff;
        green = c << 4 & 0xaa;
        blue = c  & 0xff;
        d =dist(kinectPoint.x,kinectPoint.y,j,i)*.4;
        red += 50/d-2;
        green += 50/d-2;
        blue += 155/d-2;
        pixels[i*width+j]=color(red,green,blue);      
      }
    }
    updatePixels();
  }
}