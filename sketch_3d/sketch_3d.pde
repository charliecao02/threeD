ArrayList<Bullet> bullets;
ArrayList<Snow> snow;
ArrayList<FireworksUp> fwkup;
ArrayList<FireworksXZ> fwkxz;
//keyboard interaction
boolean up, down, left, right, space=false;
int vy=0;

//World manipulation
int bs = 100;

//camera variables
float lx = 2500, ly = height/2 - bs/2, lz = 2500;
PVector xzDirection = new PVector(0, -10); //which way we are facing
PVector xyDirection = new PVector(10, 0);  //for looking up and down
PVector strafeDir = new PVector(10, 0);
float leftRightHeadAngle = 0;
float upDownHeadAngle    = 0;


//color pallette
color black = #000000;
color white = #FFFFFF;

PImage map;

//textures
PImage qblock, dT, dS, dB;


void setup() {
  size(1200, 1000, P3D);

  //load textures
  qblock = loadImage("qblock.png");
  dT     = loadImage("dirt_top.png");
  dS     = loadImage("dirt_side.jpg");
  dB     = loadImage("dirt_bottom.jpeg");
  textureMode(NORMAL);

  //load map
  map = loadImage("map.png");

  bullets = new ArrayList<Bullet>(10000);
  snow= new ArrayList<Snow>(10000);
  fwkup = new ArrayList<FireworksUp>(10000);
  fwkxz = new ArrayList<FireworksXZ>(10000);
}

void draw() {
  background(128);
  
  snow.add(new Snow(random(-width*5, width*5), -5000.0, random(-width*5, width*5), random(5,10), random(0,360) ));
  fwkup.add(new FireworksUp(random(-width*5, width*5), bs, random(-width*5, width*5), 20 ));
  int i1 = 0;
  while (i1 < snow.size()) {
    Snow s = snow.get(i1);
    if(s.melted()==true) snow.remove(i1);
    else i1++;
  }
  
  int i2 = 0;
  while (i2 < fwkup.size()) {
    FireworksUp f1 = fwkup.get(i2);
    if(f1.exploded()==true) {
      for(int a=0;a<100;a++){
        fwkxz.add(new FireworksXZ(f1.x, -3000, f1.z, 30, random(0,360) ));
      }
      fwkup.remove(i2);
    }
    else i2++;
  }
  
  int i3 = 0;
  while (i3 < fwkxz.size()) {
    FireworksXZ f2 = fwkxz.get(i3);
    if(f2.gone()==true) fwkxz.remove(i3);
    else i3++;
  }
  
  float dx = lx+ xzDirection.x;
  float dy = ly+ xyDirection.y;
  float dz = xzDirection.y+lz;
  camera(lx, ly, lz, dx, dy, dz, 0, 1, 0); 
  xzDirection.rotate(leftRightHeadAngle);
  xyDirection.rotate(upDownHeadAngle);
  leftRightHeadAngle = -(pmouseX - mouseX) * 0.01;
  upDownHeadAngle    = -(pmouseY - mouseY) * 0.01;

  //headAngle = headAngle + 0.01;

  strafeDir = xzDirection.copy();
  strafeDir.rotate(PI/2);

  if (up) {   
    lx = lx + xzDirection.x;
    lz = lz + xzDirection.y;
  }
  if (down) {
    lx = lx - xzDirection.x;
    lz = lz - xzDirection.y;
  }
  if (left) {
    lx = lx - strafeDir.x;
    lz = lz - strafeDir.y;
  }
  if (right) { 
    lx = lx + strafeDir.x;
    lz = lz + strafeDir.y;
  }

  //jumping
  if (ly>0) {
    ly=0; 
    vy=0;
  }// doesn't fall through ground
  if (space && ly<=15) {
    vy=20;
    space=false;
  }
  ly-=vy;
  if(ly<0) vy--;

  //direction.rotate(-(pmouseX - mouseX) * 0.01);

  drawMap();
  drawFloor();  

  drawBullets();

  drawSnow();
  
  drawFireworksUp();
  
  drawFireworksXZ();
}

void drawBullets() {
  int i = 0;
  while (i < bullets.size()) {
    Bullet b = bullets.get(i);
    b.act();
    b.show();
    i++;
  }
}

void drawSnow() {
  int i=0;
  while (i<snow.size()) {
    Snow s=snow.get(i);
    s.act();
    s.show();
    i++;
  }
}

void drawFireworksUp() {
  int i=0;
  while (i<fwkup.size()) {
    FireworksUp f1=fwkup.get(i);
    f1.act();
    f1.show();
    i++;
  }
}

void drawFireworksXZ() {
  int i=0;
  while (i<fwkxz.size()) {
    FireworksXZ f2=fwkxz.get(i);
    f2.act();
    f2.show();
    i++;
  }
}

void drawFloor() {
  int x = 0;
  int y = 0 + bs/2;
  stroke(100);
  strokeWeight(1);
  while (x < map.width*bs) {
    line(x, y, 0, x, y, map.height*bs);
    x = x + bs;
  }

  int z = 0;
  while (z < map.height*bs) {
    line(0, y, z, map.width*bs, y, z);
    z = z + bs;
  }

  noStroke();
}



void drawMap() {
  int mapX = 0, mapY = 0;
  int worldX = 0, worldZ = 0;

  while ( mapY < map.height ) {
    //read in a pixel
    color pixel = map.get(mapX, mapY);

    worldX = mapX * bs;
    worldZ = mapY * bs;

    if (pixel == black) {
      texturedBox(dT, dS, dB, worldX, 0, worldZ, bs/2);
    }


    mapX++;
    if (mapX > map.width) {
      mapX = 0; //go back to the start of the row
      mapY++;   //go down to the next row
    }
  }
}
