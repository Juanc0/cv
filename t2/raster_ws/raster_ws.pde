import frames.timing.*;
import frames.primitives.*;
import frames.core.*;
import frames.processing.*;
//Vector colors
color cv1 = color(255, 0, 0), cv2 = color(0, 255, 0), cv3 = color(0, 0, 255);
// 1. Frames' objects
Scene scene;
Frame frame;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

void setup() {
  //use 2^n to change the dimensions
  size(512, 512, renderer);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fitBallInterpolation();

  // not really needed here but create a spinning task
  // just to illustrate some frames.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the frame instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask() {
    @Override
      public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };
  scene.registerTask(spinningTask);

  frame = new Frame();
  frame.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(frame);
  triangleRaster();
  popStyle();
  popMatrix();
}

float edge(Vector p, Vector a, Vector b) {
  return  (a.y() - b.y())*p.x() + (b.x() - a.x())* p.y() + (a.x()*b.y() - a.y()*b.x());
  //return (a.x() - b.x()) * (p.y() - a.y()) - (a.y() - b.y()) * (p.y() - a.x());
}

void ccw(){
 float area = edge(v3,v1,v2);
 if(area < 0){ //positivo a la izq
   Vector tmp = v2;
   color ctmp = cv2;
   v2 = v3;
   cv2 = cv3;
   v3 = tmp;
   cv3 =ctmp;
   print("ccw");
 }
}


// Implement this function to rasterize the triangle.
// Coordinates are given in the frame system which has a dimension of 2^n
void triangleRaster() {
  // frame.location converts points from world to frame
  // here we convert v1 to illustrate the idea
  int my_size = (int)pow(2, n)/2;
  float w1, w2, w3, red, green, blue, area = edge(v3,v1,v2);
  Vector v_aux, v_world;

  pushStyle();
  for (int i = -my_size; i < my_size; i++) {
    for (int j = -my_size; j < my_size; j++) {
      // Calcular funcion de borde
      v_aux = new Vector(j + 0.5, i + 0.5);
      v_world = frame.worldLocation(v_aux);
      w1 = edge(v_world, v1, v2);
      w2 = edge(v_world, v2, v3);
      w3 = edge(v_world, v3, v1);
           
      if (w1 >= 0f && w2 >= 0f && w3 >= 0f) {
        w1 /= area;
        w2 /= area;
        w3 /= area;
        red = red(cv1)*w1 + red(cv2)*w2 + red(cv3)*w3;
        green = green(cv1)*w1 + green(cv2)*w2 + green(cv3)*w3;
        blue = blue(cv1)*w1 + blue(cv2)*w2 + blue(cv3)*w3;
        noStroke();
        fill(red, green, blue);
        //point(v_aux.x(), v_aux.y());
        rect(j, i, 1, 1);
      }
    }
  }
  popStyle();
  if (debug) {
    //println(frame.location(v1).x());
    pushStyle();
    stroke(255, 255, 0, 125);
    //point(round(frame.location(v1).x()), round(frame.location(v1).y()));
    popStyle();
    /*
    println("v1:" + v1.x() + "," + v1.y());
    println("v2:" + v2.x() + "," + v2.y());
    println("v3:" + v3.x() + "," + v3.y());*/
  }
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
  ccw();
}

void drawTriangleHint() {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  triangle(v1.x(), v1.y(), v2.x(), v2.y(), v3.x(), v3.y());
  strokeWeight(5);
  stroke(0, 255, 255);
  point(v1.x(), v1.y());
  point(v2.x(), v2.y());
  point(v3.x(), v3.y());
  popStyle();
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    frame.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    frame.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;
}
