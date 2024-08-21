//뷰 회전 인식 영역
float rotateArea = 0.8; 

//각도
float RX=0;
float RY=0;

//각속도
float dx=0;
float dy=0;

float arctan()//마우스의 화면 중심으로부터의 각도를 0~2PI로 반환
{
  float x = mouseX-width/2==0?0.01:mouseX-width/2; //div 0 error 방지
  float y = height/2 - mouseY;
  
  float tan = atan(y/x);
  
  if(x>0)
  {
    if(y>0) return tan;
    else return tan+2*PI;
  }
  return tan+PI;
}


int isInRotate()//뷰 회전 활성화 여부 반환
{
  float r = rotateArea; //회전 인식 범위
  if(mouseX>width*r||mouseX<width*(1-r)||mouseY<height*(1-r)||mouseY>height*r) return 1;
  return 0;
}

void rotateView()//뷰 각도 업데이트
{
  float ang = arctan();
  float x = mouseX - width/2;//디스플레이 상의 x좌표
  float y = height/2 - mouseY;//디스플레이 상의 y좌표
  float w = width*(rotateArea-0.5);
  float h = height*(rotateArea-0.5);
  float ax = 0; //x 회전 각속도
  float ay = 0; //y 회전 각속도
  float alphaX = 0.000005;//x감도
  float alphaY = 0.000003;//y감도  
  float ddxy = 0.95;//감쇄율
  
  if(isInRotate()==1)//마우스가 뷰 회전 활성화 영역에 있을 경우 가속도 초기화
  {
    if(ang>=1.75*PI || ang<=0.25*PI)
    {
      ax = x-w;
      ay = y-w*tan(ang);
    }
    else if(ang>=0.25*PI && ang<=0.75*PI)
    {
      ax = x+h*tan(ang-0.5*PI);
      ay = y-h;
    }
    else if(ang>=0.75*PI && ang<=1.25*PI)
    {
      ax = x+w;
      ay = y+w*tan(ang-PI);
    }
    else
    {
      ax = x-h*tan(ang-1.5*PI);
      ay = y+h;
    }
  }
  dx+=ax*alphaX;//x 각속도 변경
  dy+=ay*alphaY;//y 각속도 변경
    
  dx*=ddxy;//x 각속도 감쇄
  dy*=ddxy;//y 각속도 감쇄
    
  RY -= dx;//x 각도 계산
  RX -= dy;//y 각도 계산
  
  //X 축 회전 제한
  if(RX>0.6) RX=0.6;
  if(RX<-0.6) RX=-0.6;
  
  //디스플레이 중심 기준 회전
  translate(width/2,height/2);
  rotateX(RX);
  rotateY(RY);
}

//디스플레이에 투영되는 점의 원점 통과 평면상의 3차원 좌표
float projX(){
  float x = mouseX-width/2;
  float y = height/2-mouseY;
  return x*cos(RY)-sin(RY)*sin(RX)*y;
}
float projY(){
  float x = mouseX-width/2;
  float y = height/2-mouseY;
  return -cos(RX)*y;
}
float projZ(){
  float x = mouseX-width/2;
  float y = height/2-mouseY;
  return x*sin(RY)+cos(RY)*sin(RX)*y;
}

//공간 좌표를 화면상의 좌표로 projection한 좌표를 반환
float[] proj(float x, float y, float z){
  float[] a = {cos(RY)*x+sin(RY)*z,-sin(RX)*sin(RY)*x-cos(RX)*y+cos(RY)*sin(RX)*z};
  return a;
}
  

////테스트 코드
//void setup(){
//  size(900,900,P3D);
//  ganBox(100);
//}

//void draw()
//{
//  //init
//  background(0);
  
//  //info
//  textSize(20);
//  push();
//  fill(255);
//  text(RX,10,20);
//  text(RY,10,40);
//  text(projX(),10,60);
//  text(projY(),10,80);
//  text(projZ(),10,100);
//  pop();
  
//  push();
//  fill(255);
//  rotateView();
//  lightFalloff(1.0, 0.001, 0.0);
//  directionalLight(126, 126, 126, 100, 100, -100);
//  ambientLight(102, 102, 102);
//  drawBox();
//  translate(projX(),projY(),projZ());
//  sphere(100);
//  pop();
//}


//class ob{
//  float x,y,z,size;
  
//  ob(float x, float y, float z, float size)
//  {
//    this.x=x;
//    this.y=y;
//    this.z=z;
//    this.size=size;
//  }
    
//}

//ArrayList<ob> obArr = new ArrayList<ob>();

//void ganBox(int n){
//  while(n-->0)
//  {
//    obArr.add(new ob(random(-300,300),random(-300,300),random(-300,300),random(10,30)));
//  }
//}

//void drawBox()
//{
//  for(ob bo  : obArr)
//  {
//    translate(bo.x,bo.y,bo.z);
//    noStroke();
//    sphere(bo.size);
//    translate(-bo.x,-bo.y,-bo.z);
//  }
//}
