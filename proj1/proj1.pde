// CSCI 5611 project 1
//Zihe Fan <fanxx478@umn.edu>
//add name here <>

static int numBoids = 1000;

// initial pos, vel and acc.
Vec3 pos[] = new Vec3[numBoids];
Vec3 vel[] = new Vec3[numBoids];
Vec3 acc[] = new Vec3[numBoids];

float maxSpeed = 20;
float normalSpeed = 10;
float radius = 6;
float dt = 0.1;
float maxForce = 10;
long starttime, endtime;

void setup(){
  size(1200, 1200, P3D);
  
  for(int i = 0; i<numBoids; i++){
    pos[i] = new Vec3(300+random(600), 300+random(600), 300+random(600));
    vel[i] = new Vec3(-1+random(2), -1+random(2), -1+random(2));
    vel[i].normalize();
    vel[i].mul(normalSpeed);
  }
  
  starttime = System.currentTimeMillis();
}

// this version is from sample and it is not using 3 closest point
void updateStatus(){
  for(int i = 0; i<numBoids; i++){
    acc[i] = new Vec3(0, 0, 0);
    Vec3 avgPos = new Vec3(0, 0, 0);
    int countP = 0;
    Vec3 avgVel = new Vec3(0, 0, 0);
    int countA = 0;
    
    for(int j = 0; j < numBoids; j++){
      float dist = pos[i].distanceTo(pos[j]);
      
      // Seperation
      if (dist > .01 && dist < 50){
        Vec3 seperationForce =  pos[i].minus(pos[j]).normalized();
        seperationForce.setToLength(200.0/pow(dist,2));
        acc[i] = acc[i].plus(seperationForce);
      }
      
      // Cohesion
      if (dist < 60 && dist > 0){
        avgPos.add(pos[j]);
        countP += 1;
      }
      
      // Alignment
      if (dist < 40 && dist > 0){
        avgVel.add(vel[j]);
        countA += 1;
      } 
    }
    
    avgPos.mul(1.0/countP);
    if (countP >= 1){
      Vec3 attractionForce = avgPos.minus(pos[i]);
      attractionForce.normalize();
      attractionForce.times(4); // why need?
      attractionForce.clampToLength(maxForce);
      acc[i] = acc[i].plus(attractionForce);
    }
    
    avgVel.mul(1.0/countA);
    if (countA >= 1){
      Vec3 towards = avgVel.minus(vel[i]);
      towards.normalize();
      acc[i] = acc[i].plus(towards.times(2));
    }
    
    //Goal Speed
    Vec3 targetVel = vel[i];
    targetVel.setToLength(normalSpeed);
    Vec3 goalSpeedForce = targetVel.minus(vel[i]);
    goalSpeedForce.times(1); // why need?
    goalSpeedForce.clampToLength(maxForce);
    acc[i] = acc[i].plus(goalSpeedForce);    
    
    //Wander force
    Vec3 randVec = new Vec3(1-random(2), 1-random(2), 1-random(2));
    acc[i] = acc[i].plus(randVec.times(10.0));     
  }
  
  // deal with each point
  for (int i = 0; i < numBoids; i++){
      
    //Update Position & Velocity
    pos[i] = pos[i].plus(vel[i].times(dt));
    vel[i] = vel[i].plus(acc[i].times(dt));
    //println(vel[i].x,vel[i].y);
    
    //Max speed
    if (vel[i].length() > maxSpeed){
      vel[i] = vel[i].normalized().times(maxSpeed);
    }
    
    // Loop the world if agents fall off the edge.
    // need more on z !!!!!!!!!!!!!!!!!!!
    if (pos[i].x < 0) pos[i].x += width;
    if (pos[i].x > width) pos[i].x -= width;
    if (pos[i].y < 0) pos[i].y += height;
    if (pos[i].y > height) pos[i].y -= height;
  }
}

void draw(){
  background(255); //Grey background
  stroke(0,0,0);
  
  endtime = System.currentTimeMillis();
  if (frameCount > 200){println(frameCount / ((endtime-starttime)/1000));}
  
  fill(10,120,10);
  for (int i = 0; i < numBoids; i++){
    // how to draw that????????
    circle(pos[i].x, pos[i].y, pos[i].z, radius*2); 
  }
  
  updateStatus();
}
