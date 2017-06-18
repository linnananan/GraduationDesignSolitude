public class doubleEye{
  float kinectX = 0.0f;
  float kinectY = 0.0f;
  Eye leftEye;
 // Eye rightEye; 
  public float liftTime = 10.0f;
  public float eyesize;
  private float w;
  private float h;
 // private float distBetween;
  private float time = random(0.1,0.9);
  public  doubleEye(float x,float y,float w,float h,float Eyesize){
    kinectX = x;
    kinectY = y;
    leftEye = new Eye(kinectX,kinectY);
    eyesize = Eyesize;
    //rightEye = new Eye(kinectX,kinectY);
    this.w = w;
    this.h = h;
   // this.distBetween = distBetween;
  }
  void displayEye(){
     if(liftTime<0.0||liftTime==0.0){
       liftTime = 0.0;
     }else{
       liftTime-=0.1f;
     }
     SetEyeTargets();
     CheckForBlink();
     leftEye.Draw(w, h,eyesize);
    // rightEye.Draw(w + distBetween, h);
     
  }
  
  void CheckForBlink()
  {
    float blinkVar = noise(time * 2 , 34.1);
    float noiseMag = abs(blinkVar - 0.5);   
    if (noiseMag > .22f && !leftEye.IsBlinking())
    {
   //   rightEye.Blink();
      leftEye.Blink();
    }
  }
  
  void SetEyeTargets()
  {
    time += .001f; 
    float magThreshold = .1;
      
    float xVar = noise(time, 423.6);
    float yVar = noise(time * 2, 126.32);
      
    float xMag = abs(xVar - leftEye.GetXVariance());
    float yMag = abs(yVar - leftEye.GetYVariance());
    if (xMag > magThreshold || yMag > magThreshold)
    {
      leftEye.SetVariance(xVar, yVar);
     // rightEye.SetVariance(xVar, yVar);
    }
  }
  
  float getEyeLiftTime(){
    return liftTime;
  }
  
}