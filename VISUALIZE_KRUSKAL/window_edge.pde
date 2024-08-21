WindowInd windowInd = null;
int detecting = 0;
int lastDetecting = 0;
class WindowInd{
  //감쇄 진동 미분 방정식 beta_2 = -a*(beta-1) - b*beta_1
  float a = 500;
  float b = 50;
  float beta_0 = edgeCnt-1;
  float beta = edgeCnt-1;
  float beta_1 = 0;
  float beta_2 = a;
  
  float bbeta_0 = 0;
  float bbeta = 0;
  float bbeta_1 = 0;
  float bbeta_2 = a;
  
  float abeta_0 = 1;
  float abeta = 1;
  float abeta_1 = 0;
  float abeta_2 = 5;
  
  int ind=edgeCnt-1;
  int lastInd=edgeCnt-1;
  int cycleDetected = 0;
  
  WindowInd(){
    for(Edge edge : edgeArr){
      edge.window = 0;
    }
    for(kruskalEdge edge : kruskalEdgeArr){
      edge.isSelected = 0;
    }
    edgeArr.get(this.ind).window = 1;
    kruskalEdgeArr.get(this.ind).isSelected = 1;
  }
  
  void update(){  
    this.beta += dt*this.beta_1;
    this.beta_1 += dt*this.beta_2;
    this.beta_2 = -this.a*(this.beta-this.beta_0) -this.b*this.beta_1;
    
    this.bbeta_0 = kruskalNum;
    this.bbeta += dt*this.bbeta_1;
    this.bbeta_1 += dt*this.bbeta_2;
    this.bbeta_2 = -this.a*(this.bbeta-this.bbeta_0) -this.b*this.bbeta_1;
    
    this.abeta = min(this.abeta_0,this.abeta+dt*this.abeta_1);
    this.abeta_1 += dt*this.abeta_2;
    
    this.updateWindowEdge();
  }
  
  void show(){
    push();
    //INFO
    translate(685+width-900-200,200);
    textSize(25);
    fill(255,200);
    text("INFO",95-textWidth("INFO")/2,-10);
    fill(255,50);
    rect(0, 0, 190, 135, 10,10,10,30);
    
    textSize(18);
    fill(255,220);
    textAlign(LEFT, CENTER);
    text("SELECTED EDGE",40,44);
    text("CURRENT EDGE",40,19);
    fill(255,0,0,200);
    rect(15,15,15,15,2);
    fill(255,255,0,200);
    rect(15,40,15,15,2);
    pop();
    push();
    translate(685+width-900-200,200);
    translate(15,80);
    int d = 3;
    fill(255,100);
    rect(-d,- d, 160+2*d, 10 + 2*d, 5);
    fill(255,255*(1-this.cycleDetected),255*(1-this.cycleDetected),200);
    rect(0, 0, 160*this.abeta, 10, 5);
    textSize(20);
    if(this.abeta<0.99){
      fill(255,200);
      text(String.format("DETECTING CYCLE %.0f",this.abeta*100),80-textWidth(String.format("DETECTING CYCLE %.0f",this.abeta*100))/2,35);
      lastDetecting = detecting;
      detecting = 1;
    }
    else{
      lastDetecting = detecting;
      detecting = 0;
      
      if(detecting!=lastDetecting){
        kruskal.findCycle();
      }
      if(this.cycleDetected == 0){
        fill(255,200);
        text("NO CYCLE",80-textWidth("NO CYCLE")/2,35);
      }
      else{
        fill(255,0,0,200);
        text("CYCLE DETECTED",80-textWidth("CYCLE DETECTED")/2+random(-3,3),35+random(-3,3));
      }
    }
    pop();
    
    push();
    translate(685+width-900,200);
    textSize(25);
    fill(255,200);
    text("EDGE VALUES",95-textWidth("EDGE VALUES")/2,-10);
    fill(255,50);
    rect(0, 0, 190, 20+20*edgeCnt, 10,10,10,30);
    
    translate(0,60+20*edgeCnt);
    fill(255,200);
    text("KRUSKAL",95-textWidth("KRUSKAL")/2,-10);
    fill(255,50);
    rect(0, 0, 190, 60, 10,10,10,30);
    pop();
    push();
    translate(700+width-900,275+20*edgeCnt);
    d = 3;
    fill(255,100);
    rect(-d,- d, 160+2*d, 10 + 2*d, 5);
    fill(255,200);
    rect(0, 0, 160*this.bbeta/(nodeCnt-1), 10, 5);
    textSize(20);
    if(kruskalNum!=nodeCnt-1){
      text(String.format("%d/%d",kruskalNum,(nodeCnt-1)),80-textWidth(String.format("%d/%d",kruskalNum,(nodeCnt-1)))/2,35);
    }
    else{
      text("FINISHED",80-textWidth("FINISHED")/2,35);
    }
    pop();
    
    push();
    fill(255,200);
    translate(855+width-900,200+this.beta*20+15);
    beginShape();
    vertex(0,5);
    vertex(10,0);
    vertex(10,10);
    endShape();
    pop();
    
  }
  
  void updateWindowEdge(){
    if (this.lastInd!=this.ind){
      edgeArr.get(this.lastInd).window = 0;
      edgeArr.get(this.ind).window = 1;
      
      kruskalEdgeArr.get(this.lastInd).isSelected = 0;
      kruskalEdgeArr.get(this.ind).isSelected = 1;
      
      this.lastInd = this.ind;
      this.beta_0 = ind;
    }
  }
}
