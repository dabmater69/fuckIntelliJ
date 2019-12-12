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
boolean rightPressed = false;
boolean downPressed = false;

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
      
      
  if(upPressed == true) angleX -= 0.01;
    
  if(leftPressed == true) angleY += 0.01;    
  
  if(rightPressed == true) angleY -= 0.01;
    
  if(downPressed == true) angleX += 0.01;  
  
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
    
    float h = pow(10, 6);
    float maxh = pow(10, 7);
    h = map(h, 0, maxh, 10, 100);
    PVector xaxis = new PVector(1, 0, 0);
    float angleb = PVector.angleBetween(xaxis, pos);
    PVector raxis = xaxis.cross(pos);
    
    if(textfield1.getText().equals(row.getString(0))){
    pushMatrix();
    translate(x, y, z);
    rotate(angleb, raxis.x, raxis.y, raxis.z);
    fill(255,0,0);
    box(h, 4, 4);
    popMatrix();
    }
   
  } 
  fill(255);
  
}

public void customGUI(){
  
}
