class HermitCurve {
  
  ArrayList<Vector> controlPoints;
  float step;
  float tension;
  
  public HermitCurve(ArrayList<Vector> controlPoints, float step, float tension){
    this.controlPoints = controlPoints;
    this.step = step;
    this.tension = tension;  
  }
  
  public void drawCurve(){
    Vector aux;
   
    pushStyle();
    noFill();
    stroke(0, 0, 255);
    strokeWeight(8);
    for(float u = 0.0; u <=1.0; u+=this.step){
        aux = hermitPoint(u);
        point(aux.x(), aux.y(), aux.z());
    }
    popStyle();
  }
  
  private Vector hermitPoint(float u){
    Vector point = new Vector(), m0, m1, aux, aux1;
    int n = this.controlPoints.size();
    
    for(int i = 1; i < n - 2; i++){
      m0 = this.m(i);
      m1 = this.m(i + 1);

      aux = Vector.add(Vector.multiply(this.controlPoints.get(i),h0(u)),Vector.multiply(this.controlPoints.get(i + 1),h1(u)));
      aux1 = Vector.add(Vector.multiply(m0,h2(u)),Vector.multiply(m1,h3(u)));
      
      point =  Vector.add(aux, aux1);
    }
    return point;
  }
  
  public void drawCurve1(){  
    Vector aux;
    int n = this.controlPoints.size();
    pushStyle();
    noFill();
    stroke(0, 0, 255);
    strokeWeight(4);
    for(int i = 1; i < n - 2; i++){
      for(float u = 0.0; u <=1.0; u+=this.step){
        aux = hermitPoint1(u, i);
        point(aux.x(), aux.y(), aux.z());
      }
    }
    
    popStyle();
  }
  
  private Vector hermitPoint1(float u, int i){
    Vector point = new Vector(), m0, m1, aux, aux1;    
    m0 = this.m(i);
    m1 = this.m(i + 1);

    aux = Vector.add(Vector.multiply(this.controlPoints.get(i),h0(u)),Vector.multiply(this.controlPoints.get(i + 1),h1(u)));
    aux1 = Vector.add(Vector.multiply(m0,h2(u)),Vector.multiply(m1,h3(u)));
      
    point =  Vector.add(aux, aux1);
    
    return point;
  }
  
  
  private Vector m(int i){
    return Vector.multiply(Vector.subtract(this.controlPoints.get(i + 1), this.controlPoints.get(i - 1)), (1 - this.tension)*0.5);    
  }
  
  private float h0(float u){
    return 2*pow(u,3)-3*pow(u,2)+1;  
  }
  
  private float h1(float u){
    return -2*pow(u,3)+3*pow(u,2);
  }
  private float h2(float u){
    return pow(u,3)-2*pow(u,2)+u;
  }
  private float h3(float u){
    return pow(u,3)-pow(u,2);
  } 
}

class BezierCurve {
  
  ArrayList<Vector> controlPoints;
  float step;
  int[] coefficients;
  
  public BezierCurve(ArrayList<Vector> controlPoints, float step){
    this.controlPoints = controlPoints;
    this.step = step;
    this.coefficients = coef(initControlPoints);;
  }
  
  public void drawCurve(){  
    Vector aux;
   
    pushStyle();
    noFill();
    stroke(255, 0, 0);
    strokeWeight(4);
    for(float i = 0.0; i <=1.0; i+=0.01){
        aux = bezierPoint(i);
        point(aux.x(), aux.y(), aux.z());
    }
    popStyle();
  }
  
  private Vector bezierPoint(float u){
    Vector point = new Vector(0.0, 0.0, 0.0);
    
    //float x = 0.0, y = 0.0, z = 0.0;
    int n = controlPoints.size();
      
    for(int k = 0; k < n; k++){
      //x += controlPoints.get(k).x()*coefficients[k]*pow(u, k)*pow(1-u, n-1-k);
      //y += controlPoints.get(k).y()*coefficients[k]*pow(u, k)*pow(1-u, n-1-k);
      //z += controlPoints.get(k).z()*coefficients[k]*pow(u, k)*pow(1-u, n-1-k);
      point = Vector.add(point, Vector.multiply(controlPoints.get(k), number(k, u, n)));
    }
    
     
    //point.setX(x);
    //point.setY(y);
    //point.setZ(z);
    
    return point;
  }
  
  private float number(int k, float u, int n){
   return coefficients[k]*pow(u, k)*pow(1-u, n-1-k);
  }
  
  int[] coef(int grade){
    int[] coef = new int[grade+1];
    int[] fact = new int[grade+1];
    fact[0] = 1;
    // fact
    for(int i = 1; i <= grade; i++){
      fact[i] = fact[i-1]*i;
    }
    for(int i = 0; i <= grade; i++){
      coef[i] = fact[grade]/(fact[i]*fact[grade-i]);
    }  
    return coef;  
  }
}
