int size = 1000, ////      size | (divs*layers)
    divs = 50,
    layers = 5,
    numShapes = 3,
    delta = 0,
    curr = 0,
    wdiv = size/divs,
    wlayer = wdiv/layers,
    shapeWidth = size/6,
    shapeHeight = size/6,
    offCenter = size/4;

PGraphics pg[] = new PGraphics[divs * layers];

void setup(){
  surface.setSize(size, size);
  noStroke();
  fill(0);
  
  for(int i=0; i<divs; i++){
    for(int j=0; j<layers; j++){
      curr = i*layers + j;
      pg[curr] = createGraphics(wlayer, height);
      pg[curr].beginDraw();
      pg[curr].background(255);
      pg[curr].translate(width/2 - i*wdiv -j*wlayer, height/2);
      pg[curr].noFill();
      pg[curr].strokeWeight(30);
      pg[curr].rotate(j*2*PI/numShapes/layers);
      for(int k=0; k<numShapes; k++){
        pg[curr].rotate(2*PI/numShapes);
        pg[curr].ellipse(offCenter, 0, shapeWidth, shapeHeight);
      }
      pg[curr].endDraw();
      //image(pg[curr], i*wdiv + j*wlayer, 0);
    }
  }
}

void draw(){
  printShapes();
  printRectangles();
  getInput();
}

void printShapes(){
  for(int i=0; i<divs; i++){
    for(int j=0; j<layers; j++){
      curr = i*layers + j;
      image(pg[curr], i*wdiv + j*wlayer, 0);
    }
  }
  delta++;
  if(delta >= wdiv)
    delta = 0;
}

void printRectangles(){
    rect(-wdiv+delta, 0, wdiv-wlayer, height);
  for(int i=0; i<divs; i++){
    rect(i*wdiv+delta, 0, wdiv-wlayer, height);
  }
}

void getInput(){
  //para cambiar las variables de las figuras, segmentos y velocidad
  if(false)
    updateShapes();
}

void updateShapes(){
  for(int i=0; i<divs; i++){
    for(int j=0; j<layers; j++){
      curr = i*layers + j;
      pg[curr].clear();
      pg[curr].beginDraw();
      
      pg[curr].background(255);
      pg[curr].translate(width/2 - i*wdiv -j*wlayer, height/2);
      pg[curr].noFill();
      pg[curr].strokeWeight(40);
      pg[curr].rotate(j*2*PI/numShapes/layers);
      for(int k=0; k<numShapes; k++){
        pg[curr].rotate(2*PI/numShapes);
        pg[curr].ellipse(offCenter, 0, shapeWidth, shapeHeight);
      }
      pg[curr].endDraw();
    }
  }
}
