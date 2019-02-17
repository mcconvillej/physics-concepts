class Slider {
  float xLocation;
  float yLocation = height/10;
  float yButton;
  float rectSize = 5;
  String parameter;
  float value;
  float lo;
  float hi;
  Slider(float snum, String name, float lower, float upper) {
    xLocation = width*(1 - snum/8);
    yLocation = height/10;
    yButton = yLocation;
    parameter = name;
    value = 0;
    lo = lower;
    hi = upper;
  }
  void display() {
    stroke(255);
    line(xLocation,yLocation*1.5, xLocation,yLocation*0.5 );
    rectMode(CENTER);
    fill(255);
    stroke(255);
    rect(xLocation,yButton,rectSize,rectSize);
    text(parameter,xLocation-15, yLocation*2);
  }
  
  float update() {
    if ((xLocation*0.9 < mouseX) && (mouseX < xLocation*1.1) && (yLocation*0.5 < mouseY) && (mouseY < yLocation*1.5)) {
      yButton = constrain(mouseY, yLocation*0.5, yLocation*1.5);
      value = map(yButton, yLocation*1.5, yLocation*0.5, lo, hi);
    }
    return value;
  }
}
      
    
