PShape s,t,u;

void setup(){
  size(600,600);
  background(255,255,255);
  
  s = createShape();
  s.beginShape();
  s.fill(125, 255, 125);
  s.strokeWeight(1);
  s.vertex(0, 0);
  s.vertex(100, 0);
  s.vertex(150, 86);
  s.vertex(50, 86); 
  s.endShape(CLOSE);
  
  t = createShape();
  t.beginShape();
  t.fill(125, 255, 200);
  t.strokeWeight(1);
  t.vertex(50, 86);
  t.vertex(150, 86);
  t.vertex(100, 172);
  t.vertex(150, 172);
  t.vertex(0, 260); //130
  t.vertex(-50, 172);
  t.vertex(0, 172);
  t.endShape(CLOSE);
  
  u = createShape();
  u.beginShape();
  u.fill(200, 255, 125);
  u.strokeWeight(1);
  u.vertex(124, 130);
  u.vertex(150, 172);
  u.vertex(100, 172); 
  u.endShape(CLOSE);
}

void draw(){
  translate(width/2, height/2);
  color green_dark, green_ligth, yellow;
  green_dark = color(26, 114, 90);
  green_ligth = color(45, 183, 73);
  yellow = color(227, 233, 135);
  
  for(int i= 0; i<6; i++){
    switch(i%3){
      case 0:
        s.setFill(yellow);
        t.setFill(green_ligth);
        u.setFill(yellow);
      break;
      case 1:
        s.setFill(green_dark);
        t.setFill(yellow);
        u.setFill(green_dark);
      break;
      case 2:
        s.setFill(green_ligth);
        t.setFill(green_dark);
        u.setFill(green_ligth);
      break;
    }
    shape(s, 0, 0);
    shape(t, 0, 0);
    shape(u, 0, 0);
    
    rotate(PI/3.0);
  }  
}
