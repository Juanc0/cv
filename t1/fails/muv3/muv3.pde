int saturation;
float section;
PGraphics pg;
PShape ps;
void setup(){
  size(600, 600);
  saturation = 20;
  section = 2*PI/saturation;
  pg = createGraphics(width/2, height/2);
  drawPG();
  
  frameRate(1);
}

void draw(){
  for(int i=0; i<4; i++)
    image(pg,i%2*pg.width, i/2*pg.width);
}

void drawPG(){
  pg.beginDraw();
  pg.background(127);
  
  int curr, delta, delta2, j, colorPicker;
  pg.translate(pg.width/2, pg.height/2);
  
  for(int i=0; i<saturation; i++){
    println(i);
    j=4;
    colorPicker = i%2;
    while(j<width/(2*sqrt(2))){
      ps = createShape();
      ps.beginShape();
      
      ps.noStroke();
      ps.fill(colorPicker%2==0? #B4DC00: #9B1DC9);
      
      curr = int(2*j*sin(section/2));
      delta = int(curr*sin(section/2));
      delta2 = int(curr*cos(section/2));
      ps.vertex(j, 0);
      ps.vertex(j-delta, delta2);
      j += curr;
      curr = int(2*j*sin(section/2));
      delta = int(curr*sin(section/2));
      delta2 = int(curr*cos(section/2));
      ps.vertex(j-delta, delta2);
      ps.vertex(j, 0);
      
      ps.endShape(CLOSE);
      
      pg.shape(ps, 0, 0);
      colorPicker++;
    }
    pg.rotate(section);
  }
  pg.endDraw();
}
