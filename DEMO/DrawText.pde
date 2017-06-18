class DrawText{
  PFont Dosis;
  String text=" ";
  float xPosition=0;
  float yPosition=0;
  PFont font;  
  int textsize;
  float Opacity=255; 
  float FadeOut=2;
  DrawText(String t,float x,float y,int size){
    text=t;
    xPosition=x;
    yPosition=y;
    textsize=size;
    font = createFont("黑体",30); 
  }

  void textDrawing(){
    textAlign(CENTER);
    fill(255,Opacity); 
    textFont(font,textsize);
    textLeading(80);
    text(text,xPosition,yPosition);
    Opacity=Opacity-FadeOut;  
    //print(Opacity);
  }
}