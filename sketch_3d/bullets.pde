class Bullet {
  
  float x, y, z, vx, vz;
  int r, g, b;
  
  Bullet(float _x, float _y, float _z, float _vx, float _vz) {
    x = _x;
    y = _y;
    z = _z;
    vx = _vx;
    vz = _vz;
    
    r=int(random(0,255));
    g=int(random(0,255));
    b=int(random(0,255));
  }
  
  void show() {
    
    pushMatrix();
    translate(x, y, z);
    fill(r, g, b);
    box(10);
    popMatrix();
    
  }
  
  void act() {
     x = x + 2*vx;
     z = z + 2*vz;
  }
  
}
