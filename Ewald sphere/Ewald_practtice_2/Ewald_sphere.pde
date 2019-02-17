float x,y,z;
ArrayList<Lpoints> lattice;
PShape Lpoint;
int points = 5;
float spi = 30;
float spj = 30;
float spk = 30;
int ptsi = 5;
int ptsj = 5;
int ptsk = 5;
float Erad = 50;
int mY;
float Eangle = QUARTER_PI;
PVector Eloc;
PVector Epoint;
PVector Elocpoint;
int counter = 0;
float screend = 400;
float mx;
float my;
void setup() {
  fullScreen(P3D,1);
  Eloc = new PVector(0,0,0);
  background(0);
  ortho(-width/2, width/2, -height/2, height/2);
  translate(width/2, height/2, 0);
  //rotateY(map(mouseX, 0, width, -PI, PI));
  //rotateX(map(mouseY, 0, height, -HALF_PI, HALF_PI));
  noStroke();
  Lpoint = createShape(SPHERE,3);
  lattice = new ArrayList<Lpoints>();
  for ( int i = -ptsi; i <= ptsi; i++) {
    for ( int j = -ptsj; j <= ptsj; j++) {
      for ( int k = -ptsk; k <= ptsk; k++) {
        Lpoints p = new Lpoints(i*spi, j*spj, k*spk);
        lattice.add(p);
      }
    }
  }
  fill(100,20);
  box(ptsi*spi, ptsj*spj, ptsk*spk);
  x = 0;
  y = height/2;
  z = 0;
  //noLoop();
  rotateX(-0.6);
  Epoint = new PVector(0,0,0);
  mx = width*(1 - 1.1/6);
  my = 0.1*width/6;
  textSize(24);
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2, 1.2*height/2, 0);
  rotateX(0.86);
  rotateZ(PI/3);
  pushMatrix();
  translate(-screend,0,0);
  fill(255);
  box(1,screend*2,screend*2);
  fill(0);
  sphere(10);
  popMatrix();
  //rotateY(map(mouseX, 0, width, -PI, PI));
  if (mousePressed) {
    Erad = map(mx, width*(1 - 1.1/6), width*(1 - 0.1/6), 1, 400);
    Eangle = map(my,0.1*width/6, 1.1*width/6, -QUARTER_PI, QUARTER_PI);
    Eloc.set(Erad*cos(Eangle),Erad*sin(Eangle),0);
    Elocpoint = Eloc.copy();
    Elocpoint.mult(-screend/Elocpoint.x);
    pushMatrix();
    translate(Elocpoint.x, Elocpoint.y, Elocpoint.z);
    fill(200);
    sphere(10);
    popMatrix();   
  }
  else{
    mY = mouseY;
  }
  //pushMatrix();
  //translate(Eloc.x, Eloc.y, 0);
  //fill(255,100);
  //lights();
  //sphere(Erad);
  //popMatrix();
  //rotateZ(-PI/6);//map(mY, 0, height, -PI, PI));
  noStroke();
  for (Lpoints lpts : lattice) {
    lpts.display();
    Lpoint.setFill(color(0));
    Epoint.set(lpts.x,lpts.y,lpts.z);
    Epoint.sub(Eloc);
    float Emag = Epoint.mag();
    if ((Emag > Erad - 5) & (Emag < Erad + 5)) {
      //Epoint.add(Eloc);
      if (-Epoint.x > 1.0){
        Epoint.mult(-screend/Epoint.x);
        fill(map(Emag, 0.0, Erad, 255, 0));
        pushMatrix();
        translate(Epoint.x, Epoint.y, Epoint.z);
        shape(Lpoint);
        popMatrix();
      }
    } 
  }
  //for (int i = -ptsi ; i < ptsi; i++) {
  //  for (int j= -ptsj; j < ptsj; j++) {
  //    for (int k= -ptsk; k < ptsk; k++) {
  //      Epoint.set(spi*i,spj*j,spk*k);
  //      Epoint.sub(Eloc);
  //      float Emag = Epoint.mag();
  //      if ((Emag > Erad - 14) & (Emag < Erad + 14)) {
  //        //Epoint.add(Eloc);
  //        if (-Epoint.x > 1.0){
  //          Epoint.mult(-screend/Epoint.x);
  //          fill(map(Emag, 0.0, Erad, 255, 0));
  //          pushMatrix();
  //          translate(Epoint.x, Epoint.y, Epoint.z);
  //          shape(Lpoint);
  //          popMatrix();
  //        }
  //      }        
  //    }
  //  }
  //}
  fill(200);
  //pushMatrix();
  //translate(0.8*(points-1)*sp/2, (points-1)*sp/2,  (points-2)*sp/4);
  //box(2*ptsi*spi, 2*ptsj*spj, 2*ptsk*spk);
  box(5,5,3*ptsk*spk);
  pushMatrix();
  translate(Eloc.x, Eloc.y, 0);
  fill(255);
  lights();
  sphere(Erad);
  popMatrix();
  popMatrix();
  fill(200);
  rect(width - 1.1*width/6, 0.1*width/6, width/6, width/6);
  mx = constrain(mouseX,width*(1 - 1.1/6), width*(1 - 0.1/6));
  my = constrain(mouseY,0.1*width/6, 1.1*width/6);
  fill(255,0,0);
  ellipse(mx,my,20,20);
  fill(255);
  text("Radius",width - 1.1*width/6, 1.2*width/6);
  translate(width - 1.2*width/6, 1.1*width/6);
  rotate(-HALF_PI);
  text("Angle",0,0);
}


//alt
//  for (int i = 0 ; i < points; i++) {
//    for (int j=0; j<points;j++) {
//      for (int k=0; k<points/2; k++) {
//        pushMatrix();
//        translate(sp*(k*0.3 - 2*i), sp*(j+0.3*k));
//        fill((i)*50);
//        sphere(3); 
//        popMatrix();
        
//      }
//    }
//  }
