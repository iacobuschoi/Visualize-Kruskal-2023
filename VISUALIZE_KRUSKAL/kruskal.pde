Kruskal kruskal = new Kruskal();

class Kruskal{
  float[][] adjMat = new float[1000][1000];
  int[] visit = new int[1000]; 
  UnionEdgeArr unionEdgeArrClass = null;
  
  Kruskal(){
    for(int i = 0; i<1000;i++){
      for(int j = 0; j<1000; j++){
        this.adjMat[i][j] = 0;
      }
    }
  }
  
  void update(){
    if(this.unionEdgeArrClass != null){
      this.unionEdgeArrClass.update();
    }
  }
  
  void show(){
    if(this.unionEdgeArrClass != null){
      this.unionEdgeArrClass.show();
    }
  }
  
  void init(){
    for(int i = 0; i<1000; i++){
      this.visit[i] = 0;
    }
  }
  
  ArrayList<Integer> dfs(int s, int e){
    this.visit[s] = 1;
    
    if(s==e){
      ArrayList<Integer> ans = new ArrayList<Integer>();
      ans.add(e);
      return ans;
    }
    
    for(int i = 0; i<1000; i++){
      if(this.adjMat[s][i] == 1 && this.visit[i] == 0){
        ArrayList<Integer> now = dfs(i,e);
        if(now!= null){
          now.add(s);
          return now;
        }
      }
    }
    return null;
  }
  
  void addEdge(){
    this.adjMat[kruskalEdgeArr.get(windowInd.ind).s][kruskalEdgeArr.get(windowInd.ind).e] = 1;
    this.adjMat[kruskalEdgeArr.get(windowInd.ind).e][kruskalEdgeArr.get(windowInd.ind).s] = 1;
    edgeArr.get(windowInd.ind).kruskal = 1;
    kruskalEdgeArr.get(windowInd.ind).isKruskal = 1;
    nodeArr.get(indNode(kruskalEdgeArr.get(windowInd.ind).s)).kruskal = 1;
    nodeArr.get(indNode(kruskalEdgeArr.get(windowInd.ind).e)).kruskal = 1;
    kruskalNum++;
  }
  
  void findCycle(){
    ArrayList<Integer> nodeList = this.dfs(kruskalEdgeArr.get(windowInd.ind).s,kruskalEdgeArr.get(windowInd.ind).e);
    this.init();
    if(nodeList != null){
      ArrayList<UnionEdge> unionEdgeArr = new ArrayList<UnionEdge>();
      for(int i = 0; i<nodeList.size();i++){
        unionEdgeArr.add(new UnionEdge(nodeArr.get(indNode(nodeList.get(i))),nodeArr.get(indNode(nodeList.get((i+1)%nodeList.size())))));
      }
      this.unionEdgeArrClass = new UnionEdgeArr(unionEdgeArr);
      windowInd.cycleDetected = 1;
    }
    else{
      this.addEdge();
    }
  }
}
  
  
  
