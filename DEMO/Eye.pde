public class Eye
{
  float kinectX = 0.0f;
  float kinectY = 0.0f;
  float kinectXX = 0.0f;
  
  
  float eyeballSize;
  float irisScale = .5f;
  float minPupilScale = .45f;
  float maxPupilScale = .75f;

  float fullyDialatedDist = 400;
  float dialationAmount = .5f;
  
  float varXTarget = .5f;
  float varYTarget = .5f;
  float varX = .5;
  float varY = .5;
  float varSlide = .2;

  float blinkTimer = 100;
  float blinkLength = 4;
  float actualBlinkLength = 2;
  
  float trackX = .5f;
  float trackY = .5f;
  float mouseTrackingSlide = 0.25f;
  float mouseTrackingAmount = 0;
  float distanceThreshold = 10;
  float trackingTimer = -1;
  float trackingAmountTimeout = 10;
  float trackingDecaySlide = .2f;

  color randomcolor;
  Eye(float x,float y){
    kinectX = x;
    kinectY = y;
  }
  public void Draw(float x, float y,float EyeballSize)
  {
    //if(kinectX < width/3){
    //  kinectXX = 1/8*width/3 ;
    //}else if(kinectX < 2*width/3){
    //  kinectXX = width/2;
    //}else{
    //  kinectXX =width-100;
    //}
    blinkTimer += .1f;
    eyeballSize = EyeballSize ;

    DrawWhite(x, y);
    DrawIris(x, y);
    DrawLids(x, y);
  }

  void UpdateMouseTracking(float x, float y)
  {
    //////////////////////
    float diffX=width/2;
    float diffY=3*height/4;
   // if(userNum==1){
      diffX = map(constrain((headPos.x - x)  *.01, -1, 1), -1, 1, 0, 1);  //*********
      diffY = map(constrain((headPos.y - y)  *.01, -1, 1), -1, 1, 0, 1);
   // }else{
   //   diffX = map(constrain((kinectMinP.x - x)  *.01, -1, 1), -1, 1, 0, 1);  //*********
   //   diffY = map(constrain((kinectMinP.y - y)  *.01, -1, 1), -1, 1, 0, 1);
  //  }
    trackX = lerp(trackX, diffX, mouseTrackingSlide);
    trackY = lerp(trackY, diffY, mouseTrackingSlide);    
    trackingTimer -= .01f;
    //if (dist(kinectX, kinectY, pmouseX, pmouseY) > distanceThreshold)
      trackingTimer = trackingAmountTimeout;

    float trackingTarget = 1;
    //if (trackingTimer <= 0)
     // trackingTarget= 0;
    mouseTrackingAmount = lerp(mouseTrackingAmount, trackingTarget, trackingDecaySlide);
  }


  public void DrawPupil(float x, float y)
  {
    float pupilScale = lerp(minPupilScale, maxPupilScale, dialationAmount);
    float size = eyeballSize * irisScale*  pupilScale;
    pushStyle();
    fill(0);
    ellipse(x, y, size, size);
    popStyle();
  }

  public void DrawLids(float x, float y)
  {
    pushStyle();
    fill(0);
    float left = x - eyeballSize * .5f;
    float right = x + eyeballSize * .5f;
    float top = y - eyeballSize * .75f;
    float bottom = y + eyeballSize * .75f;


    float topCX1 = right - eyeballSize * .3;
    float topCY1 = y - eyeballSize * .4f;
    float topCX2 = left + eyeballSize * .3;
    float topCY2 = y - eyeballSize * .4f;

    float bottomCX1 = right - eyeballSize * .1;
    float bottomCY1 = y + eyeballSize * .25f;
    float bottomCX2 = left + eyeballSize * .1;
    float bottomCY2 = y + eyeballSize * .25;

    if (IsBlinking())
    {
      float blinkProgress = blinkTimer / actualBlinkLength;
      
      if (blinkProgress < .5f)
        blinkProgress *= 2;
      else if (blinkProgress < 1)
        blinkProgress = (1 - blinkProgress) * 2;
      else
        blinkProgress = 0;
      
      blinkProgress *= blinkProgress;
      topCX1 = lerp(topCX1, bottomCX1, blinkProgress);
      topCY1 = lerp(topCY1, bottomCY1, blinkProgress);
      topCX2 = lerp(topCX2, bottomCX2, blinkProgress);
      topCY2 = lerp(topCY2, bottomCY2, blinkProgress);
    }

    fill(16,29,12);
    beginShape();
    vertex(left, y);
    bezierVertex(left, top, right, top, right, y);
    bezierVertex(topCX1, topCY1, topCX2, topCY2, left, y);
    endShape(CLOSE);
    fill(5);
    beginShape();
    vertex(left, y);
    bezierVertex(left, bottom, right, bottom, right, y);
    bezierVertex(bottomCX1, bottomCY1, bottomCX2, bottomCY2, left, y);
    endShape(CLOSE);
    popStyle();
  }
  
  public void DrawWhite(float x, float y)
  {
    //qiu
    pushStyle();
    fill(255);
    noStroke();
    ellipse(x, y, eyeballSize * .99f, eyeballSize * .99f);
    endShape(CLOSE);
    popStyle();
  }

  public void DrawIris(float x, float y)
  {    
    varX = lerp(varX, varXTarget, varSlide);
    varY = lerp(varY, varYTarget, varSlide);
    
    UpdateMouseTracking(x, y);
    float size = eyeballSize * irisScale;
    float minX = x - eyeballSize * .5f + size * .5f;
    float maxX = x + eyeballSize * .5f - size * .5f;

    float minY = y - eyeballSize * .4f + size * .5f;
    float maxY = y + eyeballSize * .4f - size * .5f;
    UpdateMouseTracking(x, y);
    x = lerp(minX, maxX, lerp(varX, trackX, mouseTrackingAmount * .8f));
    y = lerp(minY, maxY, lerp(varY, trackY, mouseTrackingAmount * .8f));
    pushStyle();
    //bai
    randomcolor=color(random(0,50), random(100,200), random(0,100));
    fill(randomcolor);
    noStroke();
    ellipse(x, y, eyeballSize * irisScale, eyeballSize * irisScale);
    popStyle();
    pushStyle();
    stroke(random(0,15),random(50,200),random(15,70),random(100,255));
    strokeWeight(3);
    ///////////////////////////
   // if(userNum==1){
    line(x,y,headPos.x,headPos.y);
 //   }else{
   //   line(x,y,kinectMinP.x,kinectMinP.y);
  //  }
    popStyle();
    DrawPupil(x, y);
  }


  public void SetVariance(float x, float y)
  {
      float scaling = .5f;
  
     varXTarget = .5f + (x - .5f) * scaling;
     varYTarget = .5f + (y - .5f) * scaling;
  }

  public float GetXVariance()
  {
    return varXTarget;
  }

  public float GetYVariance()
  {
    return varYTarget;
  }

  public void Blink()
  {
    blinkTimer = 0;
  }

  public boolean IsBlinking()
  {
    return blinkTimer < blinkLength;
  }
  
}