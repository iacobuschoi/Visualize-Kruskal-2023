float dt = 1/fps;
int nodeNum = 0;
int nodeCnt = 0;
int nodeMoving = 0;
int moveMode = 0;
int nodeActivate = 0;
int nodeSelectedNum = 0;

ArrayList<Node> nodeArr = new ArrayList<Node>();

class Node{
  float x,y,z,size;//노드의 크기 = size*beta
  int kruskal = 0;
  
  //생성 이팩트 관련 상수
  //감쇄 진동 미분 방정식 beta_2 = -a*(beta-1) - b*beta_1
  float a = 200;
  float b = 12;
  float beta_0 = 1;
  float beta = 0;
  float beta_1 = 0;
  float beta_2 = a;
  
  int ind;//노드 번호
  int connected = 0;//간선 연결 정보
  int select = 0;
  int selected = 0;
  
  //node move 관련 변수
  int moving = 0;
  
  //삭제 이팩트 관련 변수
  int deletTimerOn = 0;
  int lastDeletTimerOn = 0;
  float deletTimer = 0;
  float deletTime = 1500;
  
  
  Node(float x, float y, float z, float size)
  {
    this.x=x;
    this.y=y;
    this.z=z;
    this.size=size;
    this.ind = nodeNum++;
    nodeCnt++;
  }
  
  void update(){
    //생성 이팩트
    this.beta += dt*this.beta_1;
    this.beta_1 += dt*this.beta_2;
    this.beta_2 = -this.a*(this.beta-this.beta_0) -this.b*this.beta_1;
    
    //이팩트 적용
    if(moveMode == 1)
    {
      isDragged();
      if(this.moving == 1) moveNode();
    }
    if(this.connected==0)this.deletEffect();
    if(this.selected == 1)
    {
      this.SelectedEffect();
    }
    else if(this.select ==0)
    {
      this.beta_0=1;
    }
    else if(this.select == 1)
    {
      this.OnMouseEffect();
    }
  }
  
  void show(){
    push();
    translate(this.x,this.y,this.z);
    fill(255,255,255-255*this.kruskal);
    sphere(this.size*this.beta);
    if(this.deletTimerOn == 1){
      fill(255, 0, 0, 150);
      drawSemisphere(this.size*this.beta*1.1,2*PI*(this.deletTimer>150?(this.deletTimer-150)/( this.deletTime-150):0));
    }
    if(this.selected == 1){
      fill(0, 0, 255,100+50*sin(frame/fps*PI*2.5));
      drawSemisphere(this.size*this.beta*1.05, 2*PI);
    }
    pop();
  }
  
  void moveNode(){
    this.x = projX();
    this.y = projY();
    this.z = projZ();
  }
  
  void isDragged(){
    if(this.select ==1 && mousePressed==true &&  nodeMoving == 0){
      nodeMoving = 1;
      this.moving = 1;
    }
    else if(this.moving == 1&&mousePressed == false){
      this.moving = 0;
      nodeMoving = 0;
    }
  }
  
  void isOnMouse()//마우스가 노드 위에 놓였을 때 select = 1로 표시
  {
    float[] point = perspectiveProjection(this.x,this.y,this.z);
    if(pow(point[0]-(mouseX-width/2),2)+pow(point[1]-(height/2-mouseY),2)<pow(this.size,2)*1.5)
    {
      if(nodeActivate==0)
      {
        this.select = 1;
        nodeActivate = 1;
      }
      else
      {
        this.select = 0;
      }
    }
    else
    {
      this.select = 0;
    }
  }
  
  void OnMouseEffect()//마우스가 노드 위에 놓였을 때 이팩트
  {
    this.beta_0 = 1.2;
  }
  
  void SelectedEffect()//노드가 선택되었을 때 이팩트
  {
    this.beta_0=1.0+0.2*this.select; //<>//
  }      
  
  void deletEffect()
  {
    this.lastDeletTimerOn = this.deletTimerOn;
    if(mousePressed)
    {
      if(this.select == 1)// && this.selected == 0)
      {
        this.deletTimerOn = 1;
      }
      else//이 else문 끄면 동시에 여러 노드 제거, 제거중인 노드에서 마우스 치워도 제거 가능
      {
        this.deletTimerOn = 0;
      }
    }
    else
    {
      this.deletTimerOn = 0;
    }
    
    if(this.lastDeletTimerOn != this.deletTimerOn)
    {
      mousePressedTime = millis();
    }
    this.deletTimer = getMousePressedTime();
  }
}


int indNode(int num){
  for(int i = 0; i<nodeNum; i++){
    if(nodeArr.get(i).ind == num) return i;
  }
  return 1000;
}
