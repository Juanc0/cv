
class Boid {
  public Frame frame;
  // fields
  Vector position, velocity, acceleration, alignment, cohesion, separation; // position, velocity, and acceleration in
  // a vector datatype
  float neighborhoodRadius; // radius in which it looks for fellow boids
  float maxSpeed = 4; // maximum magnitude for the velocity vector
  float maxSteerForce = .0001f; // maximum magnitude of the steering vector
  float sc = 10; // scale factor for the render of the boid
  float flap = 0;
  float t = 0;
  VVMesh vvmeshCube;
  VVMesh vvmeshX;
  FVMesh fvmeshCube;
  FVMesh fvmeshX;
  //spline srface
  PShape PSBoidVVCube;
  PShape PSBoidVVX;
  PShape PSBoidFVCube;
  PShape PSBoidFVX;
  int aux_d = 0, planeNum = 24;
  private void fillVVMesh(VVMesh myMesh, PShape PSBoid) {
    Stack myStack = new Stack();
    int currVertexId;
    VVVertex currVertex;
    VVVertex nextVertex;
    int i, j;
    Contiguo contiguo;


    PSBoid.beginShape();
    myStack.push(new Integer(0));
    currVertexId = (Integer) myStack.peek();
    currVertex = myMesh.getVertices().get(currVertexId);
    //println("venga", currVertex.getX(), currVertex.getY(), currVertex.getZ());
    PSBoid.vertex(currVertex.getX(), currVertex.getY(), currVertex.getZ());


    while (!myStack.empty()) {
      currVertexId = (Integer) myStack.peek();
      currVertex = myMesh.getVertices().get(currVertexId);

      for (i=0; i<currVertex.getContiguous().size(); i++) {
        contiguo = currVertex.getContiguous().get(i);

        //println("first ", myStack.peek(), currVertexId, currVertex.getTraveled(), "contiguo", i, contiguo.getId(), contiguo.getVisited(), vvmesh.getVertices().get(contiguo.getId()).isFull());
        if (!contiguo.getVisited()) {
          myStack.push(new Integer(contiguo.getId()));
          nextVertex = myMesh.getVertices().get(contiguo.getId());

          //println("venga", nextVertex.getX(), nextVertex.getY(), nextVertex.getZ());
          PSBoid.vertex(nextVertex.getX(), nextVertex.getY(), nextVertex.getZ());

          currVertex.increaseTraveled();
          nextVertex.increaseTraveled();
          contiguo.setVisited(true);
          for (j= 0; j<nextVertex.getContiguous().size(); j++) {
            if (nextVertex.getContiguous().get(j).getId() == currVertexId) {
              nextVertex.getContiguous().get(j).setVisited(true);
              break;
            }
          }
          break;
        }
      }
      if (i == currVertex.getContiguous().size()) {
        for (i=0; i<currVertex.getContiguous().size(); i++) {
          contiguo = currVertex.getContiguous().get(i);
          //println("second", myStack.peek(), currVertexId, currVertex.getTraveled(), "contiguo", i, contiguo.getId(), contiguo.getVisited(), vvmesh.getVertices().get(contiguo.getId()).isFull());
          if (!myMesh.getVertices().get(contiguo.getId()).isFull()) {
            myStack.push(new Integer(contiguo.getId()));
            nextVertex = myMesh.getVertices().get(contiguo.getId());

            //println("venga", nextVertex.getX(), nextVertex.getY(), nextVertex.getZ());
            PSBoid.vertex(nextVertex.getX(), nextVertex.getY(), nextVertex.getZ());
            break;
          }
        }
      }

      if (i == currVertex.getContiguous().size()) {
        myStack.pop();
        if (!myStack.empty()) {
          currVertexId = (Integer) myStack.peek();
          currVertex = myMesh.getVertices().get(currVertexId);
          PSBoid.vertex(currVertex.getX(), currVertex.getY(), currVertex.getZ());
        }
      }
    }
    PSBoid.endShape();
  }

  private void fillVVMeshCube(float sc) {
    this.vvmeshCube = new VVMesh();
    this.vvmeshCube.addVertex(new VVVertex(-sc, -sc, -sc));
    this.vvmeshCube.addVertex(new VVVertex(sc, -sc, -sc));
    this.vvmeshCube.addVertex(new VVVertex(sc, -sc, sc));
    this.vvmeshCube.addVertex(new VVVertex(-sc, -sc, sc));

    this.vvmeshCube.addVertex(new VVVertex(-sc, sc, -sc));
    this.vvmeshCube.addVertex(new VVVertex(sc, sc, -sc));
    this.vvmeshCube.addVertex(new VVVertex(sc, sc, sc));
    this.vvmeshCube.addVertex(new VVVertex(-sc, sc, sc));

    this.vvmeshCube.getVertices().get(0).getContiguous().add(new Contiguo(1));
    this.vvmeshCube.getVertices().get(0).getContiguous().add(new Contiguo(3));
    this.vvmeshCube.getVertices().get(0).getContiguous().add(new Contiguo(4));

    this.vvmeshCube.getVertices().get(1).getContiguous().add(new Contiguo(0));
    this.vvmeshCube.getVertices().get(1).getContiguous().add(new Contiguo(2));
    this.vvmeshCube.getVertices().get(1).getContiguous().add(new Contiguo(5));

    this.vvmeshCube.getVertices().get(2).getContiguous().add(new Contiguo(1));
    this.vvmeshCube.getVertices().get(2).getContiguous().add(new Contiguo(3));
    this.vvmeshCube.getVertices().get(2).getContiguous().add(new Contiguo(6));

    this.vvmeshCube.getVertices().get(3).getContiguous().add(new Contiguo(0));
    this.vvmeshCube.getVertices().get(3).getContiguous().add(new Contiguo(2));
    this.vvmeshCube.getVertices().get(3).getContiguous().add(new Contiguo(7));


    //for(int i=0; i<4; i++)

    this.vvmeshCube.getVertices().get(4).getContiguous().add(new Contiguo(0));
    this.vvmeshCube.getVertices().get(4).getContiguous().add(new Contiguo(5));
    this.vvmeshCube.getVertices().get(4).getContiguous().add(new Contiguo(7));

    this.vvmeshCube.getVertices().get(5).getContiguous().add(new Contiguo(1));
    this.vvmeshCube.getVertices().get(5).getContiguous().add(new Contiguo(4));
    this.vvmeshCube.getVertices().get(5).getContiguous().add(new Contiguo(6));

    this.vvmeshCube.getVertices().get(6).getContiguous().add(new Contiguo(2));
    this.vvmeshCube.getVertices().get(6).getContiguous().add(new Contiguo(5));
    this.vvmeshCube.getVertices().get(6).getContiguous().add(new Contiguo(7));

    this.vvmeshCube.getVertices().get(7).getContiguous().add(new Contiguo(3));
    this.vvmeshCube.getVertices().get(7).getContiguous().add(new Contiguo(4));
    this.vvmeshCube.getVertices().get(7).getContiguous().add(new Contiguo(6));
    fillVVMesh(this.vvmeshCube, this.PSBoidVVCube);
  }
  private void fillVVMeshX(float sc) {
    this.vvmeshX = new VVMesh();

    //for (int z = 0; z >8; z++){
    //  this.mesh.addVertex(new VVVertex(-sc*,,sc*(z-4)));
    //}

    for (int z= 0; z < planeNum; z+=2) {
      this.vvmeshX.addVertex(new VVVertex((-1-z)*sc, (-2-z)*sc, (-planeNum+z)*sc));
      this.vvmeshX.addVertex(new VVVertex((1+z)*sc, (-2-z)*sc, (-planeNum+z)*sc));
      this.vvmeshX.addVertex(new VVVertex((2+z)*sc, 0, (-planeNum+z)*sc));
      this.vvmeshX.addVertex(new VVVertex(0, (2+z)*sc, (-planeNum+z)*sc));
      this.vvmeshX.addVertex(new VVVertex((-2-z)*sc, 0, (-planeNum+z)*sc));
    }

    for (int z= planeNum - 2; z >= 0; z-=2) {
      this.vvmeshX.addVertex(new VVVertex((-1-z)*sc, (-2-z)*sc, (planeNum-z)*sc));
      this.vvmeshX.addVertex(new VVVertex((1+z)*sc, (-2-z)*sc, (planeNum-z)*sc));
      this.vvmeshX.addVertex(new VVVertex((2+z)*sc, 0, (planeNum-z)*sc));
      this.vvmeshX.addVertex(new VVVertex(0, (2+z)*sc, (planeNum-z)*sc));
      this.vvmeshX.addVertex(new VVVertex((-2-z)*sc, 0, (planeNum-z)*sc));
    }



    for (int i = 0; i < this.vvmeshX.getVertices().size(); i++) {
      if (i%5 == 0) aux_d = i;
      if (i == 0) {
        this.vvmeshX.getVertices().get(i).getContiguous().add(new Contiguo(((i-1)%5 + 5) + aux_d));
      } else {
        this.vvmeshX.getVertices().get(i).getContiguous().add(new Contiguo((i-1)%5 + aux_d));
      }

      this.vvmeshX.getVertices().get(i).getContiguous().add(new Contiguo((i+1)%5 + aux_d));

      if (i/5 > 0  && i/5 < planeNum - 1) {
        this.vvmeshX.getVertices().get(i).getContiguous().add(new Contiguo(i+5));
        this.vvmeshX.getVertices().get(i).getContiguous().add(new Contiguo(i-5));
      } else if (i/5 == 0) {
        this.vvmeshX.getVertices().get(i).getContiguous().add(new Contiguo(i+5));
      } else {
        this.vvmeshX.getVertices().get(i).getContiguous().add(new Contiguo(i-5));
      }
    }
    fillVVMesh(this.vvmeshX, this.PSBoidVVX);
  }
  Boid(Vector inPos) {
    position = new Vector();
    position.set(inPos);
    frame = new Frame(scene) {
      // Note that within visit() geometry is defined at the
      // frame local coordinate system.
      @Override
        public void visit() {
        if (animate)
          run(flock);
        render();
      }
    };
    frame.setPosition(new Vector(position.x(), position.y(), position.z()));
    velocity = new Vector(random(-1, 1), random(-1, 1), random(1, -1));
    acceleration = new Vector(0, 0, 0);
    neighborhoodRadius = 100;
    
    this.PSBoidVVCube = createShape();
    this.PSBoidVVX = createShape();
    this.PSBoidFVCube = createShape();
    this.PSBoidFVX = createShape();
    fillVVMeshCube(sc);
    fillVVMeshX(sc/5);
  }

  public void run(ArrayList<Boid> bl) {
    t += .1;
    flap = 10 * sin(t);
    // acceleration.add(steer(new Vector(mouseX,mouseY,300),true));
    // acceleration.add(new Vector(0,.05,0));
    if (avoidWalls) {
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), flockHeight, position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), 0, position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(flockWidth, position.y(), position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(0, position.y(), position.z())), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), position.y(), 0)), 5));
      acceleration.add(Vector.multiply(avoid(new Vector(position.x(), position.y(), flockDepth)), 5));
    }
    flock(bl);
    move();
    checkBounds();
  }

  Vector avoid(Vector target) {
    Vector steer = new Vector(); // creates vector for steering
    steer.set(Vector.subtract(position, target)); // steering vector points away from
    steer.multiply(1 / sq(Vector.distance(position, target)));
    return steer;
  }

  //-----------behaviors---------------

  void flock(ArrayList<Boid> boids) {
    //alignment
    alignment = new Vector(0, 0, 0);
    int alignmentCount = 0;
    //cohesion
    Vector posSum = new Vector();
    int cohesionCount = 0;
    //separation
    separation = new Vector(0, 0, 0);
    Vector repulse;
    for (int i = 0; i < boids.size(); i++) {
      Boid boid = boids.get(i);
      //alignment
      float distance = Vector.distance(position, boid.position);
      if (distance > 0 && distance <= neighborhoodRadius) {
        alignment.add(boid.velocity);
        alignmentCount++;
      }
      //cohesion
      float dist = dist(position.x(), position.y(), boid.position.x(), boid.position.y());
      if (dist > 0 && dist <= neighborhoodRadius) {
        posSum.add(boid.position);
        cohesionCount++;
      }
      //separation
      if (distance > 0 && distance <= neighborhoodRadius) {
        repulse = Vector.subtract(position, boid.position);
        repulse.normalize();
        repulse.divide(distance);
        separation.add(repulse);
      }
    }
    //alignment
    if (alignmentCount > 0) {
      alignment.divide((float) alignmentCount);
      alignment.limit(maxSteerForce);
    }
    //cohesion
    if (cohesionCount > 0)
      posSum.divide((float) cohesionCount);
    cohesion = Vector.subtract(posSum, position);
    cohesion.limit(maxSteerForce);

    acceleration.add(Vector.multiply(alignment, 1));
    acceleration.add(Vector.multiply(cohesion, 3));
    acceleration.add(Vector.multiply(separation, 1));
  }

  void move() {
    velocity.add(acceleration); // add acceleration to velocity
    velocity.limit(maxSpeed); // make sure the velocity vector magnitude does not
    // exceed maxSpeed
    position.add(velocity); // add velocity to position
    frame.setPosition(position);
    frame.setRotation(Quaternion.multiply(new Quaternion(new Vector(0, 1, 0), atan2(-velocity.z(), velocity.x())), 
      new Quaternion(new Vector(0, 0, 1), asin(velocity.y() / velocity.magnitude()))));
    acceleration.multiply(0); // reset acceleration
  }

  void checkBounds() {
    if (position.x() > flockWidth)
      position.setX(0);
    if (position.x() < 0)
      position.setX(flockWidth);
    if (position.y() > flockHeight)
      position.setY(0);
    if (position.y() < 0)
      position.setY(flockHeight);
    if (position.z() > flockDepth)
      position.setZ(0);
    if (position.z() < 0)
      position.setZ(flockDepth);
  }

  void render() {

    if (immediatRenderMode) {
      pushStyle();

      // uncomment to draw boid axes
      //scene.drawAxes(10);

      strokeWeight(2);
      stroke(color(40, 255, 40));
      fill(color(0, 255, 0, 125));

      // highlight boids under the mouse
      if (scene.trackedFrame("mouseMoved") == frame) {
        stroke(color(0, 0, 255));
        fill(color(0, 0, 255));
      }

      // highlight avatar
      if (frame ==  avatar) {
        stroke(color(255, 0, 0));
        fill(color(255, 0, 0));
      }
      if (splineSurface) {
      } else {
        if (meshRepresentationType) {
          if (cube) {
            renderVVMesh(this.vvmeshCube);
          } else {
            renderVVMesh(this.vvmeshX);
          }
        } else {
          if (cube) {
            //renderVVMesh(this.fvmeshCube);
          } else {
            //renderVVMesh(this.fvmeshX);
          }
        }
      }
      popStyle();
    } else {
      if (meshRepresentationType) {
        if (cube) {
          renderPShape(this.PSBoidVVCube);
        } else {
          renderPShape(this.PSBoidVVX);
        }
      } else {
        if (cube) {
          //renderVVMesh(this.fvmeshCube);
        } else {
          //renderVVMesh(this.fvmeshX);
        }
      }
      // uncomment to draw boid axes
      //scene.drawAxes(10);
    }
  }
  private void renderVVMesh(VVMesh vvmesh) {
    beginShape();

    //cube in inmediat mode
    vvmesh.clearMesh();
    Stack myStack = new Stack();
    int currVertexId;
    VVVertex currVertex;
    VVVertex nextVertex;
    int i, j;
    Contiguo contiguo;

    myStack.push(new Integer(0));
    currVertexId = (Integer) myStack.peek();
    currVertex = vvmesh.getVertices().get(currVertexId);
    vertex(currVertex.getX(), currVertex.getY(), currVertex.getZ());


    while (!myStack.empty()) {
      currVertexId = (Integer) myStack.peek();
      currVertex = vvmesh.getVertices().get(currVertexId);

      for (i=0; i<currVertex.getContiguous().size(); i++) {
        contiguo = currVertex.getContiguous().get(i);

        if (!contiguo.getVisited()) {
          myStack.push(new Integer(contiguo.getId()));
          nextVertex = vvmesh.getVertices().get(contiguo.getId());

          vertex(nextVertex.getX(), nextVertex.getY(), nextVertex.getZ());

          currVertex.increaseTraveled();
          nextVertex.increaseTraveled();
          contiguo.setVisited(true);
          for (j= 0; j<nextVertex.getContiguous().size(); j++) {
            if (nextVertex.getContiguous().get(j).getId() == currVertexId) {
              nextVertex.getContiguous().get(j).setVisited(true);
              break;
            }
          }
          break;
        }
      }
      if (i == currVertex.getContiguous().size()) {
        for (i=0; i<currVertex.getContiguous().size(); i++) {
          contiguo = currVertex.getContiguous().get(i);
          if (!vvmesh.getVertices().get(contiguo.getId()).isFull()) {
            myStack.push(new Integer(contiguo.getId()));
            nextVertex = vvmesh.getVertices().get(contiguo.getId());

            vertex(nextVertex.getX(), nextVertex.getY(), nextVertex.getZ());
            break;
          }
        }
      }

      if (i == currVertex.getContiguous().size()) {
        myStack.pop();
        if (!myStack.empty()) {
          currVertexId = (Integer) myStack.peek();
          currVertex = vvmesh.getVertices().get(currVertexId);
          vertex(currVertex.getX(), currVertex.getY(), currVertex.getZ());
        }
      }
    }  
    endShape();
  }
  private void renderPShape(PShape PSBoid){
    PSBoid.setStrokeWeight(2);
    PSBoid.setStroke(color(40, 255, 40));
    PSBoid.setFill(color(0, 255, 0, 125));

    // highlight boids under the mouse
    if (scene.trackedFrame("mouseMoved") == frame) {
      PSBoid.setStroke(color(0, 0, 255));
      PSBoid.setFill(color(0, 0, 255));
    }

    // highlight avatar
    if (frame ==  avatar) {
      PSBoid.setStroke(color(255, 0, 0));
      PSBoid.setFill(color(255, 0, 0));
    }
    
    shape(PSBoid);
  }
}
