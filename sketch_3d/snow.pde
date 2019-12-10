class Snow {
  float x, y, z, vy;

  Snow(float _x, float _y, float _z, float _vy) {
    x = _x;
    y = _y;
    z = _z;
    vy = _vy;
  }

  void show() {

    pushMatrix();
    translate(x, y, z);                                                
    box(10);
    popMatrix();
  }

  void act() {
    if(y<ly+bs/2) y+=vy;
  }
}
