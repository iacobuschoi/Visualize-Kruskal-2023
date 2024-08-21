ArrayList<Edge> edgeArr = new ArrayList<Edge>();
int edgeCnt = 0;

class Edge{
  int startInd,endInd;
  float sx,sy,sz,ex,ey,ez;
  float distance;
  int window;
  int kruskal = 0;
  int inv = 0;
  
  //생성 이팩트 관련 상수
  //감쇄 진동 미분 방정식 beta_2 = -a*(beta-1) - b*beta_1
  float a = 500;
  float b = 50;
  float beta_0 = 1;
  float beta = 0;
  float beta_1 = 0;
  float beta_2 = a;
  
  Edge(Node startNode, Node endNode){
    edgeCnt ++;
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
  
  void update(){
    //생성 이팩트
    this.beta += dt*this.beta_1;
    this.beta_1 += dt*this.beta_2;
    this.beta_2 = -this.a*(this.beta-this.beta_0) -this.b*this.beta_1;
    
    //노드 양단 좌표 초기화
    for(Node node:nodeArr)
    {
      if(node.ind == this.startInd)
      {
        this.sx = node.x;
        this.sy = node.y;
        this.sz = node.z;
      }
      else if(node.ind == this.endInd)
      {
        this.ex = node.x;
        this.ey = node.y;
        this.ez = node.z;
      }
    }
  }
  
  void show(){
    push();
    fill(255,255,255-255*max(this.window,this.kruskal),255-200*this.inv*(1-this.kruskal)); //(200*this.window*(1+sin(frame/fps*PI))*0.5)*finish
    if(this.window==1&&this.kruskal!=1){
      fill(255,0,0);
    }
    drawCylinder(this.sx,this.sy,this.sz,this.sx+(this.ex-this.sx)*this.beta,this.sy+(this.ey-this.sy)*this.beta,this.sz+(this.ez-this.sz)*this.beta,8);
    pop();
  }
}

Node edgeStartNode=null;
Node edgeEndNode=null;

void edgeUpdate(){
  //생성
  if(nodeSelectedNum == 1)
  {
    for(Node node:nodeArr)
    {
      if(node.selected ==1)
      {
        edgeStartNode = node;
      }
    }
  }
  else if(nodeSelectedNum == 2)
  {
    for(Node node:nodeArr)
    {
      if(node.selected ==1)
      {
        node.selected = 0;
        node.connected = 1;
        nodeSelectedNum --;
        if(node!=edgeStartNode) edgeEndNode = node;
      }
    }
    edgeArr.add(new Edge(edgeStartNode,edgeEndNode));
  }
  
  for(Edge edge:edgeArr)
  {
    edge.update();
    edge.show();
  }
  
}

class EdgeComparator implements Comparator<Edge> {
    @Override
    public int compare(Edge e1, Edge e2) {
        if (e1.distance > e2.distance) {
            return 1;
        } else if (e1.distance < e2.distance) {
            return -1;
        }
        return 0;
    }
}

void sortEdge(){
    Collections.sort(edgeArr, new EdgeComparator().reversed());
}
 
