class FireworksUp {
 
  float x, y, z, vy;
  
  FireworksUp(float _x, float _y, float _z, float _vy) {
    x = _x;
    y = _y;
    z = _z;
    vy = _vy;
    
  }

  void show() {
    pushMatrix();
    translate(x, y, z);
    fill(0,0,0);
    box(30);
    popMatrix();
  }

  void act() {
    if(y>-3000) y-=vy;
  }
  
  boolean exploded(){
    if(y>-3000) return false;
    else return true;
  }
}

class FireworksXZ {
  
  float x, y, z, vy, angle;
  int timer, timer1;
  int r, g, b;
  
  FireworksXZ(float _x, float _y, float _z, float _vy, float _angle) {
    x = _x;
    y = _y;
    z = _z;
    vy = _vy;
    timer = 0;
    timer1 = int(random(30,60));
    angle=_angle;
    
    r=int(random(0,255));
    g=int(random(0,255));
    b=int(random(0,255));
  }

  void show() {

    pushMatrix();
    translate(x, y, z);
    fill(r,g,b);
    box(20);
    noFill();
    popMatrix();
  }

  void act() {
    x+=random(15,20)*cos(angle);
    z+=random(15,20)*sin(angle);
    timer++;
  }
  
  boolean gone(){
    if(timer<timer1) return false;
    else return true;
  }
}
