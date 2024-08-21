class Origin{
  float x,y,z;
  float size;
  float axisR = 3;
  float axisD;
  float axisLength;
  Axis X,Y,Z;
  //Axis X = new Axis(new float[] {-size/2,-size/2,-size/2},new float[] {1.2*size/2,-size/2,-size/2},5,255,0,0);
  //Axis X = new Axis(new float[] {-size/2,-size/2,-size/2},new float[] {1.2*size/2,-size/2,-size/2},5,255,0,0);
  Origin(float x, float y, float z, float size){
    this.x = x;
    this.y = y;
    this.z = z;
    this.size = size;
    this.axisD = this.size/2 + this.axisR*1.5;
    this.axisLength = this.size * 1.3;
    this.X = new Axis(new float[] {-this.axisD,this.axisD,-this.axisD},new float[] {-this.axisD,this.axisD,-this.axisD+this.axisLength},this.axisR,255,0,0);
    this.Y = new Axis(new float[] {-this.axisD,this.axisD,-this.axisD},new float[] {-this.axisD+this.axisLength,this.axisD,-this.axisD},this.axisR,0,0,255);
    this.Z = new Axis(new float[] {-this.axisD,this.axisD,-this.axisD},new float[] {-this.axisD,this.axisD-this.axisLength,-this.axisD},this.axisR,0,255,0);
  }
  
  void show(){
    ortho();
    push();
    
    translate(x,y,z);
    rotateX(RX);
    rotateY(RY);
    
    strokeWeight(5);
    stroke(150);
    fill(200,200);
    box(size);
    
    noStroke();
    this.X.show();
    this.Y.show();
    this.Z.show();
    
    pop();
    perspective();
  }
}
