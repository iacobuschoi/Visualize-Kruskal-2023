ArrayList<kruskalEdge> kruskalEdgeArr = new ArrayList<kruskalEdge>();

class kruskalEdge{
  int s, e;
  int ind;
  int isSelected = 0;
  int isKruskal = 0;
  //생성 이팩트 관련 상수
  //감쇄 진동 미분 방정식 beta_2 = -a*(beta-1) - b*beta_1
  float a = 500;
  float b = 50;
  
  float beta_0 = 1;
  float beta = 0;
  float beta_1 = 0;
  float beta_2 = a;
  
  float ibeta_0 = 0;
  float ibeta = 0;
  float ibeta_1 = 0;
  float ibeta_2 = a;
  
  kruskalEdge(int s, int e, float ratio, int ind){
    this.s = s;
    this.e = e;
    this.beta_0 = ratio;
    this.ind = ind;
  }
  
  void update(){
    //생성 이팩트
    this.beta += dt*this.beta_1;
    this.beta_1 += dt*this.beta_2;
    this.beta_2 = -this.a*(this.beta-this.beta_0) -this.b*this.beta_1;
    
    this.ibeta_0 = this.isSelected;
    
    this.ibeta += dt*this.ibeta_1;
    this.ibeta_1 += dt*this.ibeta_2;
    this.ibeta_2 = -this.a*(this.ibeta-this.ibeta_0) -this.b*this.ibeta_1;
  }
  
  void show(){
    push();
    fill(255,255*(1-this.isSelected*(1-this.isKruskal)),255*(1-this.isSelected)*(1-this.isKruskal),150+100*max(this.isSelected,this.isKruskal));
    translate(700+width-900,200+this.ind*20+15,0);
    rect(150*(1-this.beta), 0 - this.ibeta*2, 150*this.beta, 10 + this.ibeta*4, 5);
    pop();
  }
}

void initKruskalEdge(){
  sortEdge();
  
  float maxDistance = edgeArr.get(0).distance;
  kruskalEdgeArr = new ArrayList<kruskalEdge>();
  
  int i = 0;
  for(Edge edge: edgeArr){
    kruskalEdgeArr.add(new kruskalEdge(edge.startInd, edge.endInd, edge.distance/maxDistance,i));
    i++;
  }
}

void updateKruskalEdge(){
  for(kruskalEdge edge : kruskalEdgeArr){
    edge.update();
    edge.show();
  }
}
