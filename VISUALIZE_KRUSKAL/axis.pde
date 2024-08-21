class Axis{
  float[] s,e;
  float radius;
  int r,g,b;
  float[] cs;
  
  Axis(float[] s, float[] e, float radius, int r, int g, int b){
    this.s = s;
    this.e = e;
    this.r = r;
    this.g = g;
    this.b = b;
    this.radius = radius;
    this.cs = addV(s,e,1.2);
  }
  
  void show(){
    push();
    fill(this.r, this.g, this.b);
    drawCylinder(this.s[0],this.s[1],this.s[2],this.e[0],this.e[1],this.e[2],this.radius);
    drawCorn(this.e[0],this.e[1],this.e[2],this.cs[0],this.cs[1],this.cs[2],2*this.radius);
    pop();
  }
}

float[] addV(float[] s, float[] e, float t){
  return new float[] {s[0]*(1-t)+e[0]*t,s[1]*(1-t)+e[1]*t,s[2]*(1-t)+e[2]*t};
}
    
