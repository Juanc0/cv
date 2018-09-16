color white = color(255, 255, 255),
      grey = color(30, 30, 30);
int size = 8,
    size_2 = size*2,
    w = 68*size_2;
int[] xPos= {0, 17*size_2, 34*size_2, 51*size_2};
PShape duck; //|170 ancho

void settings(){
  size(w, 600);
}


void setup() {

  duck = createShape();
  duck.beginShape();
  duck.fill(grey);
  duck.noStroke();
  duck.vertex(0, 0);
  duck.vertex(0, -size_2);
  duck.vertex(size_2, -size_2);
  duck.vertex(size_2, -2*size_2);
  duck.vertex(2*size_2, -2*size_2);
  duck.vertex(2*size_2, -3*size_2);
  duck.vertex(3*size_2, -3*size_2);
  duck.vertex(3*size_2, -4*size_2);
  duck.vertex(4*size_2, -4*size_2);
  duck.vertex(4*size_2, -5*size_2);
  duck.vertex(4*size_2 + size, -5*size_2);
  duck.vertex(4*size_2 + size, -8*size_2);
  duck.vertex(7*size_2+size, -8*size_2);
  duck.vertex(7*size_2+size, -6*size_2);
  duck.vertex(8*size_2+size, -6*size_2);
  duck.vertex(8*size_2+size, -5*size_2);
  duck.vertex(7*size_2, -5*size_2);
  duck.vertex(7*size_2, 0);
  duck.vertex(5*size_2, 0);
  duck.vertex(5*size_2, 2*size_2);
  duck.vertex(6*size_2, 2*size_2);
  duck.vertex(6*size_2, 2*size_2 + size);
  duck.vertex(4*size_2, 2*size_2 + size);
  duck.vertex(4*size_2, 0);

  duck.endShape(CLOSE);
}

void draw() {
  background(white);
  for (int i = 0; i < width/size; i++) {
    if (i % 2 == 0) {
      fill(white);
    } else {
      fill(0);
    }
    rect(i*size, 0, size, height);
  }

  int y = 245;
  for (int i= 0; i < 4; i++) {
    if (i % 2 == 0) {
      y+=100;
    } else {
      y-=100;
    }    
    shape(duck, xPos[i]++, y);
    
    if(xPos[i]>width) xPos[i] = 0;
  }

  //shape(duck, 0, 345);
}
