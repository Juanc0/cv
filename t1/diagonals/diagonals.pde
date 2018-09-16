  int wid=600,
      heig=400,
      n1=40,
      n2=20,
      n3=10,
      s1=(wid+heig)/n1,
      s2=(wid+heig)/n2,
      s3=wid/n3,
      w=s3/2,
      opacity=255;
  boolean keyFlag=false;
  
  void setup(){
    surface.setSize(wid,heig);
  }
  
  void draw(){
    
    surface.setSize(wid,heig);
    
    s1=(wid+heig)/n1;
    s2=(wid+heig)/n2;
    s3=wid/n3;
    
    background(255, 255, 255);
    stroke(0);
    //  GG de arreglarlo salen tres ciclos
    for(int i=0; i<width/s1+height/s2; i++){
      line(i*s1, 0, 0, i*s2);
    }
    
    
    noStroke();
    fill(145, 98, 45, opacity);
    for(int i=0; i<width/s3; i++){
      rect(i*s3, 0, w, height);
    }
    
    if(keyPressed && !keyFlag){
      keyFlag = true;
      if(keyCode==UP && opacity<255) opacity+=5;
      if(keyCode==DOWN && opacity>0) opacity-=5;
      if(keyCode==RIGHT && w<s3) w+=s3/20;
      if(keyCode==LEFT && w>0) w-=s3/20;
      
      if(key=='q') n1++;
      if(key=='a' && n1>1) n1--;
      if(key=='w') n2++;
      if(key=='s' && n2>1) n2--;
      if(key=='e') n3++;
      if(key=='d'&& n3>1) n3--;
      if(key=='r') wid+=5;
      if(key=='f'&& wid>1) wid-=5;
      if(key=='t') heig+=5;
      if(key=='g'&& heig>1) heig-=5;
    }
  }
  
  void keyReleased(){
    keyFlag = false;
  }
