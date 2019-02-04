class Contiguo{
  int id;
  boolean visited;
  Contiguo(int id){
    this.id = id;
    this.visited = false;
  }
  int getId(){
    return this.id;
  }
  boolean getVisited(){
    return this.visited;
  }
  void setVisited(boolean visited){
    this.visited = visited;
  }
}

class VVVertex{
  float x, y, z;
  ArrayList<Contiguo> contiguous;
  int traveled;
  
  VVVertex(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
    this.contiguous = new ArrayList();
    this.traveled = 0;
  }
  
  void addContiguous(int id){
    this.contiguous.add(new Contiguo(id));
  }
  
  ArrayList<Contiguo> getContiguous(){
    return this.contiguous;
  }
  
  boolean isFull(){
    return this.traveled == this.contiguous.size();
  }
  
  float getX(){
    return this.x;
  }
  float getY(){
    return this.y;
  }
  float getZ(){
    return this.z;
  }
  
  void increaseTraveled(){
    this.traveled++;
  }
  int getTraveled(){
    return this.traveled;
  }
  void setTraveled(int traveled){
    this.traveled = traveled;
  }
}

class VVMesh{
  ArrayList<VVVertex> vertices;
  
  VVMesh(){
    this.vertices = new ArrayList();
  }
  void addVertex(VVVertex v){
    this.vertices.add(v);
  }
  ArrayList<VVVertex> getVertices(){
    return this.vertices;
  }
  void clearMesh(){
    int i,j;
    for(i=0; i<this.vertices.size(); i++){
      this.vertices.get(i).setTraveled(0);
      for(j=0; j<this.vertices.get(i).getContiguous().size(); j++){
        this.vertices.get(i).getContiguous().get(j).setVisited(false);
      }
    }
  }
}
