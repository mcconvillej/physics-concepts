class Lpoints {
  PShape s;
  float x, y, z;
  float fvalue;
  
  Lpoints(float xpos, float ypos, float zpos) {
    s = Lpoint;
    //fvalue = map(z,-ptsk,ptsk,0,255);
    //s.setFill(color(fvalue));
    x = xpos;
    y = ypos;
    z = zpos;
  }
  
  void display() {
    pushMatrix();
    fvalue = map(y,-ptsj*spj,ptsj*spj,0,255);
    s.setFill(color(fvalue));
    translate(x, y, z);
    shape(s);
    popMatrix();
  }
}
