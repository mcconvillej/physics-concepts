PImage img;
int counter = 0;
int origin;
float pgain;
float igain;
float hdiff;
float deflection;
float pcorrection;
float icorrection;
float mx;
float my;
int[] steps;
float x_setpoint;
float y_setpoint;
int step;
int dir = 1;
Slider prop;
Slider integ;
Slider hite;

void setup() {
  //size(600,200,P2D);
  fullScreen();
  origin = int(width - 1);
  img = createImage(width, height, RGB);
  stroke(255);
  fill(255);
  x_setpoint = width/5;
  y_setpoint = 4*height/5;
  deflection = y_setpoint + random(-10,10);
  step = height-2;
  steps = new int[int(width - x_setpoint)];
  for (int i = 0; i < steps.length; i++) {
    steps[i] = int(y_setpoint);
  }
  pgain = 0.5;
  igain = 0.1;
  prop = new Slider(1,"PGain", -0.1, 1.0);
  integ = new Slider(2, "IGain", -0.1, 1.0);
  hite = new Slider(3, "Height", 0.0, 2*height/3);
}
void draw() {
  int y_mount = step;
  img.loadPixels();
  float pflip = random(0,1);
  if (0.02 > pflip) {
    dir*=-1;
  }
  if ((dir == 1) || (step < height*1/3)) {
    img.pixels[width-1 + (step*width)] = color(0);
    //step++;
    dir = 1;
    step+=int(pflip*2);
  }
  if ((dir == -1) || (step > height*2/3)) {
    img.pixels[width-1 + (step*width)] = color(map(step,height/3,height,255,155));
    //step--;
    step-=int(pflip*2);
    dir = -1;
  }
  steps[counter%(steps.length-1)] = y_mount;
  y_setpoint = steps[(counter+1)%(steps.length-1)] - hdiff;
  counter++;
  for (int j=1; j < height; j++) {
    img.pixels[width-2+(j*width)] = img.pixels[width-1 + j*width];
  }
  for (int i = 0; i < width -2; i++) {
    for (int j=1; j< height; j++) {
      img.pixels[i+j*width] = img.pixels[(i+1) + j*width];
    }
  } 
  img.updatePixels();
  image(img,0,0);
  //rect(0,0,width,height);
  stroke(255);
  line(0,y_setpoint,width,y_setpoint);
  deflection += PID(deflection, y_setpoint);
  ellipse(x_setpoint,deflection,height/20,height/20);
  prop.display();
  integ.display();
  hite.display();
  pgain = prop.update();
  igain = integ.update();
  hdiff = hite.update();
}

float PID(float d, float s) {
  float delta = s - d + random(-5,5);
  pcorrection = pgain*delta;
  icorrection += igain*delta;
  return pcorrection + icorrection;
}
