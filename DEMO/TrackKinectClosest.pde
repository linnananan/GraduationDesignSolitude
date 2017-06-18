
class TrackKinectClosest{  
  int movW= mov.width;
  int movH= mov.height;
  PVector savePoint;
  PVector getKinectPoint() {
    int[ ] allDepths = new int[640*480];
    context.depthMap(allDepths);
    int worldRecordClosest = 100000;
    int winX =0;
    int winY= 0;
    for (int row = 0; row < 480; row++) {
      for (int col = 0; col < 640; col++) {
        int placeInBigArray = row*640 + col;
        if (allDepths[placeInBigArray] < worldRecordClosest && allDepths[placeInBigArray] != 0 ) {
          worldRecordClosest = allDepths[placeInBigArray];
          winX= col;
          winY = row;
        }
      }
    }
    int wid = (int) map(worldRecordClosest, 0, 2000, 255, 0);
    float wX = map(winX,0,640,0,width);
    float wY = map(winY,0,640,0,height);
    savePoint =new PVector(wX,wY);
    //ellipse(wX, wY, wid, wid);
    return savePoint;
  }
  
  void showKinectInMov(){
    background(0);
    int[] userMap = context.userMap();
    PImage userImg;
    userImg = createImage(640, 480, RGB);
    if(mov.available()){
        mov.read();
        if(userMap.length >0){
            mov.loadPixels();
            userImg.loadPixels();
            for(int i = 0; i < userImg.pixels.length; i++){
                if(userMap[i] > 0 && i < mov.pixels.length){
                    int x = i % 640;
                    int y = (i - x) / 640;
                    userImg.pixels[i] = mov.get(x,y);
                    //userImg.pixels[i] = color(255);
                }else{
                    userImg.pixels[i] =color(0,0,0,0);
                }
            }
            userImg.updatePixels();
          }
     }
    if(bgMov.available()){
        bgMov.read();
     }
     userImg.resize(width,height);
     image(userImg,0,0);
   }
   void showGlitchMov(int bright){
     //background(0);
         PImage userImg;
 
     //change size of mov
     userImg = createImage(640, 480, ARGB);
     if(movGlitch.available()){
        movGlitch.read();
        movGlitch.loadPixels();
        userImg.loadPixels();
        color colors[] = movGlitch.pixels;
        int len = colors.length;
        for (int i = 0; i < len; ++i) {
            color c = colors[i];
            if (brightness(c) > bright) {
               // colors[i] = c & ~PImage.ALPHA_MASK;
            }
            userImg.pixels[i] = colors[i];
          }
        userImg.updatePixels();
        
     }
     userImg.resize(width,height);
     image(userImg,0,0);
   }
 void showlastMov(int bright){
     //background(0);
         PImage userImg;
 
     //change size of mov
     userImg = createImage(640, 480, ARGB);
     if(lastmov.available()){
        lastmov.read();
        lastmov.loadPixels();
        userImg.loadPixels();
        color colors[] = lastmov.pixels;
        int len = colors.length;
        for (int i = 0; i < len; ++i) {
            color c = colors[i];
            if (brightness(c) > bright) {
               // colors[i] = c & ~PImage.ALPHA_MASK;
            }
            userImg.pixels[i] = colors[i];
          }
        userImg.updatePixels();
        
     }
     userImg.resize(width,height);
     image(userImg,0,0);
   }
 
 ;}