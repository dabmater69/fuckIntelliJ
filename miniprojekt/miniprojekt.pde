import g4p_controls.*;

float angleX;
float angleY;

float kordX;
float kordY;

Table table;
float r = 200;

PImage earth;
PShape globe;

boolean upPressed = false;
boolean leftPressed = false;


void setup() {
  size(600, 600, P3D);
  earth = loadImage("earth.jpg");
  table = loadTable("worldcities.csv");

  createGUI();
  customGUI();


  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
}

void draw() {
  background(51);
  translate(width*0.5, height*0.5);
  rotateX(angleX);
  rotateY(angleY);  
      
      
  if(upPressed == true) angleX -= 0.025;
    
  if(leftPressed == true) angleY += 0.025;    
  
  upPressed = false;
  
  leftPressed = false;
  
  
  lights();
  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);

  for (TableRow row : table.rows()) {
    
    
    float lat = row.getFloat(2);
    float lon = row.getFloat(3);

    float theta = radians(lat);

    float phi = radians(lon) + PI;

    float x = r * cos(theta) * cos(phi);
    float y = -r * sin(theta);
    float z = -r * cos(theta) * sin(phi);
    
    PVector pos = new PVector(x, y, z);
    
    float h = pow(10, 2);
    float maxh = pow(10, 7);
    h = map(h, 0, maxh, 10, 100);
    PVector xaxis = new PVector(1, 0, 0);
    float angleb = PVector.angleBetween(xaxis, pos);
    PVector raxis = xaxis.cross(pos);
  
    
    
    
    
    if(textfield1.getText().equals(row.getString(0))){
    pushMatrix();
    translate(x, y, z);
    rotate(angleb, raxis.x, raxis.y, raxis.z);
    println(row.getFloat(2));
    println(row.getFloat(3));    
    fill(255,0,0);
    box(h, 5, 5);
    popMatrix();
    }
    fill(255);
    
    
  } 
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      angleX += 0.005;
    } else if (keyCode == DOWN) {
      angleX -= 0.005;
    } 
  }
    if (keyCode == RIGHT) {
      angleY += 0.005;
    } else if (keyCode == LEFT) {
      angleY -= 0.005;
    } 
  
}

public void customGUI(){
  
}
