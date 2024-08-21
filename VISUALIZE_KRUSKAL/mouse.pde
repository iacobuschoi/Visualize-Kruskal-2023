class Mouse{
  Mouse(){}
  
  void show(){
    push();
    translate(mouseX,mouseY);
    fill(255);
    stroke(0);
    beginShape();
    vertex(0,0);
    vertex(0,17);
    vertex(5,14);
    vertex(8,19);
    vertex(10,18);
    vertex(8,13);
    vertex(12,13);
    endShape();
    noStroke();
    pop();
  }
}

Mouse mouse = new Mouse();
    
    
