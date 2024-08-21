class Timer{
  float time_0;
  float time = 0;
  float on = 0;
  
  Timer(){
    this.time_0 = millis();
  }
  
  void init(){
    this.time_0 = millis();
    this.time= 0;
  }
  
  void update(){
    this.time = millis() - time_0;
  }
}
