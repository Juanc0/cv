int INIT_W = 2;
int saturation,
    j,
    mult,
    div,
    currh,
    currw,
    initj,
    whileLimit;
float section;
PShape rhombus;
boolean keyDown;

void setup(){
  size(800, 800);
  saturation = 20;
  mult = 9;
  div = 7;
  currh = INIT_W;
  section = 2*PI/saturation;
  initj = int(currh/2/tan(section/4));
  whileLimit = int(width/sqrt(2));
  keyDown = false;
  stroke(255);
  noFill();
  ellipseMode(RADIUS);
  frameRate(1);
  
}

void draw(){
  background(255);
  translate(width/2, height/2);
  printRhombuses();
  printCircles();
  getInput();
}

void printRhombuses(){
  for(int i=0; i<saturation; i++){
    currh = INIT_W;
    currw = currh * mult / div;
    j = initj - currh/2;
    while(j<whileLimit){
      currh = doSomethingWithTheShape(j, currw, currh, 0);
      j += currw/2;
      currw = currh * mult / div;
      rotate(section/4);
      
      doSomethingWithTheShape(j, currw, currh, 150);
      rotate(-section/2);
      
      currh = doSomethingWithTheShape(j, currw, currh, 150);
      j += currw/2;
      currw = currh * mult / div;
      rotate(-section/4);
      
      currh = doSomethingWithTheShape(j, currw, currh, 0);
      j += currw/2;
      currw = currh * mult / div;
      rotate(section/4);
      
      doSomethingWithTheShape(j, currw, currh, 150);
      rotate(section/2);
      
      doSomethingWithTheShape(j, currw, currh, 150);
      currh = int((j+currw)*2*sin(section/4));
      j += currw/2;
      currw = currh * mult / div;
      rotate(-section/4);
    }
    rotate(section);
  }
}

int doSomethingWithTheShape(int x, int currw, int currh, int fill){
  rhombus = createShape();
  rhombus.beginShape();
  rhombus.stroke(255);
  rhombus.strokeWeight(x/(width/4));
  rhombus.fill(fill);
  rhombus.vertex(x+currw/2, -currh/2);
  rhombus.vertex(x, 0);
  rhombus.vertex(x+currw/2, currh/2);
  int aux = currw;
  currh = int((j+currw)*2*sin(section/4));
  currw = currh * mult / div;
  rhombus.vertex(x+(aux+currw)/2, 0);
  rhombus.endShape(CLOSE);
  shape(rhombus, 0, 0);
  return currh;
}

void printCircles(){
  for(int i=0; i<saturation; i++){
    j = initj;
    currh = INIT_W;
    currw = currh * mult / div;
    while(j < whileLimit){
      strokeWeight(3);
      ellipse(0, 0, j, j);
      
      currh = int((j+currw)*2*sin(section/4));
      currw = currh * mult / div;
      j += currw/2;
      currh = int((j+currw)*2*sin(section/4));
      currw = currh * mult / div;
      j += currw/2;
    }
    while(j < whileLimit){
      rotate(section);
    }
    rotate(section);
  }
}

void getInput(){
  if(keyPressed && !keyDown){
    keyDown = true;
    if(keyCode == UP && div<mult) div++;
    else if(keyCode == DOWN && div>1) div--;
    if(keyCode == RIGHT) mult++;
    else if(keyCode == LEFT && mult>div) mult--;
    if(key == 'q'){
      INIT_W++;
    }else if(key == 'a' && INIT_W>2){
      INIT_W--;
    }
    if(key == 'w') saturation+=2;
    else if(key == 's' && saturation>2) saturation--;
    
    section = 2*PI/saturation;
    initj = int(currh/2/tan(section/4));
    println("Ancho inicial: "+INIT_W+" largo: "+mult+" ancho: "+div+" saturacion: "+saturation);
  }
}

void keyReleased(){
  keyDown = false;
}
