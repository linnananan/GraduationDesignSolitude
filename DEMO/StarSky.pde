class StarSky{
  int Stars=30;
  float[] StarsX=new float[Stars];
  float[] StarsY=new float[Stars];
  float[] Bubble=new float[Stars];
  float[] Twinkle=new float[Stars];
  void initSky(){
    //background(0);
    for (int lop=0; lop<Stars; lop=lop+1){
      StarsX[lop]=random(width);
      StarsY[lop]=random(height);
      Bubble[lop]=random(5,20);
      Twinkle[lop]=1;
    }  
    noCursor();
  }
  void drawSky(){
    fill(0,100);
   // background(0);
    for (int lop=0; lop<Stars; lop=lop+1){
      fill(random(200,255),random(200,255),random(200,255));
      //fill(255);
      noStroke();
      ellipse(StarsX[lop],StarsY[lop],Bubble[lop],Bubble[lop]);
         
      Bubble[lop]=Bubble[lop]+Twinkle[lop];
      if((Bubble[lop]>20) || (Bubble[lop] <4)){
       Twinkle[lop]=Twinkle[lop]*-1;
      }    
    }
  }
}