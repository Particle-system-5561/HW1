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
    return "(" + this.x + ", " + this.y+ ", " + this.z + ")";
  }
  
  public float length(){
    return sqrt(lengthSqr());
  }
  
  public float lengthSqr(){
    return x * x + y * y + z * z;
  }
  
  public Vec3 plus(Vec3 rhs){
    return new Vec3(x + rhs.x, y + rhs.y, z + rhs.z);
  }
  
  public void add(Vec3 rhs){
    // ...
    this.x += rhs.x;
    this.y += rhs.y;
    this.z += rhs.z;
  }
  
  public Vec3 minus(Vec3 rhs){
    return new Vec3(this.x - rhs.x, this.y - rhs.y, this.z - rhs.z);
  }
  
  public void subtract(Vec3 rhs){
    // ...
    this.x -= rhs.x;
    this.y -= rhs.y;
    this.z -= rhs.z;
  }
  
  public Vec3 times(float rhs){
    return new Vec3(this.x * rhs, this.y * rhs, this.z * rhs);
  }
  
  public void mul(float rhs){
    // ...
    this.x *= rhs;
    this.y *= rhs;
    this.z *= rhs;
  }
  
  public void normalize(){
    // ...
    float root = length();
    x /= root;
    y /= root;
    z /= root;
  }
  
  public Vec3 normalized(){
    float root = length();
    return new Vec3(x/root,y/root,z/root);
  }
  
  //If the vector is longer than maxL, shrink it to be maxL otherwise do nothing
  public void clampToLength(float maxL){
    // ...
    float root = length();
    if(root <= maxL)
      return;
    root /= maxL;
    x /= root;
    y /= root;
    z /= root;
  }
  
  //Grow or shrink the vector have a length of maxL
  public void setToLength(float newL){
    // ...
    float root = length();
    if(root == newL)
      return;
    root /= newL;
    x /= root;
    y /= root;
    z /= root;
  }
  
  public float distanceTo(Vec3 rhs){
    return sqrt(pow(this.x - rhs.x, 2) + pow(this.y - rhs.y, 2) + pow(this. z - rhs.z, 2));
  }
}

Vec3 interpolate(Vec3 a, Vec3 b, float t){
  return new Vec3(a.x + (b.x-a.x)*t, a.y + (b.y-a.y)*t, a.z + (b.z - a.z)*t); 
}

float dot(Vec3 a, Vec3 b){
  return a.x *b.x + a.y * b.y + a.z * b.z;
}

Vec3 cross(Vec3 a, Vec3 b){
  return new Vec3(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x);
}

Vec3 projAB(Vec3 a, Vec3 b){
  // b.normalize();
  float prop = dot(a, b);
  if(prop == 0)
    return new Vec3(0.0, 0.0, 0.0);
  return new Vec3(b.x * prop, b.y * prop, b.z * prop);
}
