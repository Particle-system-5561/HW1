//Vector Library [2D]
//CSCI 5611 Vector 3 Library [Incomplete]

//Instructions: Add 3D versions of all of the 2D vector functions
//              Vec3 must also support the cross product.
public class Vec3 {
  public float x, y, z;
  
  public Vec3(float x, float y, float z){
    // ...
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  public String toString(){
    return "(" + x + ", " + y + ", " + z + ")";
  }
  
  public float length(){
    return sqrt(x*x + y*y + z*z);
  }
  
  public float lengthSqr(){
    return (x*x + y*y + z*z);
  }
  
  public Vec3 plus(Vec3 rhs){
    return new Vec3(x+rhs.x, y+rhs.y, z+rhs.z);
  }
  
  public void add(Vec3 rhs){
    // ...
    x += rhs.x;
    y += rhs.y;
    z += rhs.z;
  }
  
  public Vec3 minus(Vec3 rhs){
    return new Vec3(x-rhs.x, y-rhs.y, z-rhs.z);
  }
  
  public void subtract(Vec3 rhs){
    // ...
    x -= rhs.x;
    y -= rhs.y;
    z -= rhs.z;
  }
  
  public Vec3 times(float rhs){
    return new Vec3(x*rhs, y*rhs, z*rhs);
  }
  
  public void mul(float rhs){
    // ...
    x *= rhs;
    y *= rhs;
    z *= rhs;
  }
  
  public void normalize(){
    // ...
    float len = sqrt(x*x + y*y + z*z);
    x /= len;
    y /= len;
    z /= len;
  }
  
  public Vec3 normalized(){
    float len = sqrt(x*x + y*y + z*z);
    return new Vec3(x/len, y/len, z/len);
  }
  
  //If the vector is longer than maxL, shrink it to be maxL otherwise do nothing
  public void clampToLength(float maxL){
    // ...
    float len = sqrt(x*x + y*y + z*z);
    if(len > maxL){
      float temp = maxL/len;
      x *= temp;
      y *= temp;
      z *= temp;
    }
  }
  
  //Grow or shrink the vector have a length of maxL
  public void setToLength(float newL){
    // ...
    float temp = newL / (sqrt(x*x + y*y + z*z));
    x *= temp;
    y *= temp;
    z *= temp;
  }
  
  public float distanceTo(Vec3 rhs){
    float dx = x - rhs.x;
    float dy = y - rhs.y;
    float dz = z - rhs.z;
    return sqrt(dx*dx + dy*dy + dz*dz);
  }
}

Vec3 interpolate(Vec3 a, Vec3 b, float t){
  Vec3 n = (b.minus(a)).times(t);
  return a.plus(n);
}

float dot(Vec3 a, Vec3 b){
  return (a.x*b.x + a.y*b.y + a.z*b.z);
}

Vec3 cross(Vec3 a, Vec3 b){
  return new Vec3(a.y*b.z - a.z*b.y, a.z*b.x - a.x*b.z, a.x*b.y - a.y*b.x);
}

Vec3 projAB(Vec3 a, Vec3 b){
  return b.times(a.x*b.x + a.y*b.y + a.z*b.z);
}
