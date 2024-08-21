void drawCylinder(float x1, float y1, float z1, float x2, float y2, float z2, float radius) {
  float dx = x2 - x1;
  float dy = y2 - y1;
  float dz = z2 - z1;
  
  float height = pow(dx*dx+dy*dy+dz*dz,0.5);
  
  dx/=height;
  dy/=height;
  dz/=height;
  
  float bx = -dy;
  float by = dx;
  float bz = 0;
  if(dx==0 && dy == 0)
  {
    bx = -dz;
    by = 0;
    bz = dx;
  }
  
  height = pow(bx*bx+by*by+bz*bz,0.5);
  
  bx/=height;
  by/=height;
  bz/=height;
  
  
  float cx = by*dz-bz*dy;
  float cy = bz*dx-bx*dz;
  float cz = bx*dy-by*dx;
  
  int detail = 50;
  
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= detail; i++) {
    float angle = map(i, 0, detail, 0, TWO_PI);
    vertex(x1+radius*bx*cos(angle)+radius*cx*sin(angle),y1+radius*by*cos(angle)+radius*cy*sin(angle),z1+radius*bz*cos(angle)+radius*cz*sin(angle));
    vertex(x2+radius*bx*cos(angle)+radius*cx*sin(angle),y2+radius*by*cos(angle)+radius*cy*sin(angle),z2+radius*bz*cos(angle)+radius*cz*sin(angle));
  }
  endShape();
}
