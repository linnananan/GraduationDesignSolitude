class EyeLook{
  
  ArrayList<doubleEye> allEye;
 // float ioDist = 60;
  float count=200;
  
  void initEyeLook(){
    allEye =new ArrayList<doubleEye>();
    pushStyle();
    noStroke();
    
    doubleEye eye1 = new doubleEye(random(100,width-100),random(30,height-200),random(100,width-100),random(30,height-200),random(50,200));
    doubleEye eye2 = new doubleEye(random(100,width-100),random(30,height-200),random(100,width-100),random(30,height-200),random(50,200));
    allEye.add(eye1);
    allEye.add(eye2);
    popStyle();
  }
  void eyeCatchPoint(PVector KinectPoint){
    background(0);
    //PVector pointX=
    if(random(0.0,count)<1.5){
      doubleEye dEye = new doubleEye(kinectPoint.x,kinectPoint.y,random(100,width-100),random(30,height-200),random(50,200));
      allEye.add(dEye);
    }
    for (int i=allEye.size()-1;i>=0;i--) {
      doubleEye eye = (doubleEye) allEye.get(i);
      if(eye.getEyeLiftTime()==0.0){
        allEye.remove(eye);
      }
    }
    for (int i=0;i<allEye.size();i++) {
      doubleEye eye = (doubleEye) allEye.get(i);
      eye.displayEye();
    }
    
    if(count>5)count--;
  }
  
  void removePoint(PVector kinectPoint){
    for (int i=allEye.size()-1;i>=0;i--) {
      doubleEye eye = (doubleEye) allEye.get(i);
      if(eye.getEyeLiftTime()>0.0 && kinectPoint.x>=eye.w-40 && kinectPoint.x<=eye.w +40 && kinectPoint.y>=eye.h-50-40 && kinectPoint.y<=eye.h+50+40){
         //ellipse(kinectPoint.x,kinectPoint.y,60,60);
        allEye.remove(eye);
      }
    }
  }
}