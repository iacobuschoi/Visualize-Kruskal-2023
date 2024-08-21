import java.util.Collections;
import java.util.Comparator;

float fps = 60;
float frame = 0;
float setupTime = 0;
int kruskalNum = 0;
int finish = 1;
Origin origin;

void setup(){
  fullScreen(P3D);
  origin = new Origin(800+width-900,100,0,50);
  frameRate(fps);
  //ortho();
}

void draw(){
  //init
  if(setupTime == 0) setupTime = millis();
  background(100);
  noStroke();
  nodeActivate = 0;
  frame++;
  if(kruskalNum!=nodeCnt-1){
    finish = 0;
  }
  
  //origin
  origin.show();
  
  push();
  ortho();
  mouse.show();
  perspective();
  pop();
  
  //info
  textSize(20);
  push();
  fill(255);
  //text(RX,10,20);
  //text(RY,10,40);
  //text(width,10,60);
  //text(projX(),110,20);
  //text(projY(),110,40);
  //text(projZ(),110,60);
  //text((millis()-setupTime)*0.001,10,100);
  //text(setupTime*0.001,10,80);
  //text(frame/fps,10,120);
  //text(nodeSelectedNum,210,20);
  //text(nodeCnt,210,40);
  pop();
  
  //window
  updateKruskalEdge();
  if(windowInd!=null){
    windowInd.update();
    windowInd.show();
  }
  
  push();
  fill(255);
  rotateView();
  
  //light
  lightFalloff(1.0, 0.001, 0.0);
  directionalLight(126, 126, 126, 100, 100, -100);
  ambientLight(102, 102, 102);
  
  //select node
  for(Node node: nodeArr){
    node.isOnMouse();
  }
  
  //delet node
  Node removeNode=null;
  for(Node node:nodeArr){
    if(node.deletTimerOn == 1 && node.deletTimer>node.deletTime)
    {
      node.beta_0 = 0;
    }
    if(node.beta_0 == 0 && node.beta <0.01)
    {
      removeNode = node;
      if(node.selected == 1) nodeSelectedNum --;
    }
  }
  if(removeNode!=null) nodeCnt--;
  nodeArr.remove(removeNode);
  
  //draw node
  for(Node node: nodeArr){
    node.update();
    node.show();
  }
  
  //draw edge
  edgeUpdate();
  
  //kruskal
  kruskal.update();
  kruskal.show();

  pop();
  
  //saveFrame("E:/1934/result-#####.png");
}

void mouseClicked(){
  if(nodeActivate == 0)
  {
    nodeArr.add(new Node(projX(),projY(),projZ(),30));
  }
  for(Node node : nodeArr)
  {
    if(node.select == 1)
    {
      if(node.selected == 0)
      {
        node.selected = 1;
        nodeSelectedNum ++;
      }
      else if(node.selected ==1)
      {
        node.selected = 0;
        nodeSelectedNum --;
      }
    }
  }
}

void keyPressed(){
  if(key=='m'){
    moveMode =1;
  }
  if(key=='g'){
    moveMode = 0;
  }
  
  if(key =='i'){
    initKruskalEdge();
    windowInd = new WindowInd();
    for(Edge edge : edgeArr){
      edge.inv = 1;
    }
  }
  
  if(key == 'u'&&kruskalNum!=nodeCnt-1){
    if(windowInd != null&&edgeArr.get(edgeCnt-1).kruskal == 1)
    {
      windowInd.ind--;
      windowInd.cycleDetected = 0;
      if(windowInd.ind == -1)
      {
        windowInd.ind = edgeCnt-1;
      }
    }
    kruskal.unionEdgeArrClass = null;
    windowInd.abeta = 0;
    windowInd.abeta_1 = 0;
  }
  
}

UnionEdge unionEdge = null;
  
