PShape black, white, w_center, b_center, lr_black, ll_black, ll0_black, lr_white, ll_white, ll0_white, b_black, b_white;
int n = 17, n_2 = int(n/2), size = 700/n, size_2 = size/2;

void setup() {
  size(700, 700);
  color c_white = color(255, 255, 255);
  background(255, 255, 255);
  black = createShape(GROUP);
  white = createShape(GROUP);
  w_center = createShape(GROUP);
  b_center = createShape(GROUP);

  b_black = createShape(RECT, 0, 0, size, size);
  b_black.setFill(1);
  b_white = createShape(RECT, 0, 0, size, size);
  b_white.setFill(c_white);
  ll_black = createShape(RECT, 2*size/25, 2*size/25, size/5, size/5);
  ll_black.setFill(1);
  ll0_black = createShape(RECT, 2*size/25, size - (size/5 + 2*size/25), size/5, size/5);
  ll0_black.setFill(1);
  ll_white = createShape(RECT, 2*size/25, 2*size/25, size/5, size/5);
  ll_white.setFill(c_white);
  ll0_white = createShape(RECT, size - (size/5 + 2*size/25), 2*size/25, size/5, size/5);
  ll0_white.setFill(c_white);
  lr_black = createShape(RECT, size - (size/5 + 2*size/25), size - (size/5 + 2*size/25), size/5, size/5);
  lr_black.setFill(1);
  lr_white = createShape(RECT, size - (size/5 + 2*size/25), size - (size/5 + 2*size/25), size/5, size/5);
  lr_white.setFill(c_white);


  black.addChild(b_black);
  black.addChild(ll_white);
  black.addChild(lr_white);
  white.addChild(b_white);
  white.addChild(ll_black);
  white.addChild(lr_black);
  w_center.addChild(b_white);
  w_center.addChild(ll_black);
  w_center.addChild(ll0_black);
  w_center.rotate(3*PI/2);
  w_center.translate(-size,0);
  b_center.addChild(b_black);
  b_center.addChild(ll_white);
  b_center.addChild(ll0_white);
  b_center.rotate(PI);
  b_center.translate(-size, -size);
}

void draw() {
  for (int i = 0; i<n; i++) {
    for (int j = 0; j<n; j++) {
      if ((i+j)% 2 == 0) {
        shape(b_black, i*size, j*size);
      } else {
        shape(b_white, i*size, j*size);
      }
    }
  }


  translate(size*n/2, size*n/2);
  for (int l = 0; l < 4; l++) {
    shape(w_center, -size_2, -(size+size_2));

    for (int i=-2; i > -n_2; i--) {
      int aux = i;
      for (int j = 0; j < n_2-1 && aux < 0; j++) {

        if (i % 2 == 0) {
          shape(black, -size_2 + size*j, -size_2 + size*aux++ );
        } else {
          shape(white, -size_2 + size*j, -size_2 + size*aux++ );
        }
      }
    }    
    //Holi ya esta arriba :v
    /*for(int k = 0; k < 5; k++){
     for(int j = 0; j < k ; j++ ){
     shape(black, size_2+ size*(k-j-1), size_2+size*j);
     }
     }*/
   rotate(PI/2);
  }
  
  
  for(int j= 0; j<4;j++){
    for(int i = -1; i >-n_2; i--){
      if(i % 2 == 0){
        shape(b_center, -size_2, -size_2 + size*i);
      }else{
        shape(w_center, -size_2, -size_2 + size*i);
      }
    }
  rotate(PI/2);
  }
}
