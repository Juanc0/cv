class FVMesh{
  ArrayList<ArrayList<Integer>> faces;
  ArrayList<FVVertex> vertices;
}

class FVVertex{
  public float x,y,z;
  public ArrayList<Integer> faces;
  
  FVVertex(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
    this.faces = new ArrayList();
  }
}
