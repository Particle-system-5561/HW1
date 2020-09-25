// CSCI 5611 Project 1 Particle  System  Simulation
// Zihe Fan

static int maxNumParticles = 300;
boolean paused = true;
Vec3 g = new Vec3(0, 400, 0);
float r = 20;
float genRate = 60;
float maxV = 600;
float COR = 0.2;
float maxLifeTime = 4;

Vec3 pos[] = new Vec3[maxNumParticles];
Vec3 vel[] = new Vec3[maxNumParticles];
float life[] = new float[maxNumParticles];
int numParticles = 0;

PImage img;
PImage img1;
PFont font;

void setup(){
  size(960, 960, P3D);
  surface.setTitle("Particle System Simulation");
  strokeWeight(2); //Draw thicker lines 
  img = loadImage("water.jpg");
  img1 = loadImage("tree.jpg");
  font = createFont("Times New Roman", 48);

}

void update(float dt){
  // generate new particles
  float toGen_float = genRate * dt;
  int toGen = int(toGen_float);
  float fractPart = toGen_float - toGen;
  if (random(1) < fractPart) toGen += 1;
  for (int i = 0; i < toGen; i++){
    if (numParticles >= maxNumParticles) break;
    
    float angle = 2 * PI * random(1);
    pos[numParticles] = new Vec3(width/2, random(height-6-r, height-r), -width/2);
    //vel[numParticles] = new Vec3(maxV*sin(angle), 5*random(-maxV, -maxV+30), maxV*cos(angle)); 
    vel[numParticles] = new Vec3(maxV*sin(angle), -5*maxV, maxV*cos(angle)); 
    vel[numParticles].setToLength(random(maxV-30, maxV));
    life[numParticles] = maxLifeTime;
    numParticles += 1;
  }
  
  // check old particles and generate new
  for (int i = 0; i < numParticles; i++){
    if (life[i] <= 0){
      float angle = 2 * PI * random(1);
      pos[i] = new Vec3(width/2, random(height-6-r, height-r), -width/2);
      //vel[i] = new Vec3(maxV*sin(angle), 5*random(-maxV, -maxV+30), maxV*cos(angle));
      vel[i] = new Vec3(maxV*sin(angle), -5*maxV, maxV*cos(angle)); 
      vel[i].setToLength(random(maxV-30, maxV));  
      life[i] = maxLifeTime;
    }
    
    else{
      // update statues
      pos[i].add(vel[i].times(dt)); //Update position based on velocity
      vel[i].add(g.times(dt));
      life[i] -= dt;
      
      if (pos[i].y > height - r){
        pos[i].y = height - r;
        vel[i].y *= -COR;
      }
      if (pos[i].y < r){
        pos[i].y = r;
        vel[i].y *= -COR;
      }
      if (pos[i].x > width - r){
        pos[i].x = width - r;
        vel[i].x *= -COR;
      }
      if (pos[i].x < r){
        pos[i].x = r;
        vel[i].x *= -COR;
      }
    }
  }
  
}

void keyPressed(){
  if (key == ' ') paused = !paused;
}

boolean camaraMove;
void mousePressed() {
  if (mouseButton == LEFT) {
    camaraMove = true;
  }
}
void mouseReleased() {
  if (mouseButton == LEFT) {
    camaraMove = false;
  }
}

void drawPicture(){
  // water
  pushMatrix();
  translate(width/2, 0, -width/2);
  //PImage img=loadImage("water.jpg");
  beginShape();
  texture(img);
  vertex(-width/2,height,-width/2,0,0);
  vertex(width/2,height,-width/2,img.width,0);
  vertex(width/2,height,width/2,img.width,img.height);
  vertex(-width/2,height,width/2,0,img.height);
  endShape();
  
  //tree
  translate(-width/2, height/2, 0);
  //PImage img1=loadImage("tree.jpg");
  beginShape();
  texture(img1);
  vertex(0,-height/2,-width/2,0,0);
  vertex(0,height/2,-width/2,0,img1.height);
  vertex(0,height/2,width/2,img1.height,img1.width);
  vertex(0,-height/2,width/2,img1.width,0);
  endShape();
  
  //tree2
  translate(width, 0, 0);
  //PImage img2=loadImage("tree.jpg");
  beginShape();
  texture(img1);
  vertex(0,-height/2,-width/2,0,0);
  vertex(0,height/2,-width/2,0,img1.height);
  vertex(0,height/2,width/2,img1.height,img1.width);
  vertex(0,-height/2,width/2,img1.width,0);
  endShape();
  
  //tree3
  translate(-width/2, 0, -width/2);
  //PImage img3=loadImage("tree.jpg");
  beginShape();
  texture(img1);
  vertex(-width/2,-height/2,0,0,0);
  vertex(width/2,-height/2,0,img1.width,0);
  vertex(width/2,height/2,0,img1.width,img1.height);
  vertex(-width/2,height/2,0,0,img1.height);
  endShape();
  popMatrix();
}

void draw(){
  if (!paused) update(1.0/frameRate);
  //update(1.0/frameRate);
  background(#87CEEB);
  //background(255);
  drawPicture();
  textFont(font, int(width*0.08));
  fill(0);
  text("Frame rate:" + int(frameRate), 0, 0, -width);
  
  if (camaraMove){
    camera(mouseX, mouseY, width, // eyeX, eyeY, eyeZ
           width/2, height-500-r, -width/2,  // centerX, centerY, centerZ
           0.0, 1.0, 0.0); // upX, upY, upZ
  }
  else{
    camera(width/2, height-500-r, width, // eyeX, eyeY, eyeZ
           width/2, height-500-r, -width/2,  // centerX, centerY, centerZ
           0.0, 1.0, 0.0); // upX, upY, upZ
  }
  
  noStroke();
  for (int i = 0; i < numParticles; i++){
    pushMatrix();
    translate(pos[i].x, pos[i].y, pos[i].z);
    
    fill(127*life[i]/maxLifeTime,255*life[i]/maxLifeTime,212*life[i]/maxLifeTime);
        //fill(255-128*life[i]/maxLifeTime,255-1*life[i]/maxLifeTime,255-44*life[i]/maxLifeTime);
    //stroke(0,0,255*life[i]/maxLifeTime);
    //strokeWeight(30*life[i]/maxLifeTime);
    sphere(r);
    popMatrix();
  }
  
  //lights();
  
  println(frameRate);
}
