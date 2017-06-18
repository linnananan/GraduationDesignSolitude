class Notice{
  
  String noticeText="";
  float xPos=0;
  float yPos=0;
  boolean flagGray=false;
  float Opacity=10;
  float FadeOut=20;
  
   DrawText drawText;
  Spot[] sp = new Spot[300];
  Notice(String s,float x,float y,boolean isGray){
    flagGray=isGray;
    noticeText = s;
    xPos = x;
    yPos = y;
  }
  void init(){
    drawText = new DrawText(noticeText,xPos,yPos,40);
    for (int i = 0; i < sp.length; i++) {
      sp[i] = new Spot(
        random(width/2-10, width/2+10), 
        random(5*height/8-10, 5*height/8+10 ) , 
        random(5, height/2), 
        random(0.5, 5),
        flagGray
      );
   }
  }
  void drawNotice(){
    
    background(0);
    drawText.textDrawing();
    for (int i = 0; i < sp.length; i++) {
      sp[i].move();
      sp[i].display();
    }
   sky.drawSky();
  }
  
   void reMove(){
    fill(0,Opacity);
    rect(0,0,width,height);
    Opacity=Opacity+FadeOut;
  }
  
}
class Spot {
  float x, y, diameter, speed;
  float h = random(256);
  float b_diameter;
  boolean flagGray=false;
  
  Spot(float _x, float _y, float _diameter, float _speed,boolean isGray) {
    x = _x;
    y = _y;
    diameter = _diameter;
    speed = _speed;
    b_diameter = diameter;
    
    flagGray=isGray;
  }
  
  void move() {
    diameter = b_diameter*sin(frameCount*speed*PI/600);
  }
  
  void display() {
    pushStyle();
    colorMode(HSB);
    if(flagGray){
      fill(100,40);
    }
    else{fill(h, 255, 255, 51);}
    noStroke();
    ellipse(x, y, diameter, diameter);  
    popStyle();
  }  
 
}