import frames.primitives.*;
import frames.core.*;
import frames.processing.*;

import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;

ControlIO control;
Configuration config;
ControlDevice joistick;
ControlSlider xPos;
ControlSlider yPos;
ControlSlider zPos;
ControlSlider zRot;
ControlButton triangle;
ControlButton square;
ControlButton cross;
ControlButton circle;
ControlButton left_1;
ControlButton left_2;
ControlButton right_1;
ControlButton right_2;
Shape cow, labyrinth;
boolean zTranslate, zRotate, b_cow;
Frame cam;
Scene scene;

public void setup() {
  zTranslate = false;
  zRotate = false;
  b_cow = false;
  size(1240, 720, P3D);
  initJoistick();
  scene = new Scene(this);
  scene.setRadius(50);
  //scene.fit(1);
  //Shape cow = new Shape(scene, loadShape("Baymax/Bigmax_White_OBJ.obj"));
  cow = new Shape(scene, loadShape("spot/spot_control_mesh.obj"));
  labyrinth = new Shape(scene, loadShape("Labyrinth/Labyrinth.obj"));
  labyrinth.translate(20,0,20);
  labyrinth.scale(2);
  labyrinth.rotate(new Vector(1,0,0), PI);
  cow.translate(0,-0.8,38);
  cow.rotate(new Vector(0,0,1), PI);
  //cow.rotate(new Vector(0,1,0), 3*PI/2);
  cam = new Frame(cow);
  cam.translate(0,0,2);
}

public void draw() {
  pointLight(255, 255, 255, 0, 40, 0);
  pointLight(255, 255, 255, 0, -40, 0);
  background(0);
  scene.drawAxes();
  
  if(b_cow){
    //scene.moveForward(yPos.getValue()/20);
    scene.translate(xPos.getValue(),0,-yPos.getValue()/20, cow);
    
    if(!right_1.pressed()){
      cow.rotate(new Vector(1,0,0), -zPos.getValue() * PI / width);
      cow.rotate(new Vector(0,1,0), zRot.getValue() * PI / width); 
    } else {
      cow.rotate(new Vector(0,0,1), zRot.getValue() * PI / width);
    } 
    

  } else {
    if(!left_1.pressed()){
      scene.translate(-xPos.getValue(), 0, yPos.getValue());  
    } else {
      scene.translate(0, yPos.getValue(), 0);
    }
    
    if(!right_1.pressed()){
      scene.rotate( -zPos.getValue() * PI / width, -zRot.getValue() * PI / width, 0);  
    } else {
      scene.rotate( 0, 0, -zPos.getValue() * PI / width);
    } 
  }
  
  scene.traverse(); 
}

void keyPressed() {
  if (key == 'v'){
    b_cow = !b_cow;
    scene.eye().setReference(cam);
    //scene.rotate(0, -3*PI/2, 0);
    scene.fit(cam, 1);
    
  }
}

public void initJoistick(){
 // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  // Find a device that matches the configuration file
  joistick = control.getMatchedDevice("JController");
  if (joistick == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  } 
  
  xPos = joistick.getSlider("X");
  yPos = joistick.getSlider("Y");
  zPos = joistick.getSlider("Z");
  zRot = joistick.getSlider("RZ");
  triangle = joistick.getButton("TRIANGLE");
  square = joistick.getButton("SQUARE");
  cross = joistick.getButton("CROSS");
  circle = joistick.getButton("CIRCLE");
  left_1 = joistick.getButton("L1");
  left_2 = joistick.getButton("L2");
  right_1 = joistick.getButton("R1");
  right_2 = joistick.getButton("R2");
}
