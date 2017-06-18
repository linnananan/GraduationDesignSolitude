import SimpleOpenNI.*;
import processing.video.*;
import ddf.minim.*;

Minim minim;
AudioPlayer noticeM1;
AudioPlayer noticeM2;
AudioPlayer noticeM3;
AudioPlayer noticeM4;
AudioPlayer noticeM5;
AudioPlayer interactionM;
AudioPlayer starM;
AudioPlayer eyeM;

boolean isLoop;
int userNum=0;
SimpleOpenNI context;
Timer timer;
Notice noticeBall;

StarSky sky;
SkyBubble drawSkyBubble;
SkyBubble drawSkyBubbleUser;

TrackKinectClosest trackKinect;
EyeSceneCut eyeScenePass;
EyeSceneCut2 eyeScenePass2;
EyeLook eyeLookScene;
EyeDark darkEye;
PVector kinectPoint;  //手部
//**********************
PVector headPos = new PVector();  //头部
PVector kinectMinP = new PVector();  //最近点

Movie mov;
Movie movGlitch;
Movie bgMov;
Movie lastmov;

PImage solitudeText; 
PImage secondText;
PImage lastText;


void setup(){
  fullScreen();
  background(0);
  frameRate(60);
  smooth(8);
  isLoop = false;
  
  
  drawSkyBubble =new SkyBubble(userNum,true);
  drawSkyBubble.initPos();
  
  sky = new StarSky();
  sky.initSky();
  
  kinectPoint=new PVector(0.0,0.0);
  context = new SimpleOpenNI(this);
  if(context.isInit() == false){
         print("Can't init SimpleOpenNI, maybe the camera is not connected!");
         exit();
         return;
  }   
  context.enableDepth();
  context.enableUser();
  context.enableRGB();

//————————————视频&图————————————————
  mov = new Movie(this, "mine2-.mov");
  bgMov = new Movie(this,"mine2.mov");
  movGlitch = new Movie(this,"mine1.mov");
  lastmov = new Movie(this,"lastmov.mov");

  solitudeText = loadImage("start.png");
  secondText = loadImage("second.png");
  lastText  = loadImage("last.png");
  
  //------------------------初始化-----------------------------
  trackKinect = new TrackKinectClosest();
  eyeScenePass = new EyeSceneCut();
  eyeScenePass2 = new EyeSceneCut2();
  darkEye = new EyeDark();
  darkEye.init(); 
  eyeLookScene = new EyeLook();
  eyeLookScene.initEyeLook();
  eyeScenePass.initEyeSceneCut();
  
  timer = new Timer(10,60,165); 
  timer.start();
  //-----------------------音乐----------------------------
  minim = new Minim(this); 
  noticeM1 = minim.loadFile("noticeM1.mp3",2048); 
  noticeM2 = minim.loadFile("noticeM2.mp3",2048);
  noticeM3 = minim.loadFile("noticeM2.mp3",2048);
  noticeM4 = minim.loadFile("noticeM2.mp3",2048);
  noticeM5 = minim.loadFile("noticeM1.mp3",2048);
  eyeM= minim.loadFile("MyMusic.mp3",2048);
 // interactionM = minim.loadFile("interactionM.mp3",2048);
  starM = minim.loadFile("starM.mp3",2048);
}

void draw(){
  context.update();
  //------------------------------5.26-----头-------**********************
   int[] userList = context.getUsers();
  for(int i=0;i<userList.length;i++)
  {
    if(context.isTrackingSkeleton(userList[i]))
    {
      //stroke(userClr[ (userList[i] - 1) % userClr.length ] );
      //drawSkeleton(userList[i]);
      PVector jointPos = new PVector();
      PVector jointPos2 = new PVector();
  context.getJointPositionSkeleton(userList[i],SimpleOpenNI.SKEL_HEAD,jointPos);
  
  pushStyle();
  headPos.x=jointPos.x+width/2;
  headPos.y=height-jointPos.y;
  popStyle();
  
  //手
  context.getJointPositionSkeleton(userList[i],SimpleOpenNI.SKEL_RIGHT_HAND ,jointPos2);
  kinectPoint.x=jointPos2.x+width/2;
  kinectPoint.y=height-jointPos2.y;
    }
  }
  //__________________
  kinectMinP = trackKinect.getKinectPoint();
  
    if(timer.currentTime()>=0 && timer.currentTime()<=10){
       String notice1 = " ";    
       noticeBall = new Notice(notice1,width/2,height/3,false);
       noticeBall.init();
       noticeBall.drawNotice();
       noticeM1.play();

      image(solitudeText,0,0);
     }else if(timer.currentTime()>10 && timer.currentTime()<=55){
      movGlitch.play();
      trackKinect.showGlitchMov(193);
     }else if(timer.currentTime()>55 && timer.currentTime()<=91){
       movGlitch.stop();
       bgMov.loop();
       mov.loop();
       trackKinect.showKinectInMov();
     }else if(timer.currentTime()>91 && timer.currentTime()<=100){
       bgMov.stop();
       mov.stop();
       noticeM3.play();
       String notice3 = "";
       noticeBall = new Notice(notice3,width/2,height/4,true);
       noticeBall.init();
       noticeBall.drawNotice();
       image(secondText,0,0);
     }else if(timer.currentTime()>100 && timer.currentTime()<=142){    
       eyeM.play();
       eyeLookScene.eyeCatchPoint(headPos);
         //if(timer.currentTime()>110 && timer.currentTime()<=111){
         //  eyeScenePass.catchPoint((width/2,height/2));
         //}
         if(timer.currentTime()>110 && timer.currentTime()<=142){    //眼睛交互
           eyeScenePass.catchPoint(kinectPoint);  
           eyeLookScene.removePoint(kinectPoint);
           }   
     }else if(timer.currentTime()>142 && timer.currentTime()<=188){
       if(timer.currentTime()>142 && timer.currentTime()<=160)   //eye_dark
         {
           darkEye.drawDarkEye();
         }
       if(timer.currentTime()>150 && timer.currentTime()<=188)  //inter
         {
           eyeScenePass2.catchPoint(headPos);
         }
     }else if(timer.currentTime()>188 && timer.currentTime()<=196){
       lastmov.play();
       trackKinect.showlastMov(193);
     }else if(timer.currentTime()>196 && timer.currentTime()<=206){    
         noticeM5.play();
         String notice5 = "";
         noticeBall = new Notice(notice5,width/2,height/4-100,false);
         noticeBall.init();
         noticeBall.drawNotice();
         image(lastText,0,0);
     }else{
       while(userNum<=0){
         timer.pause();
       }
       timer.restart();
     }
   
}

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  userNum = userId;
  println("onVisibleUser - userId: " + userId);
}