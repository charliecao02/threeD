class Snow {
  float x, y, z, vy, angle;

  Snow(float _x, float _y, float _z, float _vy, float _angle) {
    x = _x;
    y = _y;
    z = _z;
    vy = _vy;
    angle = _angle;
  }

  void show() {

    pushMatrix();
    translate(x, y, z);                                                
    box(10);
    popMatrix();
  }

  void act() {
    if(y<bs/2) y+=vy;
    x+=cos(angle);
    z+=sin(angle);
  }
  
  boolean melted(){
    if(y>=bs/2) return true;
    else return false;
  }
}
