class SkyBubble{
  int circlenum=3, frames = 90;
  float theta;
  float starX[] = {};
  float starY[] = {};
  int[] starstalbeX = {0,0,0,0,0,0};
  int[] starstalbeY = {0,0,0,0,0,0};
  int countPoeple=0;
  int userId=0;
  boolean isTimeoff;
  //isTimeoff为true即时间到，显示所有圈圈；为false时，根据userId逐个显示
  
  SkyBubble(int userID,boolean isTimeOff){
    userId = userID;
    isTimeoff = isTimeOff;
  }
  void initPos(){
    starstalbeX[0]=width/2; starstalbeX[1]=width/2+(int)(sqrt(3)*height)/6; starstalbeX[2]=width/2+(int)(sqrt(5)*height)/6; 
    starstalbeX[3]=width/2; starstalbeX[4]=width/2-(int)(sqrt(3)*height)/6; starstalbeX[5]=width/2-(int)(sqrt(5)*height)/6;
    starstalbeY[0]=height/8;starstalbeY[1]=3*height/8;starstalbeY[2]=6*height/8;starstalbeY[3]=3*height/4;starstalbeY[4]=5*height/8;starstalbeY[5]=3*height/8;
  }
  void drawSkyBubble(){
    background(0);
    sky.drawSky();
   if(isTimeoff==true){
        int countstar = 0;
        while(countstar < starX.length) {
          stroke(150);
          noFill();
          for (int i=0; i<circlenum; i++) {
            float sz = i*30;
            float sw = map(sin(theta+TWO_PI/circlenum*i), -1, 1, 1, 7);
            strokeWeight(sw);
            ellipse(starX[countstar], starY[countstar],sz, sz);
          }   
        stroke(0);
        countstar=countstar+1;
        circlenum=circlenum+1;
       }
       theta += 10*TWO_PI/frames;
      if(countPoeple<6){
        for(int i=countPoeple;i<6;i++){
        starX = append(starX, starstalbeX[i]);
        starY = append(starY, starstalbeY[i]);
       }
      }  
      Farewell();
      stroke(0); 
   }else{
      stroke(100);
      noFill();
      for (int i=0; i<6; i++) {
          float sz = i*30;
          float sw = map(sin(theta+TWO_PI/circlenum*i), -1, 1, 1, 7);
          strokeWeight(sw);
          ellipse(starstalbeX[0], starstalbeY[0],sz, sz);
      }   
       Farewell2(); 
       stroke(0);
   }
  }
  
  void Farewell(){
    stroke(255);
    strokeWeight(3);   
    for(int i=0;i<5;i++){
      line(starstalbeX[i],starstalbeY[i],starstalbeX[i+1],starstalbeY[i+1]);
    }
    line(starstalbeX[0],starstalbeY[0],starstalbeX[5],starstalbeY[5]);         
  }
  void Farewell2(){
    if(userId>0&&userId<5){
        drawUserBubble(userId);
    }else if(userId>5){
        drawUserBubble(5);
        line(starstalbeX[0],starstalbeY[0],starstalbeX[5],starstalbeY[5]);
    }
    
  }
  void drawUserBubble(int user){
    background(0);
    stroke(255);
    strokeWeight(3);   
    for(int i=0;i<user;i++){ 
       noFill();
       for (int j=0; j<6;j++) {  
         float sz = j*30;
         float sw = map(sin(TWO_PI/6*j), -1, 1, 1, 7);
         strokeWeight(sw);
         ellipse(starstalbeX[i], starstalbeY[i],sz, sz);
         stroke(random(200,255));
         ellipse(starstalbeX[i+1], starstalbeY[i+1],sz, sz);
       }
      strokeWeight(3);
      line(starstalbeX[i],starstalbeY[i],starstalbeX[i+1],starstalbeY[i+1]);
    }
  }
  
}