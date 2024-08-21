void drawSemisphere(float radius, float theta) {
  int detail = 100;
  noStroke();
  
  for (int j = 0; j <= detail / 2; j++) {
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i <= detail; i++) {
      float lat = map(j, 0, detail / 2, -PI, -0.05);
      float lon = map(i, 0, detail, -PI, -PI+theta);
      float px = radius * sin(lat) * cos(lon);
      float py = radius * sin(lat) * sin(lon);
      float pz = radius * cos(lat);
      vertex(px, py, pz);
      
      lat = map(j + 1, 0, detail / 2, -PI, -0.05);
      px = radius * sin(lat) * cos(lon);
      py = radius * sin(lat) * sin(lon);
      pz = radius * cos(lat);
      vertex(px, py, pz);
    }
    endShape();
  }
}
