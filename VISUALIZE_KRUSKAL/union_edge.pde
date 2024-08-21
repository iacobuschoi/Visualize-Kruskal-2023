class UnionEdge{
  int startInd,endInd;
  float sx,sy,sz,ex,ey,ez;
  float distance;
  
  ////생성 이팩트 관련 상수
  ////감쇄 진동 미분 방정식 beta_2 = -a*(beta-1) - b*beta_1
  //float a = 500;
  //float b = 50;
  //float beta_0 = 1;
  float beta = 0;
  //float beta_1 = 0;
  //float beta_2 = a;
  
  UnionEdge(Node startNode, Node endNode){
    this.startInd = startNode.ind;
    this.endInd = endNode.ind;
    this.sx = startNode.x;
    this.sy = startNode.y;
    this.sz = startNode.z;
    this.ex = endNode.x;
    this.ey = endNode.y;
    this.ez = endNode.z;
    this.distance = pow(pow(sx-ex,2)+pow(sy-ey,2)+pow(sz-ez,2),0.5);
  }
  
  void update(float beta_0){
    //생성 이팩트
    this.beta = beta_0;
  }
  
  void show(){
    push();
    fill(0,0,255,100);
    drawCylinder(this.sx,this.sy,this.sz,this.sx+(this.ex-this.sx)*this.beta,this.sy+(this.ey-this.sy)*this.beta,this.sz+(this.ez-this.sz)*this.beta,10);
    if(beta>0.95){
      push();
      translate(ex,ey,ez);
      sphere(nodeArr.get(indNode(endInd)).size*nodeArr.get(indNode(endInd)).beta*1.1);
      pop();
    }
    pop();
  }
}

class UnionEdgeArr{
  float a = 500;
  float b = 50;
  float beta_0 = 1;
  float beta = 0;
  float beta_1 = 0;
  float beta_2 = a;
  ArrayList<UnionEdge> unionEdgeArr;
  
  UnionEdgeArr(ArrayList<UnionEdge> unionEdgeArr){
    this.unionEdgeArr = unionEdgeArr;
  }
  
  void update(){
    this.beta += dt*this.beta_1;
    this.beta_1 += dt*this.beta_2;
    this.beta_2 = -this.a*(this.beta-this.beta_0) -this.b*this.beta_1;
    
    int i = 0;
    for(UnionEdge edge: this.unionEdgeArr){
      edge.update(min(1,max(0,this.beta*this.unionEdgeArr.size()-i)));
      i++;
    }
  }
  
  void show(){
    for(UnionEdge edge: this.unionEdgeArr){
      edge.show();
    }
  }
}
