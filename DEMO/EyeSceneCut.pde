class EyeSceneCut{

  float x, y;
  float[] speed = new float[5];
  float[] h={random(256),random(256),random(256),random(256)};
  
  void initEyeSceneCut(){
    for(int i=0;i<4;i++){
     // speed[i]=random(0.5, 5);
     speed[i]=i*1.5;
     
    }
  }
  
  void catchPoint(PVector kinectPoint){
    x=kinectPoint.x;
    y=kinectPoint.y;
    
    noStroke();
  
    for (int i = 0; i < 4; i++) {
    float l = 180*sin(frameCount*speed[i]*PI/200);
    fill(h[i], 255, 255, 51);
    ellipse(x, y, l, l);
    } 
  }
  
}